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
-(NSString *)toBinary:(NSInteger)input
{
    NSMutableString * string = [[NSMutableString alloc] init];

    int spacing = 1;
    int width = ( sizeof( input ) ) * spacing;
    int binaryDigit = 0;
    int integer = input;

    while( binaryDigit < width )
    {
        binaryDigit++;

        [string insertString:( (integer & 1) ? @"1" : @"0" )atIndex:0];

        if( binaryDigit % spacing == 0 && binaryDigit != width )
        {
            [string insertString:@"" atIndex:0];
        }

        integer = integer >> 1;
    }

    return string;
}
-(int)getRandomNumberBetween:(int)from andto:(int)to {

    return (int)from + arc4random() % (to-from+1);
}
@end
