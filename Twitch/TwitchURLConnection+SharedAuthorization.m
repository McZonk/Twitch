#import "TwitchURLConnection+SharedAuthorization.h"

#import "TwitchAuthorization.h"


static id<TwitchAuthorization> sharedAuthorization = nil;


@implementation TwitchURLConnection (SharedAuthorization)

+ (id<TwitchAuthorization>)sharedAuthorization
{
	@synchronized(self)
	{
		return sharedAuthorization;
	}
}

+ (void)setSharedAuthorization:(id<TwitchAuthorization>)authorization
{
	@synchronized(self)
	{
		sharedAuthorization = [authorization copyWithZone:nil];
	}
}

@end
