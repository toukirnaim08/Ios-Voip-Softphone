//
//  Config.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Config : NSObject
{
    NSString *sipServerIP;
    NSString *sipServerPort;
    
    NSString *localIP;
    NSString *localPort;
    
    NSString *userName;
    NSString *password;
    
}

@end

NS_ASSUME_NONNULL_END
