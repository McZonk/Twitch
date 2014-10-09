#import "TwitchAccessTokenAuthorization.h"


@interface TwitchAccessTokenAuthorization ()

@property (nonatomic, copy) NSString *clientIdentifier;
@property (nonatomic, copy) NSString *accessToken;

@end


@implementation TwitchAccessTokenAuthorization

- (instancetype)initWithClientIdentifier:(NSString *)clientIdentifier accessToken:(NSString *)accessToken
{
	self = [super init];
	if(self != nil)
	{
		self.clientIdentifier = clientIdentifier;
		self.accessToken = accessToken;
	}
	return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
	return [[TwitchAccessTokenAuthorization alloc] initWithClientIdentifier:self.clientIdentifier accessToken:self.accessToken];
}

- (NSDictionary *)HTTPHeaders
{
	return @{
		//@"Client-ID": self.clientIdentifier,
		@"Authorization": [NSString stringWithFormat:@"OAuth %@", self.accessToken],
	};
}

@end
