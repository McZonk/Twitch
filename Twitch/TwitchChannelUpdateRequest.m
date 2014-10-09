#import "TwitchChannelUpdateRequest.h"

#import "TwitchChannelResponse.h"


@interface TwitchChannelUpdateRequest ()

@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *game;

@end


@implementation TwitchChannelUpdateRequest

- (instancetype)initWithChannel:(NSString *)channel status:(NSString *)status game:(NSString *)game
{
	self = [super init];
	if(self != nil)
	{
		self.channel = channel;
		self.status = status;
		self.game = game;
	}
	return self;
}

- (Class)responseClass
{
	return TwitchChannelResponse.class;
}

- (NSURL *)URL
{
	NSString *channel = self.channel;
	return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channels/%@", channel]];
}

- (NSMutableURLRequest *)URLRequest
{
	NSMutableURLRequest *URLRequest = super.URLRequest;
	
	NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
	NSString *status = self.status;
	if(status != nil)
	{
		parameters[@"channel[status]"] = status;
	}
	NSString *game = self.game;
	if(game != nil)
	{
		parameters[@"channel[game]"] = game;
	}
	
	URLRequest.HTTPMethod = @"PUT";
	URLRequest.HTTPBody = [self.class URLEncodedDataWithParameters:parameters];
	[URLRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

	return URLRequest;
}

@end
