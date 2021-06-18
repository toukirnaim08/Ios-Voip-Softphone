//
//  ViewController.m
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    credentialService=[[CredentialService alloc] init];
    [credentialService configSipServer];
    [credentialService configLocalDeviceInfo];
    
    udpTransferService=[[UDPTransferService alloc] init];
    udpTransferService.recieveMassage = self;
    [udpTransferService startPacketTransfer];
    

    notificationView = [[NotificationView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 90)];
    [self.view addSubview:notificationView];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setTitle:@"Start Registration" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setBackgroundColor:[UIColor brownColor]];
    startButton.layer.cornerRadius = 10;
    startButton.clipsToBounds = YES;
    startButton.frame = CGRectMake(self.view.frame.size.width/2-100, 500, 200, 50);
    [startButton addTarget:self action:@selector(startButtonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}
-(void) startButtonAction:(UIButton*)sender
{
    [udpTransferService startRegistration];
}

- (void)recieveRegistrationResponse:(nonnull NSString *)responseCode
{
    NSLog(@".......%@",responseCode);
    dispatch_async(dispatch_get_main_queue(), ^{
        if([responseCode isEqualToString:@"401"])
        {
           [self->notificationView setRegistrationStatusText:@"Registering"];
            [self->notificationView setRegistrationStatusCode:@"Response: 401 unauthorized"];
        }
        else if([responseCode isEqualToString:@"200"])
        {
            [self->notificationView setRegistrationStatusText:@"Registered"];
            [self->notificationView setRegistrationStatusCode:@"Response: 200 OK"];
        }
    });
}

@end
