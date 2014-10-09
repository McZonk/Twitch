#import "TwitchChannelRequest.h"

#import "TwitchChannelResponse.h"


@interface TwitchChannelRequest ()

@property (nonatomic, copy) NSString *user;

@end


@implementation TwitchChannelRequest

- (instancetype)initWithUser:(NSString *)user
{
	self = [super init];
	if(self != nil)
	{
		self.user = user;
	}
	return self;
}

- (Class)responseClass
{
	return TwitchChannelResponse.class;
}

- (NSURL *)URL
{
	NSString *user = self.user;
	if(user != nil)
	{
		return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channels/%@", user]];
	}
	else
	{
		return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channel"]];
	}
}

@end
