#import "NSURLComponents+TwitchQueryComponents.h"


@implementation NSURLComponents (TwitchQueryComponents)

- (NSDictionary *)twitch_queryComponents
{
	NSArray *queryItems = self.queryItems;
	
	NSMutableDictionary *queryComponents = [NSMutableDictionary dictionaryWithCapacity:queryItems.count];
	for(NSURLQueryItem *queryItem in queryItems)
	{
		NSString *name = queryItem.name;
		if(name.length > 0)
		{
			NSString *value = queryItem.value;
			queryComponents[name] = value;
		}
	}
	return queryComponents;
}

@end
