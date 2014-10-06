#import <Foundation/Foundation.h>

#import "TwitchAuthorization.h"


@interface TwitchOAuth2Authorization : NSObject <TwitchAuthorization>

- (instancetype)initWithAccessToken:(NSString *)accessToken;

@end
