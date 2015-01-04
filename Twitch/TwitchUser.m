#import "TwitchUser.h"


@interface TwitchUser ()

@property (nonatomic, assign) long long identifier;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *displayName;

@end


@implementation TwitchUser

- (instancetype)initWithJSON:(NSDictionary *)JSON
{
	self = [super init];
	if(self != nil)
	{
		NSNumber *identifier = JSON[@"_id"];
		if([identifier isKindOfClass:NSNumber.class])
		{
			self.identifier = identifier.longLongValue;
		}
		
		NSString *accountName = JSON[@"name"];
		if([accountName isKindOfClass:NSString.class])
		{
			self.accountName = accountName;
		}
		
		NSString *displayName = JSON[@"display_name"];
		if([displayName isKindOfClass:NSString.class])
		{
			self.displayName = displayName;
		}
	}
	return self;
}

@end
