//
//  NotificationView.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationView : UIView
{
    UILabel *registrationStatus;
    UILabel *registrationStatusCode;
}

-(void)setRegistrationStatusText:(NSString*) text;
-(void)setRegistrationStatusCode:(NSString*) code;

@end

NS_ASSUME_NONNULL_END
