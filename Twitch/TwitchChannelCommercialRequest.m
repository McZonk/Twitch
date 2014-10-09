#import "TwitchChannelCommercialRequest.h"

#import "TwitchAuthorization.h"


@interface TwitchChannelCommercialRequest ()

@property (nonatomic, copy) NSString *channel;
@property (nonatomic, assign) TwitchChannelCommercialLength length;

@end


@implementation TwitchChannelCommercialRequest

- (instancetype)initWithChannel:(NSString *)channel length:(TwitchChannelCommercialLength)length
{
	self = [super init];
	if(self != nil)
	{
		self.channel = channel;
		self.length = length;
	}
	return self;
}

- (NSURL *)URL
{
	NSString *channel = self.channel;
	return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channels/%@/commercial", channel]];
}

- (NSMutableURLRequest *)URLRequest
{
	NSMutableURLRequest *URLRequest = super.URLRequest;
	
	URLRequest.HTTPMethod = @"POST";

	NSDictionary *parameters = @{
		@"length": [NSString stringWithFormat:@"%ld", (long)self.length],
	};
	URLRequest.HTTPBody = [self.class URLEncodedDataWithParameters:parameters];
	
	return URLRequest;
}

@end
