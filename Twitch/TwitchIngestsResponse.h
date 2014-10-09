#import "TwitchJSONResponse.h"


@interface TwitchIngestsResponse : TwitchJSONResponse

@property (nonatomic, copy, readonly) NSArray *ingests;

@end
