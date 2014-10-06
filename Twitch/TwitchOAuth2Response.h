#import "TwitchJSONResponse.h"

@interface TwitchOAuth2Response : TwitchJSONResponse

@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, copy, readonly) NSArray *scopes;

@end
