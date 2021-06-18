//
//  SipServerInfo.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "SipServerInfo.h"

static SipServerInfo *sharedInstance = nil;
@implementation SipServerInfo

+(SipServerInfo *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[SipServerInfo alloc] init];
    }
    return sharedInstance;
}

-(void)setSipServerIP:(NSString*)ip
{
    sipServerIP = ip;
}
-(NSString*)getSipServerIP
{
    return sipServerIP;
}
-(void)setSipServerPort:(NSString*)port
{
    sipServerPort = port;
}
-(NSString*)getSipServerPort
{
    return sipServerPort;
}

-(void)setUserName:(NSString*)user
{
    userName = user;
}
-(NSString*)getUserName
{
    return userName;
}
-(void)setPassword:(NSString*)pass
{
    password = pass;
}
-(NSString*)getPassword
{
    return password;
}
@end
