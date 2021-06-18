//
//  SipRegistrationMessages.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "SipRegistrationMessages.h"

@implementation SipRegistrationMessages

-(void) setProperty
{
    
    localIP = [[LocalDeviceInfo sharedInstance] getLocalIP];
    localPort = [[LocalDeviceInfo sharedInstance] getLocalPort];
    
    serverIP = [[SipServerInfo sharedInstance] getSipServerIP];
    serverPort = [[SipServerInfo sharedInstance] getSipServerPort];
    
    user = [[SipServerInfo sharedInstance] getUserName];
    password = [[SipServerInfo sharedInstance] getPassword];
    
    
    conter = 1;
    
    method =@"REGISTER";
    branch = [NSString stringWithFormat:@"%@%@",branchPreffix,
              [[SipSettings sharedInstance] randomAlphanumericStringWithLength:20]];
    tag =[[SipSettings sharedInstance] randomAlphanumericStringWithLength:22];
    callRandom = [NSString stringWithFormat:@"%@@%@",[[SipSettings sharedInstance] randomAlphanumericStringWithLength:36],
    serverIP];

    
}
-(NSString*) createRegMessage
{
    request_URI = [NSString stringWithFormat:@"%@ sip:%@;transport=UDP SIP/2.0\r\n",method,serverIP];
    via = [NSString stringWithFormat:@"Via: SIP/2.0/%@ %@:%@;branch=%@;rport\r\n",
           protocol,localIP,localPort,branch];
    max_Forwards=@"Max-Forwards: 70\r\n";
    contact = [NSString stringWithFormat:@"Contact: <sip:%@@%@:%@>\r\n",user,localIP,localPort];
    to = [NSString stringWithFormat:@"To: <sip:%@@%@>\r\n",user,serverIP];
    from = [NSString stringWithFormat:@"From: <sip:%@@%@>;tag=%@\r\n",user,serverIP,tag];
    call_ID = [NSString stringWithFormat:@"Call-ID: %@\r\n",callRandom];
    cSeq = [NSString stringWithFormat:@"CSeq: 1 %@\r\n",method];
    expire =@"Expires: 90\r\n";
    allow = @"Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, NOTIFY, MESSAGE, REGISTER, SUBSCRIBE, INFO\r\n";
    user_Agent = [NSString stringWithFormat:@"User-Agent: %@-1.1\r\n",agent];
    content_length = @"Content-Length: 0\r\n\r\n";
    
    NSString *completeReg= [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@",
                         request_URI,via,max_Forwards,contact,to,from,call_ID,cSeq,expire,allow,user_Agent,content_length];
    
    
    
    conter++;
    return completeReg;
}

@end
