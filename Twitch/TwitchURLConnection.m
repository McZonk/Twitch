#import "TwitchURLConnection.h"

#import "NSHTTPURLResponse+TwitchHeaderFields.h"
#import "TwitchAuthorization.h"
#import "TwitchURLConnection+SharedAuthorization.h"
#import "TwitchURLRequest.h"
#import "TwitchURLResponse.h"


@interface TwitchURLConnection () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (assign) BOOL isExecuting;
@property (assign) BOOL isFinished;

@property (copy) TwitchURLConnectionCompletionHandler completionHandler;

// only set in init
@property (nonatomic, strong) TwitchURLRequest *request;
@property (nonatomic, copy) id<TwitchAuthorization> authorization;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) id<NSLocking> lock;

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end


@implementation TwitchURLConnection

+ (NSURLSession *)URLSession
{
	static NSURLSession *URLSession = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
		
		URLSession = [NSURLSession sessionWithConfiguration:configuration];
	});
	
	return URLSession;
}

+ (BOOL)automaticallyNotifiesObserversOfIsExecuting
{
	return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfIsFinished
{
	return NO;
}

- (instancetype)initWithRequest:(TwitchURLRequest *)request queue:(dispatch_queue_t)queue completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler
{
	id<TwitchAuthorization> authorization = TwitchURLConnection.sharedAuthorization;
	
	return [self initWithRequest:request authorization:authorization queue:queue completionHandler:completionHandler];
}

- (instancetype)initWithRequest:(TwitchURLRequest *)request authorization:(id<TwitchAuthorization>)authorization queue:(dispatch_queue_t)queue completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler
{
	self = [super init];
	if(self != nil)
	{
		self.request = request;
		self.authorization = authorization;
		
		if(queue == nil)
		{
			queue = dispatch_get_main_queue();
		}
		self.queue = queue;
		
		self.completionHandler = completionHandler;
		
		self.lock = [[NSRecursiveLock alloc] init];
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"%s %@", __FUNCTION__, self.request);
}

- (BOOL)isConcurrent
{
	return YES;
}

- (void)start
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	// do not call [super start], it will call [self main].
	
	if(self.isCancelled)
	{
		// a connection might already be cancelled. This will happen when a lot of operations are cancelled at the same time. this method, not the cancel method must clean up. otherwise there will be an exception
		[self finish];
	}
	else
	{
		// ensure the operation is in executing state first so cancel can be handled correctly. The lock will ensure there is no race condition.
		[self willChangeValueForKey:@"isExecuting"];
		self.isExecuting = YES;
		[self didChangeValueForKey:@"isExecuting"];
		
		NSMutableURLRequest *URLRequest = self.request.URLRequest;
		
		id<TwitchAuthorization> authorization = self.authorization;
		NSDictionary *HTTPHeaders = authorization.HTTPHeaders;
		for(NSString *key in HTTPHeaders)
		{
			if([URLRequest valueForHTTPHeaderField:key] == nil)
			{
				NSString *value = HTTPHeaders[key];
				[URLRequest setValue:value forHTTPHeaderField:key];
			}
		}
		
		NSURLSession *URLSession = self.class.URLSession;
		__weak typeof(self) weakself = self;
		NSURLSessionDataTask *task = [URLSession dataTaskWithRequest:URLRequest completionHandler:^(NSData *data, NSURLResponse *URLResponse, NSError *error) {
			typeof(self) self = weakself;
			if(self == nil)
			{
				return;
			}
			
			TwitchURLRequest *request = self.request;
			TwitchURLResponse *response = nil;
			
			NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)URLResponse;
			
			NSInteger statusCode = HTTPResponse.statusCode;
			if(statusCode >= 200 && statusCode <= 299)
			{
				Class responseClass = request.responseClass;
				response = [[responseClass alloc] initWithData:data error:&error];
				
				if(response == nil && error == nil)
				{
					error = [NSError errorWithDomain:@"TODO" code:2 userInfo:nil];
				}
			}
			else
			{
				NSString *localizedDescription = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
				NSDictionary *userInfo = @{
					NSLocalizedDescriptionKey: localizedDescription,
				};
				error = [NSError errorWithDomain:NSURLErrorDomain code:statusCode userInfo:userInfo];
			}

			TwitchURLConnectionCompletionHandler completionHandler = self.completionHandler;
			if(completionHandler != nil)
			{
				dispatch_async(self.queue, ^{
					completionHandler(response, error);

					[self finish];
				});
			}

		}];
		self.task = task;
		
		[task resume];
	}
	[lock unlock];
}

- (void)cancel
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	if(!self.isCancelled && !self.isFinished)
	{
		self.completionHandler = nil;
		
		[super cancel];
		
		if(self.isExecuting)
		{
			[self.task cancel];
		}
		
		[self finish];
	}
	
	[lock unlock];
}

- (void)finish
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	self.completionHandler = nil;
	
	// ensure only the changed states will be changed. Setting isExecuting = NO when it is already NO will cause an exception when the connection was cancelled before.
	
	BOOL wasExecuting = self.isExecuting;
	BOOL wasFinished = self.isFinished;
	
	if(!wasFinished)
	{
		[self willChangeValueForKey:@"isFinished"];
	}
	if(wasExecuting)
	{
		[self willChangeValueForKey:@"isExecuting"];
	}
	
	self.isExecuting = NO;
	self.isFinished = YES;
	
	if(wasExecuting)
	{
		[self didChangeValueForKey:@"isExecuting"];
	}
	if(!wasFinished)
	{
		[self didChangeValueForKey:@"isFinished"];
	}
	
	[lock unlock];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p task:%@>", self.class, self, self.task];
}

@end
