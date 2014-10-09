#import "TwitchJSONResponse.h"


@interface TwitchAuthorizationStatusResponse : TwitchJSONResponse

@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSArray *scopes;

@end
