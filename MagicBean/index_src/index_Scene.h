//
//  index_Scene.h
//  ZhongziMulu
//
//  Created by ice on 12-8-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "MaskBarSprite.h"
//#import "ListMenuItem.h"
#import "common.h"
@interface myLayer : CCLayer
{
}
@end
@interface index_Scene : CCLayer {
    b2World* world;
	GLESDebugDraw *m_debugDraw;
    
    CCSpriteBatchNode *spriteBatchNode;
    NSMutableArray *Lists;
    BOOL isMusicOn;
    MaskBarSprite *music;
    MaskBarSprite *musicOn;
    MaskBarSprite *musicOff;
    b2Vec2 m_mouseWorld;
	b2MouseJoint* m_mouseJoint;
    //CCMenuItem *musicItem;
    //CCMenuItemToggle *musicMenu;

}
+(CCScene *) scene;
@end
