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
    [self sendData:regMsgBytes toHost:[[SipServerInfo sharedInstance] getSipServerIP]
              port:[[[SipServerInfo sharedInstance] getSipServerPort] intValue] withTimeout:60 tag:200];
}

-(void)receiveRegistrationResponse:(NSString *)response
{
    NSArray *responseContents = [sipRegistrationMessages parseResponse:response];
    NSString *statusCode =responseContents[0];
    NSString *resoponseMethod = responseContents[3];
    if([statusCode isEqualToString:@"401"] &&
       [[resoponseMethod lowercaseString] isEqualToString:@"register"])
    {
        [self.recieveMassage recieveRegistrationResponse:@"401"];
        NSString *digestReg = [sipRegistrationMessages createRegMessageWithDigest:responseContents[4] method:resoponseMethod counter:responseContents[2]];
        NSData *digestRegBytes = [digestReg dataUsingEncoding:NSUTF8StringEncoding];
        [self sendData:digestRegBytes toHost:[[SipServerInfo sharedInstance] getSipServerIP]
                  port:[[[SipServerInfo sharedInstance] getSipServerPort] intValue] withTimeout:60 tag:200];
    }
    else if([statusCode isEqualToString:@"200"] &&
    [[resoponseMethod lowercaseString] isEqualToString:@"register"])
    {
        [self.recieveMassage recieveRegistrationResponse:@"200"];
        NSLog(@"Registration Done");

        //Update registratrion every 10 secends
        dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        double delayInSeconds = 10.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, q_background, ^(void){
            [self updateRegistration:responseContents];
        });
    }
}
- (void)updateRegistration:(NSArray*)contents
{
    NSString *regUpdate = [sipRegistrationMessages createRegMessageWithDigest:contents[4] method:contents[3] counter:contents[2]];
    NSData *regUpdateBytes = [regUpdate dataUsingEncoding:NSUTF8StringEncoding];
    [self sendData:regUpdateBytes toHost:[[SipServerInfo sharedInstance] getSipServerIP]
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
    NSLog(@"UDP Socket Ready...");
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
     NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSLog (@ "The server receives the response [%@:% d]", ip, port);
     [sock receiveOnce:nil];

     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     //[self sendBackToHost:ip port:port withMessage:s];
   });
    NSString *responseType = [self parseSocketResponse:response];
    if([[responseType lowercaseString] isEqualToString:@"register"] )
        [self receiveRegistrationResponse:response];
    
}

-(NSString*)parseSocketResponse:(NSString*)response
{
    NSString *statusRes;
    NSString *cseqRes;
    NSArray *arrayOfComponents = [response componentsSeparatedByString:@"\r\n"];
    for(int i=0;i<arrayOfComponents.count;i++)
    {
        
        NSString *tempStr = arrayOfComponents[i];
        if ([[tempStr lowercaseString] containsString:@"sip/2.0 "])
        {
            statusRes = arrayOfComponents[i];
        }
        if ([[tempStr lowercaseString] containsString:@"cseq:"])
        {
            cseqRes = arrayOfComponents[i];
        }
    }
    NSString *responseCode;
    NSString *responseStatus;
    NSString *responseMethod;
    NSString *responseCounter;
    NSArray *statusArr = [statusRes componentsSeparatedByString:@" "];
    responseCode = statusArr[1];
    responseStatus = statusArr[2];
    NSArray *cseqArr = [cseqRes componentsSeparatedByString:@" "];
    responseCounter = cseqArr[1];
    responseMethod = cseqArr[2];
    return responseMethod;
}

@end
