#import "TwitchOAuth2Request.h"

#import "TwitchOAuth2Response.h"

@interface TwitchOAuth2Request ()

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *clientIdentifier;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, copy) NSURL *redirectURL;

@end


@implementation TwitchOAuth2Request

+ (NSURL *)authorizationURLWithClientIdentifier:(NSString *)clientIdentifier redirectURL:(NSURL *)redirectURL scopes:(NSArray *)scopes
{
	NSString *scopeString = [scopes componentsJoinedByString:@" "];
	
	NSDictionary *parameters = @{
		@"response_type": @"code",
		@"client_id": clientIdentifier,
		@"redirect_uri": redirectURL.absoluteString,
		@"scope": scopeString,
	};

	NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:@"https://api.twitch.tv/kraken/oauth2/authorize"];

	URLComponents.percentEncodedQuery = [self URLEncodedStringWithParameters:parameters];
	
	return URLComponents.URL;
}

- (instancetype)initWithCode:(NSString *)code clientIdentifer:(NSString *)clientIdentifier clientSecret:(NSString *)clientSecret redirectURL:(NSURL*)redirectURL
{
	NSURL *URL = [NSURL URLWithString:@"https://api.twitch.tv/kraken/oauth2/token"];
	self = [super initWithURL:URL authorization:nil];
	if(self != nil)
	{
		self.code = code;
		self.clientIdentifier = clientIdentifier;
		self.clientSecret = clientSecret;
		self.redirectURL = redirectURL;
	}
	return self;
}

- (Class)responseClass
{
	return TwitchOAuth2Response.class;
}

- (NSMutableURLRequest *)URLRequest
{
	NSMutableURLRequest *URLRequest = super.URLRequest;
	
	NSDictionary *parameters = @{
		@"client_id": self.clientIdentifier,
		@"client_secret": self.clientSecret,
		@"grant_type": @"authorization_code",
		@"redirect_uri": self.redirectURL.absoluteString,
		@"code": self.code
	};
	
	URLRequest.HTTPMethod = @"POST";
	URLRequest.HTTPBody = [self.class URLEncodedDataWithParameters:parameters];
	[URLRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	return URLRequest;
}

@end
