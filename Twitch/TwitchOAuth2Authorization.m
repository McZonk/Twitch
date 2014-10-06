#import "TwitchOAuth2Authorization.h"


@interface TwitchOAuth2Authorization ()

@property (nonatomic, strong) NSString *accessToken;

@end


@implementation TwitchOAuth2Authorization

- (instancetype)initWithAccessToken:(NSString *)accessToken
{
	NSParameterAssert(accessToken);
	
	self = [super init];
	if(self != nil)
	{
		self.accessToken = accessToken;
	}
	return self;
}

- (BOOL)apply:(NSMutableURLRequest *)request
{
	NSParameterAssert(request);
	
	NSString *value = [NSString stringWithFormat:@"OAuth %@", self.accessToken];
	[request setValue:value forHTTPHeaderField:@"Authorization"];
	
	return YES;
}

@end
