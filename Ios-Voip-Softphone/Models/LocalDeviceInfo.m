//
//  LocalDeviceInfo.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "LocalDeviceInfo.h"

static LocalDeviceInfo *sharedInstance = nil;
@implementation LocalDeviceInfo

+(LocalDeviceInfo *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[LocalDeviceInfo alloc] init];
    }
    return sharedInstance;
}

-(void)setLocalIP:(NSString*)ip
{
    localIP = ip;
}
-(NSString*)getLocalIP
{
    if(localIP!=nil)
        return localIP;
    else
        return @"0.0.0.0";
}
-(void)setLocalPort:(NSString*)port
{
    localPort = port;
}
-(NSString*)getLocalPort
{
    return localPort;
}

@end
