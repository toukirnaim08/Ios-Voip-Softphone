//
//  SipServerInfo.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SipServerInfo : NSObject
{
    NSString *sipServerIP;
    NSString *sipServerPort;
    
    NSString *userName;
    NSString *password;
}

+ (SipServerInfo *) sharedInstance;

-(void)setSipServerIP:(NSString*)ip;
-(NSString*)getSipServerIP;
-(void)setSipServerPort:(NSString*)port;
-(NSString*)getSipServerPort;

-(void)setUserName:(NSString*)user;
-(NSString*)getUserName;
-(void)setPassword:(NSString*)pass;
-(NSString*)getPassword;

@end

NS_ASSUME_NONNULL_END
