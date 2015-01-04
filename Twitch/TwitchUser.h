#import <Foundation/Foundation.h>


@interface TwitchUser : NSObject

- (instancetype)initWithJSON:(NSDictionary *)JSON;

@property (nonatomic, assign, readonly) long long identifier;
@property (nonatomic, strong, readonly) NSString *accountName;
@property (nonatomic, strong, readonly) NSString *displayName;

@end
