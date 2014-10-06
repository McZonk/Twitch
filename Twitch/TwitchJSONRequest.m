#import "TwitchJSONRequest.h"

#import "TwitchJSONResponse.h"


@implementation TwitchJSONRequest

+ (NSString *)acceptValue
{
	return @"application/vnd.twitchtv.v2+json";
}

- (Class)responseClass
{
	return TwitchJSONResponse.class;
}

- (NSMutableURLRequest *)URLRequest
{
	NSMutableURLRequest *URLRequest = super.URLRequest;
	
	[URLRequest addValue:self.class.acceptValue forHTTPHeaderField:@"Accept"];
	
	return URLRequest;
}

@end
