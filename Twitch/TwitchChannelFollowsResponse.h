#import <Twitch/Twitch.h>


@interface TwitchChannelFollowsResponse : TwitchJSONResponse

@property (nonatomic, assign, readonly) NSUInteger totalFollowerCount;
@property (nonatomic, copy, readonly) NSArray *followers;

@end
