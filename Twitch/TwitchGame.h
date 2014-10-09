#import <Foundation/Foundation.h>


@interface TwitchGame : NSObject

- (instancetype)initWithJSON:(NSDictionary *)JSON error:(NSError **)error;

@property (nonatomic, assign, readonly) long long identifier;
@property (nonatomic, assign, readonly) long long giantbombIdentifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *boxTemplateURL;
@property (nonatomic, copy, readonly) NSURL *logoTemplateURL;
@property (nonatomic, assign, readonly) long long popularity;

@end
