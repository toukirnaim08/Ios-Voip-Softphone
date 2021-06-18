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
    
   // CredentialService *credentialService=[[CredentialService alloc] init];
    credentialService=[[CredentialService alloc] init];
    [credentialService configSipServer];
    [credentialService configLocalDeviceInfo];
    
    //UDPTransferService *udpTransferService=[[UDPTransferService alloc] init];
    udpTransferService=[[UDPTransferService alloc] init];
    udpTransferService.recieveMassage = self;
    [udpTransferService startPacketTransfer];
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Press Me" forState:UIControlStateNormal];
        [button sizeToFit];
        button.center = CGPointMake(320/2, 60);

        // Add an action in current code file (i.e. target)
        [button addTarget:self action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:button];
}
-(void) buttonPressed:(UIButton*)sender
{
    [udpTransferService startRegistration];
}

- (void)recieveRegistrationResponse:(nonnull NSString *)msg
{
}

@end
