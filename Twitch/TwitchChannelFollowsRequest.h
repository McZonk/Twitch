#import <Twitch/Twitch.h>


@interface TwitchChannelFollowsRequest : TwitchJSONRequest

- (instancetype)initWithChannel:(NSString *)channel limit:(NSUInteger)limit;

- (instancetype)initWithChannel:(NSString *)channel limit:(NSUInteger)limit offset:(NSUInteger)offset;

@property (nonatomic, strong, readonly) NSString *channel;
@property (nonatomic, assign, readonly) NSUInteger offset;
@property (nonatomic, assign, readonly) NSUInteger limit;

@end
