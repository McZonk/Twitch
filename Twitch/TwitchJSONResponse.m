#import "TwitchJSONResponse.h"


@interface TwitchJSONResponse ()

@property (nonatomic, copy) NSDictionary *JSON;

@end


@implementation TwitchJSONResponse

- (instancetype)initWithData:(NSData *)data error:(NSError **)error
{
	id JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
	if(JSON == nil)
	{
		return nil;
	}
	
	return [self initWithJSON:JSON error:error];
}

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		self.JSON = JSON;
		
		NSLog(@"%@", JSON);
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p JSON:%@>", self.class, self, self.JSON];
}

@end
