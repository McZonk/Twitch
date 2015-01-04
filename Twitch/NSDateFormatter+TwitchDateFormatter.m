#import "NSDateFormatter+TwitchDateFormatter.h"


@implementation NSDateFormatter (TwitchDateFormatter)

+ (instancetype)twitchDateFormatter
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
	dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
	return dateFormatter;
}

@end
