//
//  SipSettings.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "SipSettings.h"

static SipSettings *sharedInstance = nil;
@implementation SipSettings

+(SipSettings *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[SipSettings alloc] init];
    }
    return sharedInstance;
}

- (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    return [NSString randomAlphanumericStringWithLength:length];
}
- (NSString *)randomNumericStringWithLength:(NSInteger)length
{
    return [NSString randomNumericStringWithLength:length];
}
- (NSString *)convertMD5:(NSString*) originalText
{
    return [originalText MD5String];
}

@end
