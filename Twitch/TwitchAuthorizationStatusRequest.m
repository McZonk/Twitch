#import "TwitchAuthorizationStatusRequest.h"

#import "TwitchAuthorizationStatusResponse.h"


@implementation TwitchAuthorizationStatusRequest

- (Class)responseClass
{
	return TwitchAuthorizationStatusResponse.class;
}

- (NSURL *)URL
{
	return [NSURL URLWithString:@"https://api.twitch.tv/kraken/"];
}

@end
