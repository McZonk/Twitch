#import "TwitchOAuth2Response.h"


@interface TwitchOAuth2Response ()

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSArray *scopes;

@end


@implementation TwitchOAuth2Response

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSString *accessToken = JSON[@"access_token"];
		if(![accessToken isKindOfClass:NSString.class])
		{
			// TODO: error handling
			return nil;
		}
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
