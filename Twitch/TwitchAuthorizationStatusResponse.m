#import "TwitchAuthorizationStatusResponse.h"

@interface TwitchAuthorizationStatusResponse()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSArray *scopes;

@end

@implementation TwitchAuthorizationStatusResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSDictionary *token = JSON[@"token"];
		if([token isKindOfClass:NSDictionary.class])
		{
			NSString *username = token[@"user_name"];
			if([username isKindOfClass:NSString.class])
			{
				self.username = username;
			}
			
			NSDictionary *authorization = token[@"authorization"];
			if([authorization isKindOfClass:NSDictionary.class])
			{
				NSArray *scopes = authorization[@"scopes"];
				if([scopes isKindOfClass:NSArray.class])
				{
					self.scopes = scopes;
				}
			}
		}
	}
	return self;
}

@end
