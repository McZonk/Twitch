#import <Foundation/Foundation.h>

@class TwitchURLRequest;
@class TwitchURLResponse;


typedef void(^TwitchURLConnectionProgressHandler)(float progress);
typedef void(^TwitchURLConnectionCompletionHandler)(TwitchURLResponse *response, NSError *error);


@interface TwitchURLConnection : NSOperation

- (instancetype)initWithRequest:(TwitchURLRequest *)request queue:(dispatch_queue_t)queue completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler;

- (instancetype)initWithRequest:(TwitchURLRequest *)request queue:(dispatch_queue_t)queue progressHandler:(TwitchURLConnectionProgressHandler)progressHandler completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler;

@end
