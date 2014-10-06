#import "TwitchURLResponse.h"

@interface TwitchURLResponse ()

@property (nonatomic, copy) NSData *data;

@end


@implementation TwitchURLResponse

- (instancetype)initWithData:(NSData *)data error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		self.data = data;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p data:%llu>", self.class, self, (unsigned long long)self.data.length];
}

@end
