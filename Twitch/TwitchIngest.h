#import <Foundation/Foundation.h>

@interface TwitchIngest : NSObject

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) BOOL isDefault;
@property (nonatomic, assign, readonly) long identifier;
@property (nonatomic, copy, readonly) NSString *templateURL;
@property (nonatomic, assign, readonly) float availability;

- (NSURL *)URLWithStreamKey:(NSString *)streamKey;

@end
