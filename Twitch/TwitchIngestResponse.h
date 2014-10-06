#import "TwitchJSONResponse.h"


@interface TwitchIngestResponse : TwitchJSONResponse

@property (nonatomic, copy, readonly) NSArray *ingests;

@end
