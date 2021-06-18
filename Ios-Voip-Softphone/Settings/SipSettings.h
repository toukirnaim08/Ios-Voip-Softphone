//
//  SipSettings.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"
#import "NSString+Random.h"

NS_ASSUME_NONNULL_BEGIN

@interface SipSettings : NSObject
+ (SipSettings *) sharedInstance;

- (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;
- (NSString *)randomNumericStringWithLength:(NSInteger)length;

- (NSString *)convertMD5:(NSString*) originalText;
@end

NS_ASSUME_NONNULL_END
