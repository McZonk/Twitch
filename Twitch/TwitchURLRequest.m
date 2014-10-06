#import "TwitchURLRequest.h"

#import "TwitchURLResponse.h"

@interface TwitchURLRequest ()

@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, strong) id<TwitchAuthorization> authorization;

@end


@implementation TwitchURLRequest

+ (NSString *)URLEncodedStringWithParameters:(NSDictionary *)parameters
{
	NSMutableString *string = [NSMutableString string];
	for(NSString *key in parameters)
	{
		NSString *object = parameters[key];
		
		if(string.length > 0)
		{
			[string appendString:@"&"];
		}
		
		[string appendString:[key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		[string appendString:@"="];
		[string appendString:[object stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	}
	
	return string;
}

+ (NSData *)URLEncodedDataWithParameters:(NSDictionary *)parameters
{
	return [[self URLEncodedStringWithParameters:parameters] dataUsingEncoding:NSUTF8StringEncoding];
}

- (instancetype)initWithURL:(NSURL *)URL authorization:(id<TwitchAuthorization>)authorization
{
	self = [super init];
	if(self != nil)
	{
		self.URL = URL;
		self.authorization = authorization;
	}
	return self;
}

- (Class)responseClass
{
	return TwitchURLResponse.class;
}

- (NSMutableURLRequest *)URLRequest
{
	NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:self.URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
	
	[self.authorization apply:URLRequest];
	
	return URLRequest;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p %@>", self.class, self, self.URL];
}

@end
