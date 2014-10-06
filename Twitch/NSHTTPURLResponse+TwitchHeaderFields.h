#import <Foundation/Foundation.h>

@interface NSHTTPURLResponse (TwitchHeaderFields)

- (NSString *)twitch_contentType;
- (NSNumber *)twitch_contentLength;

@end
