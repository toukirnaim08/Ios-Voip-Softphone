//
//  CredentialService.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "SipServerInfo.h"
#import "LocalDeviceInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CredentialService : NSObject
{
    NSDictionary *serverInfo;
}

-(void)configSipServer;
-(void)configLocalDeviceInfo;

@end

NS_ASSUME_NONNULL_END
