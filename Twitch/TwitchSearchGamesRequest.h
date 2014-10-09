#import <Twitch/Twitch.h>


@interface TwitchSearchGamesRequest : TwitchJSONRequest

- (instancetype)initWithQuery:(NSString *)query live:(BOOL)live;

@end
