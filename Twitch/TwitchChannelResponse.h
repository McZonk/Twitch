#import "TwitchJSONResponse.h"

@interface TwitchChannelResponse : TwitchJSONResponse

@property (nonatomic, assign, readonly) long long identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *game;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *login;
@property (nonatomic, copy, readonly) NSString *streamKey;
@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *logo;
@property (nonatomic, copy, readonly) NSURL *banner;
@property (nonatomic, copy, readonly) NSURL *videoBanner;
@property (nonatomic, copy, readonly) NSURL *background;
@property (nonatomic, assign, readonly) BOOL mature;
@property (nonatomic, copy, readonly) NSDate *creationDate;
@property (nonatomic, copy, readonly) NSDate *updateDate;

@end
