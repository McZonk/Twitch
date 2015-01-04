#import "TwitchChannelFollowsRequest.h"

#import "TwitchChannelFollowsResponse.h"


@interface TwitchChannelFollowsRequest ()

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, assign) NSUInteger offset;
@property (nonatomic, assign) NSUInteger limit;

@end


@implementation TwitchChannelFollowsRequest

- (instancetype)initWithChannel:(NSString *)channel limit:(NSUInteger)limit
{
	return [self initWithChannel:channel limit:limit offset:0];
}

- (instancetype)initWithChannel:(NSString *)channel limit:(NSUInteger)limit offset:(NSUInteger)offset
{
	self = [super init];
	if(self != nil)
	{
		self.channel = channel;
		self.offset = offset;
		self.limit = limit;
	}
	return self;
}

- (Class)responseClass
{
	return TwitchChannelFollowsResponse.class;
}

- (NSURL *)URL
{
	NSDictionary *parameters = @{
		@"offset": @(self.offset),
		@"limit": @(self.limit),
	};
	
	NSString *query = [self.class URLEncodedStringWithParameters:parameters];
	
	return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitch.tv/kraken/channels/%@/follows?%@", self.channel, query]];
}
@end
