#import "TwitchJSONResponse.h"

@interface TwitchOAuthResponse : TwitchJSONResponse

@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, copy, readonly) NSArray *scopes;

@end
