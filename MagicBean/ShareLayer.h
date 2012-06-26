//
//  ShareLayer.h
//  MagicBean
//
//  Created by  on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "imageViewCellCell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "TableViewScene.h"
extern CGSize screenSize;

@interface MYTableView : UITableView
{
    BOOL isSelected;
}
@property (nonatomic, assign) BOOL isSelected;
@end


@interface ShareLayer : CCLayer<CCTargetedTouchDelegate,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>{
    MYTableView *myTableView;
    NSArray     *myTableInfos;
    MFMailComposeViewController *picker;
    UIViewController* emailController;
    
}
@property (nonatomic, retain) MYTableView *myTableView;
+(id) scene;
-(void)homeCallFunc;
-(void)cancelCallFunc;
-(void)okCallFunc;
@end
