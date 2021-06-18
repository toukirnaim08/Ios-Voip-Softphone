//
//  SipRegistrationMessages.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <Foundation/Foundation.h>
#import "LocalDeviceInfo.h"
#import "SipServerInfo.h"
#import "SipSettings.h"

NS_ASSUME_NONNULL_BEGIN
#define branchPreffix @"z9hG4bK"
#define protocol @"UDP"
#define agent @"Simple-Softphone"

@interface SipRegistrationMessages : NSObject
{
    NSString *localIP;
    NSString *localPort;
    NSString *serverIP;
    NSString *serverPort;
    
    NSString *user;
    NSString *password;
    
    NSString *request_URI;
    NSString *to;
    NSString *from;
    NSString *call_ID;
    NSString *cSeq;
    NSString *contact;
    NSString *max_Forwards;
    NSString *via;
    NSString *expire;
    NSString *allow;
    NSString *user_Agent;
    NSString *content_length;
    NSString *method;
    NSString *branch;
    NSString *tag;
    NSString *callRandom;
    
    NSInteger conter;
    
    NSString *responseNonce;
}
-(void) setProperty;
-(NSString*) createRegMessage;
-(NSArray*) parseResponse:(NSString*)response;
-(NSString*)createRegMessageWithDigest :(NSString*)digest method:(NSString*)method counter:(NSString*)counter;

@end

NS_ASSUME_NONNULL_END
