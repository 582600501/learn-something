//
//  MyNativeModule.h
//  helloworld
//
//  Created by ZTELiuyw on 16/1/21.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@interface MyNativeModule : NSObject<RCTBridgeModule>

-(void)afterHello;

@end
