#import "TwitchPing.h"

#include <netinet/in.h>
#include <arpa/inet.h>


static uint16_t in_cksum(const void *buffer, size_t bufferLen)
// This is the standard BSD checksum code, modified to use modern types.
{
	size_t              bytesLeft;
	int32_t             sum;
	const uint16_t *    cursor;
	union {
		uint16_t        us;
		uint8_t         uc[2];
	} last;
	uint16_t            answer;
	
	bytesLeft = bufferLen;
	sum = 0;
	cursor = buffer;
	
	/*
	 * Our algorithm is simple, using a 32 bit accumulator (sum), we add
	 * sequential 16 bit words to it, and at the end, fold back all the
	 * carry bits from the top 16 bits into the lower 16 bits.
	 */
	while (bytesLeft > 1) {
		sum += *cursor;
		cursor += 1;
		bytesLeft -= 2;
	}
	
	/* mop up an odd byte, if necessary */
	if (bytesLeft == 1) {
		last.uc[0] = * (const uint8_t *) cursor;
		last.uc[1] = 0;
		sum += last.us;
	}
	
	/* add back carry outs from top 16 bits to low 16 bits */
	sum = (sum >> 16) + (sum & 0xffff);	/* add hi 16 to low 16 */
	sum += (sum >> 16);			/* add carry */
	answer = ~sum;				/* truncate to 16 bits */
	
	return answer;
}


@interface TwitchPing ()

@property (assign) BOOL isExecuting;
@property (assign) BOOL isFinished;

@property (nonatomic, copy) id completionHandler;

@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSData *address;

@property (nonatomic, strong) id<NSLocking> lock;

@property (nonatomic, strong) NSSocketPort *socket;

@end


@implementation TwitchPing

+ (NSThread *)pingThread
{
	static NSThread *thread = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		thread = [[NSThread alloc] initWithTarget:self selector:@selector(pingThreadMain:) object:nil];
		[thread start];
	});
	
	return thread;
}

+ (void)pingThreadMain:(id)object
{
	@autoreleasepool
	{
		NSThread.currentThread.name = @"TwitchConnectionThread";
		
		NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
		[runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
		[runLoop run];
	}
}

+ (BOOL)automaticallyNotifiesObserversOfIsExecuting
{
	return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfIsFinished
{
	return NO;
}

- (instancetype)initWithURL:(NSURL *)URL
{
	return [self initWithHost:URL.host];
}

- (instancetype)initWithHost:(NSString *)host
{
	self = [super init];
	if(self != nil)
	{
		self.host = host;
	}
	return self;
}

- (instancetype)initWithAddress:(NSData *)address
{
	self = [super init];
	if(self != nil)
	{
		self.address = address;
	}
	return self;
}

- (void)start
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	// do not call [super start], it will call [self main].
	
	if(self.isCancelled)
	{
		// a connection might already be cancelled. This will happen when a lot of operations are cancelled at the same time. this method, not the cancel method must clean up. otherwise there will be an exception
		[self finish];
	}
	else
	{
		// ensure the operation is in executing state first so cancel can be handled correctly. The lock will ensure there is no race condition.
		[self willChangeValueForKey:@"isExecuting"];
		self.isExecuting = YES;
		[self didChangeValueForKey:@"isExecuting"];
		
		[self performSelector:@selector(startPing) onThread:self.class.pingThread withObject:nil waitUntilDone:NO modes:@[ NSDefaultRunLoopMode ]];
	}
	[lock unlock];
}

- (void)cancel
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	if(!self.isCancelled && !self.isFinished)
	{
		//self.completionHandler = nil;
		
		[super cancel];
		
		if(self.isExecuting)
		{
			// only when we are already executing, we are allowed to cancel the connection, otherwise an exception might occur. This will also result in the following but already cancelled operatations of be started, but the first check in start check if the operation is cancelled.
			[self performSelector:@selector(cancelPing) onThread:self.class.pingThread withObject:nil waitUntilDone:NO modes:@[ NSDefaultRunLoopMode ]];
		}
	}
	
	[lock unlock];
}

- (void)finish
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	//self.completionHandler = nil;
	
	// ensure only the changed states will be changed. Setting isExecuting = NO when it is already NO will cause an exception when the connection was cancelled before.
	
	BOOL wasExecuting = self.isExecuting;
	BOOL wasFinished = self.isFinished;
	
	if(!wasFinished)
	{
		[self willChangeValueForKey:@"isFinished"];
	}
	if(wasExecuting)
	{
		[self willChangeValueForKey:@"isExecuting"];
	}
	
	self.isExecuting = NO;
	self.isFinished = YES;
	
	if(wasExecuting)
	{
		[self didChangeValueForKey:@"isExecuting"];
	}
	if(!wasFinished)
	{
		[self didChangeValueForKey:@"isFinished"];
	}
	
	[lock unlock];
}

- (void)startPing
{
	id<NSLocking> lock = self.lock;
	[lock lock];
	
	if(!self.isCancelled)
	{
		NSData *address = self.address;
		
		if(address == nil)
		{
			NSHost *host = [NSHost hostWithName:self.host];
			
			NSArray *ips = host.addresses;
			for(NSString *ip in ips)
			{
				in_addr_t a = inet_addr(ip.UTF8String);
				if(a != 0)
				{
					struct sockaddr_in sockaddr = {
						sizeof(sockaddr),
						AF_INET,
						0,
						a
					};
					address = [NSData dataWithBytes:&sockaddr length:sizeof(sockaddr)];
					break;
				}
			}
			
			
		}
		
		NSSocketPort *socket = [[NSSocketPort alloc] initWithProtocolFamily:AF_INET socketType:SOCK_DGRAM protocol:IPPROTO_ICMP address:address];
		self.socket = socket;
		
		NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
		
		[socket scheduleInRunLoop:runLoop forMode:NSDefaultRunLoopMode];
	}
	
	[lock unlock];
}

- (void)cancelPing
{
	
}

@end
