#import "TwitchChannelRequest.h"

#import "TwitchChannelResponse.h"


@implementation TwitchChannelRequest

- (instancetype)initWithUser:(NSString *)user
{
	NSParameterAssert(user);
	
	NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channels/%@", user]];
	return [self initWithURL:URL authorization:nil];
}

- (instancetype)initWithAuthorization:(id<TwitchAuthorization>)authorization
{
	NSParameterAssert(authorization);

	NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channel"]];
	return [self initWithURL:URL authorization:authorization];
}

- (Class)responseClass
{
	return TwitchChannelResponse.class;
}

@end
