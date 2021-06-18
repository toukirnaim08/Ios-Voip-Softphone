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
    CredentialService *credentialService=[[CredentialService alloc] init];
    [credentialService configSipServer];
    [credentialService configLocalDeviceInfo];
    
    UDPTransferService *udpTransferService=[[UDPTransferService alloc] init];
    udpTransferService.recieveMassage = self;
    [udpTransferService startPacketTransfer];
    
    // Do any additional setup after loading the view.
}

- (void)recieveRegistrationResponse:(nonnull NSString *)msg
{
}

@end
