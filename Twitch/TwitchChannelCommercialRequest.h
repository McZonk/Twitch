#import "TwitchURLRequest.h"


typedef NS_ENUM(NSUInteger, TwitchChannelCommercialLength) {
	TwitchChannelCommercialLength30Seconds = 30,
	TwitchChannelCommercialLength60Seconds = 60,
	TwitchChannelCommercialLength90Seconds = 90,
};


@interface TwitchChannelCommercialRequest : TwitchURLRequest

- (instancetype)initWithChannel:(NSString *)channel length:(TwitchChannelCommercialLength)length;

@end
