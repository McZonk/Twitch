#import "TwitchGame.h"

@interface TwitchGame ()

@property (nonatomic, assign) long long identifier;
@property (nonatomic, assign) long long giantbombIdentifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *boxTemplateURL;
@property (nonatomic, copy) NSURL *logoTemplateURL;
@property (nonatomic, assign) long long popularity;

@end


@implementation TwitchGame

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
		
		NSNumber *giantbombIdentifier = JSON[@"giantbomb_id"];
		if([giantbombIdentifier isKindOfClass:NSNumber.class])
		{
			self.giantbombIdentifier = giantbombIdentifier.longLongValue;
		}
		
		NSString *name = JSON[@"name"];
		if([name isKindOfClass:NSString.class])
		{
			self.name = name;
		}
		
		NSString *boxTemplate = [JSON valueForKey:@"box.template"];
		if([boxTemplate isKindOfClass:NSString.class])
		{
			self.boxTemplateURL = [NSURL URLWithString:boxTemplate];
		}
		
		NSString *logoTemplate = [JSON valueForKey:@"logo.template"];
		if([logoTemplate isKindOfClass:NSString.class])
		{
			self.logoTemplateURL = [NSURL URLWithString:logoTemplate];
		}
		
		NSNumber *popularity = JSON[@"popularity"];
		if([popularity isKindOfClass:NSNumber.class])
		{
			self.popularity = popularity.longLongValue;
		}
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p identifier:%lld name:%@>", self.class, self, self.identifier, self.name];
}

@end
