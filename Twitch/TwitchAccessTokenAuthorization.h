#import <Foundation/Foundation.h>

#import "TwitchAuthorization.h"


@interface TwitchAccessTokenAuthorization : NSObject <TwitchAuthorization>

- (instancetype)initWithClientIdentifier:(NSString *)clientIdentifier accessToken:(NSString *)accessToken;

@end
