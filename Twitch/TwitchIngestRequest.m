#import "TwitchIngestRequest.h"

#import "TwitchIngestResponse.h"


@implementation TwitchIngestRequest

- (instancetype)init
{
	NSURL *URL = [NSURL URLWithString:@"https://api.twitch.tv/kraken/ingests"];
	return [super initWithURL:URL authorization:nil];
}

- (Class)responseClass
{
	return TwitchIngestResponse.class;
}

@end
