#import "TwitchURLConnection.h"


@interface TwitchURLConnection (SharedAuthorization)

+ (id<TwitchAuthorization>)sharedAuthorization;
+ (void)setSharedAuthorization:(id<TwitchAuthorization>)authorization;

@end
