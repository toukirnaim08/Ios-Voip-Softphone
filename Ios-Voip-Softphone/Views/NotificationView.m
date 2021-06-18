//
//  NotificationView.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "NotificationView.h"

@implementation NotificationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        registrationStatus = [[UILabel alloc] init];
        registrationStatus.frame = CGRectMake(0,0,frame.size.width,40);
        registrationStatus.textColor = [UIColor whiteColor];
        registrationStatus.backgroundColor=[UIColor brownColor];
        //balanceLabel.textColor=[UIColor blackColor];
        registrationStatus.userInteractionEnabled=NO;
        [registrationStatus setTextAlignment:NSTextAlignmentCenter];
        [registrationStatus setFont:[UIFont systemFontOfSize:20]];
        registrationStatus.text = @"Press button to start registration...";
        [self addSubview:registrationStatus];
        
        registrationStatusCode = [[UILabel alloc] init];
        registrationStatusCode.frame = CGRectMake(0,50,frame.size.width,40);
        registrationStatusCode.textColor = [UIColor whiteColor];
        registrationStatusCode.backgroundColor=[UIColor brownColor];
        //balanceLabel.textColor=[UIColor blackColor];
        registrationStatusCode.userInteractionEnabled=NO;
        [registrationStatusCode setTextAlignment:NSTextAlignmentCenter];
        [registrationStatusCode setFont:[UIFont systemFontOfSize:20]];
        registrationStatusCode.text = @"";
        [self addSubview:registrationStatusCode];
        
    }
    return self;
}

-(void)setRegistrationStatusText:(NSString*) text
{
    registrationStatus.text = text;
}
-(void)setRegistrationStatusCode:(NSString*) code
{
    registrationStatusCode.text = code;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
