#import <Foundation/Foundation.h>

@class TwitchURLRequest;
@class TwitchURLResponse;
@protocol TwitchAuthorization;


typedef void(^TwitchURLConnectionCompletionHandler)(TwitchURLResponse *response, NSError *error);


@interface TwitchURLConnection : NSOperation

- (instancetype)initWithRequest:(TwitchURLRequest *)request queue:(dispatch_queue_t)queue completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler;

- (instancetype)initWithRequest:(TwitchURLRequest *)request authorization:(id<TwitchAuthorization>)authorization queue:(dispatch_queue_t)queue completionHandler:(TwitchURLConnectionCompletionHandler)completionHandler;

@end
