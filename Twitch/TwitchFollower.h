#import <Foundation/Foundation.h>


@class TwitchUser;


@interface TwitchFollower : NSObject

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error;

@property (nonatomic, strong, readonly) TwitchUser *user;
@property (nonatomic, strong, readonly) NSDate *date;

@end
