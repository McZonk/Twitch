//
//  TwitchStreamingAPITest.m
//  Twitch
//
//  Created by Maximilian Christ on 07/10/14.
//  Copyright (c) 2014 McZonk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "Twitch.h"

#import "TwitchAuth.h"


@interface TwitchStreamingAPITest : XCTestCase

@end


@implementation TwitchStreamingAPITest

- (void)setUp
{
    [super setUp];

	TwitchURLConnection.sharedAuthorization = [[TwitchAccessTokenAuthorization alloc] initWithClientIdentifier:TWITCH_TESTS_CLIENT_IDENTIFIER accessToken:TWITCH_TESTS_ACCESS_TOKEN];
}

- (void)tearDown
{
	TwitchURLConnection.sharedAuthorization = nil;
	
	[super tearDown];
}

- (void)testAuthorizationStatus
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	TwitchAuthorizationStatusRequest *request = [[TwitchAuthorizationStatusRequest alloc] init];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:nil completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchAuthorizationStatusResponse.class]);
		
		TwitchAuthorizationStatusResponse *authorizationStatusResponse = (TwitchAuthorizationStatusResponse *)response;
		
		XCTAssert(authorizationStatusResponse.username != nil);
		XCTAssert([authorizationStatusResponse.scopes containsObject:@"channel_read"]);
		XCTAssert([authorizationStatusResponse.scopes containsObject:@"channel_editor"]);
		XCTAssert([authorizationStatusResponse.scopes containsObject:@"channel_commercial"]);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

- (void)testOwnChannel
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	TwitchChannelRequest *request = [[TwitchChannelRequest alloc] init];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_main_queue() completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchChannelResponse.class]);
		
		TwitchChannelResponse *channelResponse = (TwitchChannelResponse *)response;
		
		XCTAssert(channelResponse.name != nil);
		XCTAssert(channelResponse.streamKey != nil);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

#if defined(TWITCH_TESTS_CHANNEL)
- (void)testUpdateOwnChannel
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	NSString *game = @"Hearthstone: Heroes of Warcraft";
	NSString *status = @"Playing a game";
	
	TwitchChannelUpdateRequest *request = [[TwitchChannelUpdateRequest alloc] initWithChannel:TWITCH_TESTS_CHANNEL status:status game:game];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_main_queue() completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchChannelResponse.class]);
		
		TwitchChannelResponse *channelResponse = (TwitchChannelResponse *)response;
		
		XCTAssertEqualObjects(channelResponse.status, status);
		XCTAssertEqualObjects(channelResponse.game, game);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}
#endif

#if 0 // only works when channel is live
#if defined(TWITCH_TESTS_CHANNEL)
- (void)testCommercial
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	TwitchChannelCommercialRequest *request = [[TwitchChannelCommercialRequest alloc] initWithChannel:TWITCH_TESTS_CHANNEL length:TwitchChannelCommercialLength30Seconds];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_main_queue() completionHandler:^(TwitchURLResponse *response, NSError *error) {
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}
#endif
#endif

@end
