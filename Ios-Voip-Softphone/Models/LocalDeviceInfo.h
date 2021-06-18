//
//  LocalDeviceInfo.h
//  Ios-Voip-Softphone
//
//  Created by Toukir Naim on 18/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalDeviceInfo : NSObject
{
    NSString *localIP;
    NSString *localPort;
}

+ (LocalDeviceInfo *) sharedInstance;

-(void)setLocalIP:(NSString*)ip;
-(NSString*)getLocalIP;
-(void)setLocalPort:(NSString*)port;
-(NSString*)getLocalPort;
@end

NS_ASSUME_NONNULL_END
