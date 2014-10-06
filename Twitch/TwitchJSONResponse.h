#import "TwitchURLResponse.h"

@interface TwitchJSONResponse : TwitchURLResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error;

@property (nonatomic, copy, readonly) NSDictionary *JSON;

@end
