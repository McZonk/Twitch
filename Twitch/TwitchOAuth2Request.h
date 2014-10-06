#import "TwitchJSONRequest.h"

@interface TwitchOAuth2Request : TwitchJSONRequest

+ (NSURL *)authorizationURLWithClientIdentifier:(NSString *)clientIdentifier redirectURL:(NSURL *)redirectURL scopes:(NSArray *)scopes;

- (instancetype)initWithCode:(NSString *)code clientIdentifer:(NSString *)clientIdentifier clientSecret:(NSString *)clientSecret redirectURL:(NSURL*)redirectURL;

@end
