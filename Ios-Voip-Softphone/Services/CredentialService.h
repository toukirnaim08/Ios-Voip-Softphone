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
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface CredentialService : NSObject
{
    NSDictionary *serverInfo;
}

-(void)configSipServer;
-(void)configLocalDeviceInfo;

@end

NS_ASSUME_NONNULL_END
