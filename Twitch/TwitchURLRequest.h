#import <Foundation/Foundation.h>

#import "TwitchAuthorization.h"


@interface TwitchURLRequest : NSObject

+ (NSString *)URLEncodedStringWithParameters:(NSDictionary *)parameters;
+ (NSData *)URLEncodedDataWithParameters:(NSDictionary *)parameters;

- (instancetype)init;

- (Class)responseClass;

- (NSURL *)URL;

- (NSMutableURLRequest *)URLRequest;

@end
