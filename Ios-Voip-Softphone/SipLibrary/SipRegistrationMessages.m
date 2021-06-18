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
-(NSString*)createRegMessageWithDigest :(NSString*)digest method:(NSString*)method counter:(NSString*)counter
{
    NSInteger csecCounter = [counter intValue] + 1;
    via = [NSString stringWithFormat:@"Via: SIP/2.0/%@ %@:%@;branch=%@;rport\r\n",
    protocol,localIP,localPort,[NSString stringWithFormat:@"%@%@",branchPreffix,
                                [[SipSettings sharedInstance] randomAlphanumericStringWithLength:20]]];
    cSeq = [NSString stringWithFormat:@"CSeq: %ld %@\r\n",(long)csecCounter,method];
    NSString *regWithDigest= [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",
                         request_URI,via,max_Forwards,contact,to,from,call_ID,cSeq,expire,allow,user_Agent,digest,content_length];
    
    
    return regWithDigest;
}

-(NSArray*) parseResponse:(NSString*)response
{
    NSString *statusRes;
    NSString *cseqRes;
    NSString *balanceRes;
    NSArray *arrayOfComponents = [response componentsSeparatedByString:@"\r\n"];
    for(int i=0;i<arrayOfComponents.count;i++)
    {
        NSString *tempStr = arrayOfComponents[i];
        if ([[tempStr lowercaseString] containsString:@"sip/2.0 "])
        {
            statusRes = arrayOfComponents[i];
        }
        if ([[tempStr lowercaseString] containsString:@"cseq:"])
        {
            cseqRes = arrayOfComponents[i];
        }
        if ([[tempStr lowercaseString] containsString:@"itelswitchplus: "])
        {
            balanceRes = arrayOfComponents[i];
        }
    }
    NSString *responseCode;
    NSString *responseStatus;
    NSString *responseMethod;
    NSString *responseCounter;
    NSArray *statusArr = [statusRes componentsSeparatedByString:@" "];
    responseCode = statusArr[1];
    responseStatus = statusArr[2];
    NSArray *cseqArr = [cseqRes componentsSeparatedByString:@" "];
    responseCounter = cseqArr[1];
    responseMethod = cseqArr[2];
   
    NSArray *responseContents;
    if([responseCode isEqualToString:@"401"])
    {
        NSString *digest = [self createDigest:response method:responseMethod counter:responseCounter];
        responseContents = @[responseCode,responseStatus,responseCounter,responseMethod,digest];
    }
    else
    {
        NSString *digest = [self createDigest200:responseMethod counter:responseCounter];
        responseContents = @[responseCode,responseStatus,responseCounter,responseMethod,digest];
    }
    if([responseCode isEqualToString:@"200"])
    {
        NSArray *statusArr = [balanceRes componentsSeparatedByString:@" "];
        NSArray *statusArr2 = [statusArr[1] componentsSeparatedByString:@"="];
        //responseCode = statusArr[1];
        responseStatus = statusArr2[1];
        //[[Constant sharedInstance] setBalance:[NSString stringWithFormat:@"Balance: %@ USD", responseStatus]];
    }
    
    return responseContents;
}




-(NSString*)createDigest :(NSString*)response method:(NSString*)method counter:(NSString*)count
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"nonce=[^;&gt;]+" options:0 error:&error];
    NSArray *matches = [regex matchesInString:response options:0 range:NSMakeRange(0, [response length])];
    NSUInteger matchCount = [matches count];
    NSString *result;
    if (matchCount) {
        for (NSUInteger matchIdx = 0; matchIdx < matchCount; matchIdx++) {
            NSTextCheckingResult *match = [matches objectAtIndex:matchIdx];
            NSRange matchRange = [match range];
            result = [response substringWithRange:matchRange];
        }
    }
    NSArray *arrayOfComponents = [result componentsSeparatedByString:@","];
    NSArray *arrayOfComponents1 = [result componentsSeparatedByString:@"\""];
    
    NSString *nonce = arrayOfComponents1[1];
    responseNonce = nonce;
    
    NSString* cnonce = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    cnonce = [cnonce
    stringByReplacingOccurrencesOfString:@"-" withString:@""];
    cnonce = [cnonce lowercaseString];
    cnonce = [[SipSettings sharedInstance] convertMD5:cnonce];
    
    NSString *HA1 = [NSString stringWithFormat:@"%@:%@:%@",user,serverIP,password];
    NSString *ha1 = [[SipSettings sharedInstance] convertMD5:HA1];
    NSString *HA2 = [NSString stringWithFormat:@"%@:sip:%@;transport=%@",method,serverIP,protocol];
    NSString *ha2 = [[SipSettings sharedInstance] convertMD5:HA2];
    
    NSString *nc = [[SipSettings sharedInstance] toBinary:[count intValue]];
    NSString *tempMD5 = [NSString stringWithFormat:@"%@:%@:%@:%@:auth:%@",
    ha1,nonce,nc,cnonce,ha2];
    NSString *fMD5 = [[SipSettings sharedInstance] convertMD5:tempMD5];
    
    
    NSString *completeDigestMessage = [NSString stringWithFormat:@"Authorization: Digest username=\"%@\", realm=\"%@\",nonce=\"%@\",uri=\"sip:%@;transport=%@\",response=\"%@\",cnonce=\"%@\",nc=%@,qop=\"auth\",algorithm=MD5\r\n",user,serverIP,nonce,serverIP,protocol,fMD5,cnonce,nc];
    
    return completeDigestMessage;
}

-(NSString*)createDigest200:(NSString*)method counter:(NSString*)count
{
    NSString *nonce = responseNonce;
    
    NSString* cnonce = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    cnonce = [cnonce
    stringByReplacingOccurrencesOfString:@"-" withString:@""];
    cnonce = [cnonce lowercaseString];
    cnonce = [[SipSettings sharedInstance] convertMD5:cnonce];
    
    NSString *HA1 = [NSString stringWithFormat:@"%@:%@:%@",user,serverIP,password];
    NSString *ha1 = [[SipSettings sharedInstance] convertMD5:HA1];
    NSString *HA2 = [NSString stringWithFormat:@"%@:sip:%@;transport=%@",method,serverIP,protocol];
    NSString *ha2 = [[SipSettings sharedInstance] convertMD5:HA2];
    
    NSString *nc = [[SipSettings sharedInstance] toBinary:[count intValue]];
    NSString *tempMD5 = [NSString stringWithFormat:@"%@:%@:%@:%@:auth:%@",
    ha1,nonce,nc,cnonce,ha2];
    NSString *fMD5 = [[SipSettings sharedInstance] convertMD5:tempMD5];
    
    
    NSString *completeDigestMessage = [NSString stringWithFormat:@"Authorization: Digest username=\"%@\", realm=\"%@\",nonce=\"%@\",uri=\"sip:%@;transport=%@\",response=\"%@\",cnonce=\"%@\",nc=%@,qop=\"auth\",algorithm=MD5\r\n",user,serverIP,nonce,serverIP,protocol,fMD5,cnonce,nc];
    
    return completeDigestMessage;
}

@end
