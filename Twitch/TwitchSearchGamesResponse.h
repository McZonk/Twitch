#import <Twitch/Twitch.h>

#import "TwitchGame.h"


@interface TwitchSearchGamesResponse : TwitchJSONResponse

@property (nonatomic, copy, readonly) NSArray *games;

@end
