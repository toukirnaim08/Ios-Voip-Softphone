//
//  ViewController.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <UIKit/UIKit.h>
#import "CredentialService.h"
#import "UDPTransferService.h"

@interface ViewController : UIViewController<RecieveMassage>
{
    CredentialService *credentialService;
    UDPTransferService *udpTransferService;
}


@end

