//
//  TwitchTests.m
//  TwitchTests
//
//  Created by Maximilian Christ on 25/09/14.
//  Copyright (c) 2014 McZonk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "TwitchChannelRequest.h"
#import "TwitchChannelResponse.h"
#import "TwitchIngest.h"
#import "TwitchIngestRequest.h"
#import "TwitchIngestResponse.h"
#import "TwitchOAuth2Authorization.h"
#import "TwitchOAuth2Request.h"
#import "TwitchOAuth2Response.h"
#import "TwitchScope.h"
#import "TwitchURLConnection.h"

#import "TwitchAuth.h"


@interface TwitchTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation TwitchTests

- (void)setUp
{
	[super setUp];
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	queue.name = @"OperationQueue";
	queue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
	self.queue = queue;
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testIngest
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];

	TwitchIngestRequest *request = [[TwitchIngestRequest alloc] init];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_main_queue() completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil);
		XCTAssert([response isKindOfClass:TwitchIngestResponse.class]);
		
		TwitchIngestResponse *ingestResponse = (TwitchIngestResponse *)response;
		
		XCTAssert(ingestResponse.ingests.count > 0);
		
		TwitchIngest *ingest = ingestResponse.ingests.firstObject;
		
		XCTAssert(ingest.name != nil);
		XCTAssert(ingest.templateURL != nil);
		XCTAssert(ingest.identifier > 0);
		XCTAssert(ingest.availability >= 0.0);
		
		[expectation fulfill];

	}];
	[self.queue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

#if !defined(TWITCH_TESTS_OAUTH_CODE) || !defined(TWITCH_TESTS_CLIENT_IDENTIFIER) || !defined(TWITCH_TESTS_CLIENT_SECRET) || !defined(TWITCH_TESTS_OAUTH_REDIRECT_URL)
#warning skipping testOAuth2Token
#else
- (void)testOAuth2Token
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	NSArray *scopes = @[
//		TwitchScopeUserRead,
//		TwitchScopeUserBlocksEdit,
//		TwitchScopeUserBlocksRead,
//		TwitchScopeUserFollowsEdit,
		TwitchScopeChannelRead,
//		TwitchScopeChannelEditor,
		TwitchScopeChannelCommercial,
//		TwitchScopeChannelStream,
//		TwitchScopeChannelSubscriptions,
//		TwitchScopeUserSubscriptions,
//		TwitchScopeChannelCheckSubscription,
//		TwitchScopeChatLogin,
	];
	NSURL *URL = [TwitchOAuth2Request authorizationURLWithClientIdentifier:TWITCH_TESTS_CLIENT_IDENTIFIER redirectURL:TWITCH_TESTS_OAUTH_REDIRECT_URL scopes:scopes];

	NSLog(@"%@", URL);
	
	[NSWorkspace.sharedWorkspace openURL:URL];
	
#if 0
	TwitchOAuth2Request *request = [[TwitchOAuth2Request alloc] initWithCode:TWITCH_TESTS_OAUTH_CODE clientIdentifer:TWITCH_TESTS_CLIENT_IDENTIFIER clientSecret:TWITCH_TESTS_CLIENT_SECRET redirectURL:TWITCH_TESTS_OAUTH_REDIRECT_URL];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(TwitchURLResponse *response, NSError *error) {

		XCTAssert(response != nil);
		XCTAssert(error == nil);
		XCTAssert([response isKindOfClass:TwitchOAuth2Response.class]);
		
		TwitchOAuth2Response *OAuth2Response = (TwitchOAuth2Response *)response;
		
		XCTAssert(OAuth2Response.accessToken != nil);
		XCTAssert(OAuth2Response.refreshToken != nil);
		
		[expectation fulfill];
	}];
	[self.queue addOperation:connection];

	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
#endif
}
#endif

#if !defined(TWITCH_TESTS_OAUTH_ACCESS_TOKEN)
#warning skipping testOwnChannel
#else
- (void)testOwnChannel
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];

	TwitchOAuth2Authorization *auth = [[TwitchOAuth2Authorization alloc] initWithAccessToken:TWITCH_TESTS_OAUTH_ACCESS_TOKEN];
	
	TwitchChannelRequest *request = [[TwitchChannelRequest alloc] initWithAuthorization:auth];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_main_queue() completionHandler:^(TwitchURLResponse *response, NSError *error) {
		
		XCTAssert(response != nil);
		XCTAssert(error == nil);
		XCTAssert([response isKindOfClass:TwitchChannelResponse.class]);
		
		TwitchChannelResponse *channelResponse = (TwitchChannelResponse *)response;
		
		XCTAssert(channelResponse.streamKey != nil);

		[expectation fulfill];
	}];
	[self.queue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}
#endif

- (void)testPublicChannel
{
	XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __FUNCTION__]];
	
	TwitchChannelRequest *request = [[TwitchChannelRequest alloc] initWithUser:@"amazHS"];
	
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_main_queue() completionHandler:^(TwitchURLResponse *response, NSError *error) {

		XCTAssert(response != nil);
		XCTAssert(error == nil);
		XCTAssert([response isKindOfClass:TwitchChannelResponse.class]);
		
		[expectation fulfill];
	}];
	[self.queue addOperation:connection];
	
	[self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
		[connection cancel];
	}];
}

@end
