#import "TwitchIngestsResponse.h"

#import "TwitchIngest.h"


@interface TwitchIngestsResponse ()

@property (nonatomic, copy) NSArray *ingests;

@end


@implementation TwitchIngestsResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSArray *JSONIngests = JSON[@"ingests"];
		if([JSONIngests isKindOfClass:NSArray.class])
		{
			NSMutableArray *ingests = [[NSMutableArray alloc] initWithCapacity:JSONIngests.count];
			for(NSDictionary *JSONIngest in JSONIngests)
			{
				NSError *ingestError = nil;
			
				TwitchIngest *ingest = [[TwitchIngest alloc] initWithJSON:JSONIngest error:&ingestError];
				if(ingest != nil)
				{
					[ingests addObject:ingest];
				}
				else
				{
					// TODO: error
				}
			}
		
			self.ingests = ingests;
		}
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p ingests:%@>", self.class, self, self.ingests];
}

@end
