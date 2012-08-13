//
//  MaskBarSprite.h
//  ZhongziMulu
//
//  Created by ice on 12-8-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MaskBarSprite : CCSprite <CCTargetedTouchDelegate> {
    CCRenderTexture *rt;
    CCSprite *theSprite;
}

@end
