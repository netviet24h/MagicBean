//
//  MainMenu.h
//  ZhongziMenu
//
//  Created by ice on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "common.h"
@interface MainMenu : CCLayer {
    CCRenderTexture *rt;
    CCSpriteBatchNode *spriteBatchNode;
    CCSprite *PiaoChong;
    CCMenu *Playmenu;
    CCSprite *ZhongZi;
    bool isOpenList;
}
+(CCScene *) scene;
@end
