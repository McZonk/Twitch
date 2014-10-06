#import <Foundation/Foundation.h>

@protocol TwitchAuthorization <NSObject>
@required

- (BOOL)apply:(NSMutableURLRequest *)request;

@end
