#import <Foundation/Foundation.h>

@protocol TwitchAuthorization <NSObject, NSCopying>
@required

- (NSDictionary *)HTTPHeaders;

@end

