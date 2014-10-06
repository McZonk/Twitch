#import <Foundation/Foundation.h>


@interface TwitchURLResponse : NSObject

- (instancetype)initWithData:(NSData *)data error:(NSError **)error;

@property (nonatomic, copy, readonly) NSData *data;

@end
