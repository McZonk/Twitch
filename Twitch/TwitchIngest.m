#import "TwitchIngest.h"


static NSString * const NameKey = @"name";
static NSString * const DefaultKey = @"default";
static NSString * const IdentifierKey = @"_id";
static NSString * const URLTemplateKey = @"url_template";
static NSString * const AvailabilityKey = @"availability";

static NSString * const StreamKeyToken = @"{stream_key}";


@interface TwitchIngest ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, assign) long identifier;
@property (nonatomic, copy) NSString *URLTemplate;
@property (nonatomic, assign) float availability;

@end


@implementation TwitchIngest

+ (NSURL *)URLWithTemplate:(NSString *)URLTemplate streamKey:(NSString *)streamKey
{
	if(URLTemplate == nil)
	{
		return nil;
	}
	
	if(streamKey == nil)
	{
		return nil;
	}
	
	return [NSURL URLWithString:[URLTemplate stringByReplacingOccurrencesOfString:StreamKeyToken withString:streamKey]];
}

- (instancetype)init
{
	return nil;
}

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		// required
		
		NSString *name = JSON[NameKey];
		if(![name isKindOfClass:NSString.class])
		{
			if(error != NULL)
			{
				*error = [NSError errorWithDomain:@"TODO" code:1 userInfo:nil];
			}
			else
			{
				NSLog(@"%s:%d name == nil", __FUNCTION__, __LINE__);
			}
			return nil;
		}
		self.name = name;
		
		NSNumber *identifier = JSON[IdentifierKey];
		if(![identifier isKindOfClass:NSNumber.class])
		{
			if(error != NULL)
			{
				*error = [NSError errorWithDomain:@"TODO" code:1 userInfo:nil];
			}
			else
			{
				NSLog(@"%s:%d identifier == nil", __FUNCTION__, __LINE__);
			}
			return nil;
		}
		self.identifier = identifier.longValue;
		
		NSString *URLTemplate = JSON[URLTemplateKey];
		if(![URLTemplate isKindOfClass:NSString.class])
		{
			if(error != NULL)
			{
				*error = [NSError errorWithDomain:@"TODO" code:1 userInfo:nil];
			}
			else
			{
				NSLog(@"%s:%d URLTemplate == nil", __FUNCTION__, __LINE__);
			}
			return nil;
		}
		self.URLTemplate = URLTemplate;
		
		// optional
		
		NSNumber *isDefault = JSON[DefaultKey];
		if([name isKindOfClass:NSNumber.class])
		{
			self.isDefault = isDefault.boolValue;
		}
		
		NSNumber *availabilityKey = JSON[AvailabilityKey];
		if([availabilityKey isKindOfClass:NSNumber.class])
		{
			self.availability = availabilityKey.floatValue;
		}
	}
	return self;
}

- (NSURL *)URLWithStreamKey:(NSString *)streamKey
{
	return [self.class URLWithTemplate:self.URLTemplate streamKey:streamKey];
}

- (void)updatePingWithCompletionHandler:(void(^)(NSNumber *ping))completionHandler
{

}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@ %p identifier:%ld name:'%@' URL:'%@'>", self.class, self, (long)self.identifier, self.name, self.URLTemplate];
}

@end
