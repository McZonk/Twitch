#import <Foundation/Foundation.h>

#import "TwitchAuthorization.h"


@interface TwitchClientIdentifierAuthorization : NSObject <TwitchAuthorization>

- (instancetype)initWithClientIdentifier:(NSString *)clientIdentifier;

@end
