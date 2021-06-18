//
//  NSString+Random.h
//  GeoDialer
//
//  Created by Toukir Naim on 24/6/20.
//  Copyright © 2020 GeoNet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Random)
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;
+ (NSString *)randomNumericStringWithLength:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
