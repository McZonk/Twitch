#import "TwitchSearchGamesRequest.h"

#import "TwitchSearchGamesResponse.h"


@interface TwitchSearchGamesRequest ()

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL live;

@end


@implementation TwitchSearchGamesRequest

- (instancetype)initWithQuery:(NSString *)query live:(BOOL)live
{
	self = [super init];
	if(self != nil)
	{
		self.query = query;
		self.type = @"suggest";
		self.live = live;
	}
	return self;
}

- (Class)responseClass
{
	return TwitchSearchGamesResponse.class;
}

- (NSURL *)URL
{
	NSDictionary *parameters = @{
		@"query": self.query,
		@"type": self.type,
		@"live": self.live ? @"true" : @"false",
	};
	
	NSString *query = [self.class URLEncodedStringWithParameters:parameters];
	
	return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/search/games?%@", query]];
}

@end
