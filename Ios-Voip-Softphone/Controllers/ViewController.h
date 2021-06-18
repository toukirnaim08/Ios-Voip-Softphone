//
//  ViewController.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CredentialService.h"
#import "UDPTransferService.h"
#import "NotificationView.h"

@interface ViewController : UIViewController<RecieveMassage>
{
    CredentialService *credentialService;
    UDPTransferService *udpTransferService;
    
    NotificationView *notificationView;
}


@end

