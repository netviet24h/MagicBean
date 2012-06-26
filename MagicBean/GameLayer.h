//
//  GameLayer.h
//  MagicBean
//
//  Created by  on 12-5-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "TableViewScene.h"
#import "ReadScene.h"

extern CGSize screenSize;
@interface GameLayer : CCLayer<MFMailComposeViewControllerDelegate> {
    MFMailComposeViewController *picker;
    UIViewController* emailController;
    CCLayer *tableLayer;
}
+(CCScene*)scene;
@end
