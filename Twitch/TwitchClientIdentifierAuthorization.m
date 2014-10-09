#import "TwitchClientIdentifierAuthorization.h"


@interface TwitchClientIdentifierAuthorization ()

@property (nonatomic, copy) NSString *clientIdentifier;

@end


@implementation TwitchClientIdentifierAuthorization

- (instancetype)initWithClientIdentifier:(NSString *)clientIdentifier
{
	self = [super init];
	if(self != nil)
	{
		self.clientIdentifier = clientIdentifier;
	}
	return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
	return [[TwitchClientIdentifierAuthorization alloc] initWithClientIdentifier:self.clientIdentifier];
}

- (NSDictionary *)HTTPHeaders
{
	return @{
		@"Client-ID": self.clientIdentifier,
	};
}

@end
