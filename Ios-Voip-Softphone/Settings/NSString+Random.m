//
//  NSString+Random.m
//  GeoDialer
//
//  Created by Toukir Naim on 24/6/20.
//  Copyright © 2020 GeoNet. All rights reserved.
//


#import "NSString+Random.h"

@implementation NSString (Random)
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];

    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }

    return randomString;
}
+ (NSString *)randomNumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];

    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }

    return randomString;
}

@end
