#import "TwitchURLConnection.h"

#import "NSHTTPURLResponse+TwitchHeaderFields.h"
#import "TwitchURLRequest.h"
#import "TwitchURLResponse.h"


@interface TwitchURLConnection () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (assign) BOOL isExecuting;
@property (assign) BOOL isFinished;

@property (copy) TwitchURLConnectionCompletionHandler completionHandler;
@property (copy) TwitchURLConnectionProgressHandler progressHandler;

// only accessed in the NSURL Connection thread
@property (nonatomic, strong) NSURLConnection *URLConnection;
@property (nonatomic, strong) NSHTTPURLResponse *URLResponse;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSNumber *contentLength;

// only set in init
@property (nonatomic, strong) TwitchURLRequest *request;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) id<NSLocking> lock;

@end



@implementation TwitchURLConnection

+ (NSThread *)connectionThread
{
	static NSThread *thread = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		thread = [[NSThread alloc] initWithTarget:self selector:@selector(connectionThreadMain:) object:nil];
		[thread start];
	});
	
	return thread;
}

+ (void)connectionThreadMain:(id)object
{
	@autoreleasepool
	{
		NSThread.currentThread.name = @"TwitchConnectionThread";
		
		NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
		[runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
		[runLoop run];
	}
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
	return [self initWithRequest:request queue:queue progressHandler:nil completionHandler:completionHandler];
}

- (instancetype)initWithRequest:(TwitchURLRequest *)request queue:(dispatch_queue_t)queue progressHandler:(TwitchURLConnectionProgressHandler)progressHandler completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler
{
	self = [super init];
	if(self != nil)
	{
		self.request = request;
		
		if(queue == nil)
		{
			queue = dispatch_get_main_queue();
		}
		self.queue = queue;
		
		self.completionHandler = completionHandler;
		self.progressHandler = progressHandler;
		
		self.lock = [[NSRecursiveLock alloc] init];
	}
	return self;
}

- (void)dealloc
{
	
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
		
		[self performSelector:@selector(startURLConnection) onThread:self.class.connectionThread withObject:nil waitUntilDone:NO modes:@[ NSDefaultRunLoopMode ]];
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
		self.progressHandler = nil;
		
		[super cancel];
		
		if(self.isExecuting)
		{
			// only when we are already executing, we are allowed to cancel the connection, otherwise an exception might occur. This will also result in the following but already cancelled operatations of be started, but the first check in start check if the operation is cancelled.
			[self performSelector:@selector(cancelURLConnection) onThread:self.class.connectionThread withObject:nil waitUntilDone:NO modes:@[ NSDefaultRunLoopMode ]];
		}
	}
	
	[lock unlock];
}

- (void)finish
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	self.completionHandler = nil;
	self.progressHandler = nil;
	
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

- (void)startURLConnection
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	if(!self.isCancelled)
	{
		TwitchURLRequest *request = self.request;
		
		NSMutableURLRequest *URLRequest = request.URLRequest;
		
		NSURLConnection *URLConnection = [[NSURLConnection alloc] initWithRequest:URLRequest delegate:self startImmediately:NO];
		self.URLConnection = URLConnection;
		
		NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
		
		[URLConnection scheduleInRunLoop:runLoop forMode:NSDefaultRunLoopMode];
		
		[URLConnection start];
	}
	
	[lock unlock];
}

- (void)cancelURLConnection
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	NSURLConnection *URLConnection = self.URLConnection;
	if(URLConnection != nil)
	{
		[URLConnection cancel];
		
		[URLConnection unscheduleFromRunLoop:NSRunLoop.currentRunLoop forMode:NSDefaultRunLoopMode];
		self.URLConnection = nil;
	}
	
	self.URLResponse = nil;
	self.data = nil;
	
	[self finish];
	
	[lock unlock];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p URL:%@>", self.class, self, self.request.URL];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	TwitchURLConnectionCompletionHandler completionHandler = self.completionHandler;
	if(completionHandler != nil)
	{
		dispatch_async(self.queue, ^{
			completionHandler(nil, error);
		});
	}
	
	[self cancelURLConnection];
}

#pragma mark - NSURLConnectionDataDelegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response_
{
	NSHTTPURLResponse *response = (NSHTTPURLResponse *)response_;
	
	NSNumber *contentlength = response.twitch_contentLength;
	self.contentLength = contentlength;
	
	self.URLResponse = (NSHTTPURLResponse *)response;
	self.data = [NSMutableData dataWithCapacity:contentlength.unsignedIntegerValue];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)newData
{
	NSMutableData *data = self.data;
	[data appendData:newData];
	
	TwitchURLConnectionProgressHandler progressHandler = self.progressHandler;
	if(progressHandler != nil)
	{
		NSNumber *contentLength = self.contentLength;
		if(contentLength != nil)
		{
			long long contentLengthValue = contentLength.longLongValue;
			if(contentLengthValue != 0)
			{
				float progress = data.length / (float)contentLengthValue;
				
				dispatch_async(self.queue, ^{
					progressHandler(progress);
				});
			}
		}
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	TwitchURLRequest *request = self.request;
	TwitchURLResponse *response = nil;
	NSError *error = nil;
	
	// HTTP response OK with content
	NSInteger statusCode = self.URLResponse.statusCode;
	if(statusCode >= 200 && statusCode <= 299)
	{
		Class responseClass = request.responseClass;
		response = [[responseClass alloc] initWithData:self.data error:&error];
		
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
		});
	}
	
	[self cancelURLConnection];
}

@end
