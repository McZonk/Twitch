#import "TwitchJSONRequest.h"

@interface TwitchOAuth2Request : TwitchJSONRequest

- (instancetype)initWithCode:(NSString *)code clientIdentifer:(NSString *)clientIdentifier clientSecret:(NSString *)clientSecret redirectURL:(NSURL*)redirectURL;

@end
