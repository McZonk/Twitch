#import "TwitchIngestsRequest.h"

#import "TwitchIngestsResponse.h"


@implementation TwitchIngestsRequest

- (Class)responseClass
{
	return TwitchIngestsResponse.class;
}

- (NSURL *)URL
{
	return [NSURL URLWithString:@"https://api.twitch.tv/kraken/ingests"];
}

@end
