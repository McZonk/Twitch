#import "TwitchSearchGamesResponse.h"


@interface TwitchSearchGamesResponse ()

@property (nonatomic, copy) NSArray *games;

@end


@implementation TwitchSearchGamesResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
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
	}
	return self;
}

@end
