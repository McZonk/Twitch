#import "TwitchOAuthResponse.h"


@interface TwitchOAuthResponse ()

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSArray *scopes;

@end


@implementation TwitchOAuthResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSString *accessToken = JSON[@"access_token"];
		if(accessToken == nil)
		{
			// TODO: error handling
			return nil;
		}
		NSLog(@"%@", accessToken);
		self.accessToken = accessToken;
		
		NSString *refreshToken = JSON[@"refresh_token"];
		self.refreshToken = refreshToken;
		
		NSArray *scopes = JSON[@"scope"];
		self.scopes = scopes;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p accessToken:%@ refreshToken:%@ scopes:%@>", self.class, self, self.accessToken != nil ? @"***" : nil, self.refreshToken != nil ? @"***" : nil, self.scopes];
}

@end
