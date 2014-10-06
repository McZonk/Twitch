#import "TwitchJSONRequest.h"


@interface TwitchChannelRequest : TwitchJSONRequest

- (instancetype)initWithUser:(NSString *)user;

- (instancetype)initWithAuthorization:(id<TwitchAuthorization>)authorization;

@end
