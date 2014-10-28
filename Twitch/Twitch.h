//
//  Twitch.h
//  Twitch
//
//  Created by Maximilian Christ on 25/09/14.
//  Copyright (c) 2014 McZonk. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for Twitch.
FOUNDATION_EXPORT double TwitchVersionNumber;

//! Project version string for Twitch.
FOUNDATION_EXPORT const unsigned char TwitchVersionString[];

#import "NSHTTPURLResponse+TwitchHeaderFields.h"
#import "NSURLComponents+TwitchQueryComponents.h"

#import "TwitchURLConnection.h"
#import "TwitchURLConnection+SharedAuthorization.h"
#import "TwitchURLConnection+SharedOperationQueue.h"
#import "TwitchURLRequest.h"
#import "TwitchURLResponse.h"

#import "TwitchJSONRequest.h"
#import "TwitchJSONResponse.h"

#import "TwitchChannelCommercialRequest.h"
#import "TwitchChannelRequest.h"
#import "TwitchChannelResponse.h"
#import "TwitchChannelUpdateRequest.h"

#import "TwitchIngest.h"
#import "TwitchIngestsRequest.h"
#import "TwitchIngestsResponse.h"

#import "TwitchOAuth2Request.h"
#import "TwitchOAuth2Response.h"
#import "TwitchScope.h"
#import "TwitchAuthorizationStatusRequest.h"
#import "TwitchAuthorizationStatusResponse.h"

#import "TwitchAuthorization.h"
#import "TwitchClientIdentifierAuthorization.h"
#import "TwitchAccessTokenAuthorization.h"

#import "TwitchGame.h"
#import "TwitchSearchGamesRequest.h"
#import "TwitchSearchGamesResponse.h"
