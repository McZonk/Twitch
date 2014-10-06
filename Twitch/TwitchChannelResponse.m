#import "TwitchChannelResponse.h"

@interface TwitchChannelResponse ()

@property (nonatomic, assign) long long identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *game;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *streamKey;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *logo;
@property (nonatomic, copy) NSURL *banner;
@property (nonatomic, copy) NSURL *videoBanner;
@property (nonatomic, copy) NSURL *background;
@property (nonatomic, assign) BOOL mature;
@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic, copy) NSDate *updateDate;

@end


@implementation TwitchChannelResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSNumber *identifier = JSON[@"_id"];
		if([identifier isKindOfClass:NSNumber.class])
		{
			self.identifier = identifier.longLongValue;
		}
		
		NSString *name = JSON[@"name"];
		if([name isKindOfClass:NSString.class])
		{
			self.name = name;
		}
		
		NSString *displayName = JSON[@"display_name"];
		if([displayName isKindOfClass:NSString.class])
		{
			self.displayName = displayName;
		}
		
		NSString *game = JSON[@"game"];
		if([game isKindOfClass:NSString.class])
		{
			self.game = game;
		}
		
		NSString *title = JSON[@"title"];
		if([title isKindOfClass:NSString.class])
		{
			self.title = title;
		}
		
		NSString *email = JSON[@"email"];
		if([email isKindOfClass:NSString.class])
		{
			self.email = email;
		}
		
		NSString *login = JSON[@"login"];
		if([login isKindOfClass:NSString.class])
		{
			self.login = login;
		}
		
		NSString *streamKey = JSON[@"stream_key"];
		if([streamKey isKindOfClass:NSString.class])
		{
			self.streamKey = streamKey;
		}
		
		NSString *URL = JSON[@"url"];
		if([URL isKindOfClass:NSString.class])
		{
			self.URL = [NSURL URLWithString:URL];
		}
		
		NSString *logo = JSON[@"logo"];
		if([logo isKindOfClass:NSString.class])
		{
			self.logo = [NSURL URLWithString:logo];
		}
		
		NSString *banner = JSON[@"banner"];
		if([banner isKindOfClass:NSString.class])
		{
			self.banner = [NSURL URLWithString:banner];
		}
		
		NSString *videoBanner = JSON[@"video_banner"];
		if([videoBanner isKindOfClass:NSString.class])
		{
			self.videoBanner = [NSURL URLWithString:videoBanner];
		}
		
		NSString *background = JSON[@"background"];
		if([background isKindOfClass:NSString.class])
		{
			self.background = [NSURL URLWithString:background];
		}
		
		NSNumber *mature = JSON[@"mature"];
		if([mature isKindOfClass:NSNumber.class])
		{
			self.mature = mature.boolValue;
		}

#if 0
		// TODO:
		NSString *creationDate = JSON[@"created_at"];
		if([creationDate isKindOfClass:NSstring.class])
		{
			// 2011-10-25T23:55:47Z
		}
#endif
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p identifer:%lld name:%@>", self.class, self, self.identifier, self.name];
}

@end
