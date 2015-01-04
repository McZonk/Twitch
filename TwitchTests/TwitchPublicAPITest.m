//
//  TwitchPublicAPITest.m
//  Twitch
//
//  Created by Maximilian Christ on 07/10/14.
//  Copyright (c) 2014 McZonk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "Twitch.h"

#import "TwitchAuth.h"


@interface TwitchPublicAPITest : XCTestCase

@end


@implementation TwitchPublicAPITest

- (void)setUp
{
    [super setUp];
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

		XCTAssert(authorizationStatusResponse.username == nil);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

- (void)testIngests
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	TwitchIngestsRequest *request = [[TwitchIngestsRequest alloc] init];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:nil completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchIngestsResponse.class]);
		
		TwitchIngestsResponse *ingestResponse = (TwitchIngestsResponse *)response;
		
		NSArray *ingests = ingestResponse.ingests;
		
		XCTAssert(ingests.count > 0);
		
		TwitchIngest *ingest = ingests.firstObject;
		
		XCTAssert(ingest.name != nil);
		XCTAssert(ingest.URLTemplate != nil);
		XCTAssert(ingest.identifier > 0);
		XCTAssert(ingest.availability >= 0.0);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

- (void)testPublicChannel
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	NSString *user = @"amazHS";
	
	TwitchChannelRequest *request = [[TwitchChannelRequest alloc] initWithUser:user];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:nil completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchChannelResponse.class]);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

- (void)testSearchGames
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	NSString *query = @"Heart";
	
	TwitchSearchGamesRequest *request = [[TwitchSearchGamesRequest alloc] initWithQuery:query live:NO];
									  
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:nil completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchSearchGamesResponse.class]);
		
		TwitchSearchGamesResponse *gamesResponse = (TwitchSearchGamesResponse *)response;
		
		NSArray *games = gamesResponse.games;
		
		XCTAssert(games.count > 0);
		
		TwitchGame *game = games.firstObject;
		
		XCTAssert([game isKindOfClass:TwitchGame.class]);
		XCTAssert(game.name != nil);
		
		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

- (void)testChannelFollows
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	NSString *channel = @"amazhs";
	
	TwitchChannelFollowsRequest *request = [[TwitchChannelFollowsRequest alloc] initWithChannel:channel limit:10 offset:10];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:nil completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil, @"%@", error);
		XCTAssert([response isKindOfClass:TwitchChannelFollowsResponse.class]);
		
		TwitchChannelFollowsResponse *channelFollowsResponse = (TwitchChannelFollowsResponse *)response;
		
		XCTAssert(channelFollowsResponse.totalFollowerCount > 0);
		
		XCTAssert(channelFollowsResponse.followers.count > 0);
		
		TwitchFollower *follower = channelFollowsResponse.followers.firstObject;
		
		XCTAssert(follower != nil);
		XCTAssert(follower.user != nil);
		XCTAssert(follower.date != nil);

		[expectation fulfill];
	}];
	[TwitchURLConnection.sharedOperationQueue addOperation:connection];

	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

@end
