//
//  TwitchLoginAPITest.m
//  Twitch
//
//  Created by Maximilian Christ on 07/10/14.
//  Copyright (c) 2014 McZonk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "Twitch.h"

#import "TwitchAuth.h"


@interface TwitchLoginAPITest : XCTestCase

@end


@implementation TwitchLoginAPITest

- (void)setUp
{
	[super setUp];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testAuthorizationURL {
	NSArray *scopes = @[
		TwitchScopeUserRead,
		TwitchScopeUserBlocksEdit,
		TwitchScopeUserBlocksRead,
		TwitchScopeUserFollowsEdit,
		TwitchScopeChannelRead,
		TwitchScopeChannelEditor,
		TwitchScopeChannelCommercial,
		TwitchScopeChannelStream,
		TwitchScopeChannelSubscriptions,
		TwitchScopeUserSubscriptions,
		TwitchScopeChannelCheckSubscription,
		TwitchScopeChatLogin,
	];
	NSURL *URL = [TwitchOAuth2Request authorizationURLWithClientIdentifier:TWITCH_TESTS_CLIENT_IDENTIFIER redirectURL:TWITCH_TESTS_OAUTH_REDIRECT_URL scopes:scopes];
	
	XCTAssert(URL != nil);
	
#if 0
	NSLog(@"%@", URL);
#endif
}

#if 0
- (void)testOAuthCode
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];

	TwitchOAuth2Request *request = [[TwitchOAuth2Request alloc] initWithCode:TWITCH_TESTS_OAUTH_CODE clientIdentifer:TWITCH_TESTS_CLIENT_IDENTIFIER clientSecret:TWITCH_TESTS_CLIENT_SECRET redirectURL:TWITCH_TESTS_OAUTH_REDIRECT_URL];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil);
		XCTAssert([response isKindOfClass:TwitchOAuth2Response.class]);
		
		TwitchOAuth2Response *OAuth2Response = (TwitchOAuth2Response *)response;
		
		XCTAssert(OAuth2Response.accessToken != nil);
		XCTAssert(OAuth2Response.refreshToken != nil);
		
		NSLog(@"Access Token: %@", OAuth2Response.accessToken);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}
#endif

@end
