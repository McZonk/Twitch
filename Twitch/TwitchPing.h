#import <Foundation/Foundation.h>


@interface TwitchPing : NSOperation

- (instancetype)initWithURL:(NSURL *)URL;

- (instancetype)initWithHost:(NSString *)host;

- (instancetype)initWithAddress:(NSData *)address;

@end
