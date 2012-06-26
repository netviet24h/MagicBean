//
//  MenuScene.h
//  eBookTest
//
//  Created by ivan on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "common.h"
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
@class GameCenterManager;
//#define PTM_RATIO 32

extern int 	levelNum ;
extern int _totalStarNums ;
extern int sceneIdx;
@interface MenuScene : CCLayer <UIActionSheetDelegate,  GameCenterManagerDelegate> {
	CCMenuItemSprite *read;
	CCMenuItemSprite *game;
	CCMenuItemSprite *more;
	CCMenuItemSprite *facebook;
	CCMenuItemSprite *twitter;
	CCMenuItemSprite *bibobox;
	CCMenuItemImage *ch;
	CCMenuItemImage *tw;
	CCMenuItemImage *en;
    CCSpriteBatchNode *spritesBgNode;
    
	id tmpSender;
	b2World* world;
	b2Vec2 m_mouseWorld;
	b2MouseJoint* m_mouseJoint;
	b2Body* m_groundBody;
	b2AABB worldAABB;
	BOOL isClicked;
	UIViewController *gameCenterView;	
	GameCenterManager *gameCenterManager;
    
    CCSprite *mohu;
    BOOL canEarse;
	BOOL canFlip;
	UIImageView *imageView;
}
+(id) scene;
-(id) init;
-(void)dealloc;
@end
