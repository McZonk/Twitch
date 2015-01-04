#import "TwitchChannelFollowsResponse.h"

#import "TwitchChannelFollowsRequest.h"
#import "TwitchFollower.h"


@interface TwitchChannelFollowsResponse ()

@property (nonatomic, assign) NSUInteger totalFollowerCount;

@property (nonatomic, copy) NSArray *followers;

@end


@implementation TwitchChannelFollowsResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSNumber *total = JSON[@"_total"];
		if([total isKindOfClass:NSNumber.class])
		{
			self.totalFollowerCount = total.unsignedIntegerValue;
		}
		else
		{
			return nil;
		}
		
		NSArray *follows = JSON[@"follows"];
		if([follows isKindOfClass:NSArray.class])
		{
			NSMutableArray *followers = [NSMutableArray arrayWithCapacity:follows.count];
			
			for(NSDictionary *follow in follows)
			{
				if(![follow isKindOfClass:NSDictionary.class])
				{
					continue;
				}
				
				TwitchFollower *follower = [[TwitchFollower alloc] initWithJSON:follow error:nil];
				if(follower != nil)
				{
					[followers addObject:follower];
				}
			}
			
			self.followers = followers;
		}
		else
		{
			return nil;
		}
		
#if 0
		NSArray *JSONGames = JSON[@"games"];
		if([JSONGames isKindOfClass:NSArray.class])
		{
			NSMutableArray *games = [[NSMutableArray alloc] initWithCapacity:JSONGames.count];
			for(NSDictionary *JSONGame in JSONGames)
			{
				NSError *gameError = nil;
				
				TwitchGame *game = [[TwitchGame alloc] initWithJSON:JSONGame error:&gameError];
				if(games != nil)
				{
					[games addObject:game];
				}
				else
				{
					// TODO: error
				}
			}
			
			self.games = games;
		}
#endif
	}
	return self;
}

@end
