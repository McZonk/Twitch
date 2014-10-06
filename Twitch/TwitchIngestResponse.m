#import "TwitchIngestResponse.h"

#import "TwitchIngest.h"


static NSString * const IngestsKey = @"ingests";


@interface TwitchIngestResponse ()

@property (nonatomic, copy) NSArray *ingests;

@end


@implementation TwitchIngestResponse

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		NSArray *JSONIngests = JSON[IngestsKey];
		
		// TODO: error handling
		
		NSMutableArray *ingests = [[NSMutableArray alloc] initWithCapacity:JSONIngests.count];
		for(NSDictionary *JSONIngest in JSONIngests)
		{
			NSError *ingestError = nil;
			
			TwitchIngest *ingest = [[TwitchIngest alloc] initWithJSON:JSONIngest error:&ingestError];
			if(ingest == nil)
			{
				// TODO: error handling
			}
			else
			{
				[ingests addObject:ingest];
			}
		}
		
		self.ingests = ingests;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p ingests:%@>", self.class, self, self.ingests];
}

@end
