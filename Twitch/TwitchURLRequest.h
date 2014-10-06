#import <Foundation/Foundation.h>

#import "TwitchAuthorization.h"


@interface TwitchURLRequest : NSObject

+ (NSString *)URLEncodedStringWithParameters:(NSDictionary *)parameters;
+ (NSData *)URLEncodedDataWithParameters:(NSDictionary *)parameters;

- (instancetype)initWithURL:(NSURL *)URL authorization:(id<TwitchAuthorization>)authorization;

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, strong, readonly) id<TwitchAuthorization> authorization;

- (Class)responseClass;

- (NSMutableURLRequest *)URLRequest;

@end
