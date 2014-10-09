#import <Twitch/Twitch.h>

@interface TwitchChannelUpdateRequest : TwitchJSONRequest

- (instancetype)initWithChannel:(NSString *)channel status:(NSString *)status game:(NSString *)game;

@end
