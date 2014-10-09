#import "TwitchURLConnection+SharedOperationQueue.h"

@implementation TwitchURLConnection (SharedOperationQueue)

+ (NSOperationQueue *)sharedOperationQueue
{
	static NSOperationQueue *operationQueue = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		operationQueue = [[NSOperationQueue alloc] init];
		operationQueue.name = @"TwitchURLConnection";
	});
	
	return operationQueue;
}

@end
