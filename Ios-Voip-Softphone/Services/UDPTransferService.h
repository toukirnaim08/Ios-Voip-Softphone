//
//  UDPTransferService.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//
#import <Foundation/Foundation.h>
@protocol RecieveMassage <NSObject>
- (void)recieveRegistrationResponse:(NSString*)msg;
@end

@import CocoaAsyncSocket;
#import "SipRegistrationMessages.h"
#import "LocalDeviceInfo.h"
#import "SipServerInfo.h"

NS_ASSUME_NONNULL_BEGIN


@interface UDPTransferService : NSObject<GCDAsyncUdpSocketDelegate>
{
    GCDAsyncUdpSocket *udpSocket;
    SipRegistrationMessages *sipRegistrationMessages;
}

@property (assign, nonatomic) id<RecieveMassage> recieveMassage;

-(void)startPacketTransfer;
-(void)startRegistration;

@end

NS_ASSUME_NONNULL_END
