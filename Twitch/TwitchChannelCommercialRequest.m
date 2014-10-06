#import "TwitchChannelCommercialRequest.h"

#import "TwitchAuthorization.h"


@interface TwitchChannelCommercialRequest ()

@property (nonatomic, copy) NSString *channel;
@property (nonatomic, assign) TwitchChannelCommercialLength length;

@end


@implementation TwitchChannelCommercialRequest

- (instancetype)initWithChannel:(NSString *)channel length:(TwitchChannelCommercialLength)length authorization:(id<TwitchAuthorization>)authorization
{
	NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channels/%@/commercial", channel]];
	
	self = [super initWithURL:URL authorization:authorization];
	if(self != nil)
	{
		self.length = length;
	}
	return self;
}

- (NSMutableURLRequest *)URLRequest
{
	NSDictionary *parameters = @{
		@"length": @(self.length),
	};
	
	NSMutableURLRequest *URLRequest = super.URLRequest;
	
	URLRequest.HTTPMethod = @"POST";
	URLRequest.HTTPBody = [self.class URLEncodedDataWithParameters:parameters];
	
	return URLRequest;
}

@end
