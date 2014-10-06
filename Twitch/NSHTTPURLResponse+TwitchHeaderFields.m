#import "NSHTTPURLResponse+TwitchHeaderFields.h"


@implementation NSHTTPURLResponse (TwitchHeaderFields)

- (NSString *)twitch_contentType
{
	return self.allHeaderFields[@"Content-Type"];
}

- (NSNumber *)twitch_contentLength
{
	NSString *value = self.allHeaderFields[@"Content-Length"];
	if(value == nil)
	{
		return nil;
	}
	
	NSScanner *scanner = [NSScanner scannerWithString:value];
	
	long long length = 0;
	if(![scanner scanLongLong:&length])
	{
		return nil;
	}
	
	return [NSNumber numberWithLongLong:length];
}

@end
