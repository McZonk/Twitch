#import "TwitchFollower.h"

#import "NSDateFormatter+TwitchDateFormatter.h"
#import "TwitchUser.h"


@interface TwitchFollower ()

@property (nonatomic, strong) TwitchUser *user;
@property (nonatomic, strong) NSDate *date;

@end


@implementation TwitchFollower

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSDictionary *JSONUser = JSON[@"user"];
		if(![JSONUser isKindOfClass:NSDictionary.class])
		{
			// TODO: error
			return nil;
		}
		
		TwitchUser *user = [[TwitchUser alloc] initWithJSON:JSONUser];
		if(user == nil)
		{
			// TODO: error
			return nil;
		}
		
		self.user = user;
		
		NSString *dateJSON = JSON[@"created_at"];
		
		NSDateFormatter *twitchDateFormatter = NSDateFormatter.twitchDateFormatter;
		NSDate *date = [twitchDateFormatter dateFromString:dateJSON];
		if(date == nil)
		{
			// TODO: error
			return nil;
		}

		self.date = date;
	}
	return self;
}

@end
