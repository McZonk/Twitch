#import <Foundation/Foundation.h>

@interface TwitchIngest : NSObject

+ (NSURL *)URLWithTemplate:(NSString *)URLTemplate streamKey:(NSString *)streamKey;

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) BOOL isDefault;
@property (nonatomic, assign, readonly) long identifier;
@property (nonatomic, copy, readonly) NSString *URLTemplate;
@property (nonatomic, assign, readonly) float availability;

- (NSURL *)URLWithStreamKey:(NSString *)streamKey;

@end
