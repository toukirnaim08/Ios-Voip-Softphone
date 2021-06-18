//
//  UDPTransferService.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "UDPTransferService.h"

@implementation UDPTransferService

- (instancetype)init
{
    self = [super init];
    if (self) {
        sipRegistrationMessages =[[SipRegistrationMessages alloc] init];
    }
    return self;
}

-(void)startPacketTransfer
{
    [self createClientUdpSocket];
}

-(void)startRegistration
{
    [sipRegistrationMessages setProperty];
    NSString *regMsg = [sipRegistrationMessages createRegMessage];
    NSData *regMsgBytes = [regMsg dataUsingEncoding:NSUTF8StringEncoding];
    //[self->sipMessageSocket sendData:data toHost:@"169.239.160.17" port:5060 withTimeout:60 tag:200];
    [self sendData:regMsgBytes toHost:[[SipServerInfo sharedInstance] getSipServerIP]
              port:[[[SipServerInfo sharedInstance] getSipServerPort] intValue] withTimeout:60 tag:200];
}


-(void)createClientUdpSocket
{
    dispatch_queue_t dQueue = dispatch_queue_create("SIP socket", NULL);

    udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue: dQueue socketQueue: nil];
    NSError *error = nil;
    if (![udpSocket bindToPort:[[[LocalDeviceInfo sharedInstance] getLocalPort] intValue] error:&error]) 
    {
        return;
    }
    if (![udpSocket beginReceiving:&error])
    {
        return;
    }
    NSLog(@"ready socket 1");
}

- (void)sendData:(NSData *)data
          toHost:(NSString *)host
            port:(uint16_t)port
     withTimeout:(NSTimeInterval)timeout
             tag:(long)tag
{
    [udpSocket sendData:data toHost:host port:port withTimeout:timeout tag:tag];
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
     NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
     uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
     NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     // Continue to wait for a message to receive the next
     NSLog (@ "The server receives the response [%@:% d]", ip, port);
     [sock receiveOnce:nil];

     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     //[self sendBackToHost:ip port:port withMessage:s];
   });
    [self.recieveMassage recieveRegistrationResponse:s];
    
}
@end
