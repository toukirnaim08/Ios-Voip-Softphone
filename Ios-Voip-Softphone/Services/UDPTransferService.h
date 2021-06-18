//
//  UDPTransferService.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

@import CocoaAsyncSocket;

#import <Foundation/Foundation.h>
#import "LocalDeviceInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RecieveMassage <NSObject>
- (void)recieveRegistrationResponse:(NSString*)msg;
@end

@interface UDPTransferService : NSObject<GCDAsyncUdpSocketDelegate>
{
    GCDAsyncUdpSocket *udpSocket;
}

@property (assign, nonatomic) id<RecieveMassage> recieveMassage;

-(void)startPacketTransfer;

@end

NS_ASSUME_NONNULL_END
