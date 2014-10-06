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
#import "TwitchIngestRequest.h"
#import "TwitchIngestResponse.h"
#import "TwitchOAuth2Request.h"
#import "TwitchURLConnection.h"
#import "TwitchOAuth2Authorization.h"

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
	TwitchIngestRequest *request = [[TwitchIngestRequest alloc] init];
	
	dispatch_group_t group = dispatch_group_create();
	dispatch_group_enter(group);
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(TwitchURLResponse *response, NSError *error) {
		NSLog(@"%@ %@ %@", request, response, error);
		
		dispatch_group_leave(group);
	}];
	[self.queue addOperation:connection];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)testOAuth2Token
{
#if !defined(TWITCH_TESTS_OAUTH_CODE) || !defined(TWITCH_TESTS_CLIENT_IDENTIFIER) || !defined(TWITCH_TESTS_CLIENT_SECRET) || !defined(TWITCH_TESTS_OAUTH_REDIRECT_URL)
#warning skipping testOAuth2Token
#else
	NSString *code = TWITCH_TESTS_OAUTH_CODE;
	NSString *clientIdentifer = TWITCH_TESTS_CLIENT_IDENTIFIER;
	NSString *clientSecret = TWITCH_TESTS_CLIENT_SECRET;
	NSURL *redirectURL = TWITCH_TESTS_OAUTH_REDIRECT_URL;
	
	TwitchOAuth2Request *request = [[TwitchOAuth2Request alloc] initWithCode:code clientIdentifer:clientIdentifer clientSecret:clientSecret redirectURL:redirectURL];
	
	dispatch_group_t group = dispatch_group_create();
	dispatch_group_enter(group);
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(TwitchURLResponse *response, NSError *error) {
		NSLog(@"%@ %@ %@", request, response, error);
		
		dispatch_group_leave(group);
	}];
	[self.queue addOperation:connection];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
#endif
}

- (void)testOwnChannel
{
#if !defined(TWITCH_TESTS_OAUTH_ACCESS_TOKEN)
#warning skipping testOwnChannel
#else
	TwitchOAuth2Authorization *auth = [[TwitchOAuth2Authorization alloc] initWithAccessToken:TWITCH_TESTS_OAUTH_ACCESS_TOKEN];
	
	TwitchChannelRequest *request = [[TwitchChannelRequest alloc] initWithAuthorization:auth];
	
	dispatch_group_t group = dispatch_group_create();
	dispatch_group_enter(group);
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(TwitchURLResponse *response, NSError *error) {
		NSLog(@"%@ %@ %@", request, response, error);
		
		dispatch_group_leave(group);
	}];
	[self.queue addOperation:connection];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
#endif
}

- (void)testChannel
{
	TwitchChannelRequest *request = [[TwitchChannelRequest alloc] initWithUser:@"amazHS"];
	
	dispatch_group_t group = dispatch_group_create();
	dispatch_group_enter(group);
	TwitchURLConnection *connection = [[TwitchURLConnection alloc] initWithRequest:request queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(TwitchURLResponse *response, NSError *error) {
		NSLog(@"%@ %@ %@", request, response, error);
		
		dispatch_group_leave(group);
	}];
	[self.queue addOperation:connection];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
