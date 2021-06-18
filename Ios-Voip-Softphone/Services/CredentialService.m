//
//  CredentialService.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "CredentialService.h"

@implementation CredentialService

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"SipServerInfo.plist"];


        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"SipServerInfo" ofType:@"plist"];
        }

        serverInfo = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}

-(void)configSipServer
{
    [[SipServerInfo sharedInstance] setSipServerIP:[serverInfo objectForKey:@"SIPSwitchIP"]];
    [[SipServerInfo sharedInstance] setSipServerPort:[serverInfo objectForKey:@"SIPSwitchPort"]];
    [[SipServerInfo sharedInstance] setUserName:[serverInfo objectForKey:@"UserName"]];
    [[SipServerInfo sharedInstance] setPassword:[serverInfo objectForKey:@"Password"]];
}

-(void)configLocalDeviceInfo
{
    [[LocalDeviceInfo sharedInstance] setLocalPort:[self getLocalIPAddress]];
    [[LocalDeviceInfo sharedInstance] setLocalPort:@"5060"];
}

- (NSString *)getLocalIPAddress {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;

    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                //NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself

                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;

    //NSLog(addr);
    return addr;

}

@end
