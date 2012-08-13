//
//  MainMenu.m
//  ZhongziMenu
//
//  Created by ice on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"


@implementation MainMenu
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	MainMenu *layer = [MainMenu node];
	[scene addChild: layer];
	return scene;
}

-(id)init
{
	if( (self=[super init])) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"MainMenu.plist"];
        spriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"MainMenu.pvr.ccz"];
        [self addChild:spriteBatchNode z:-1];
        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"home_bg"];
        bg.anchorPoint = ccp(0,0);
        bg.position = ccp(0,0);
        [spriteBatchNode addChild:bg z:0];
        
        CCSprite *bibobox = [CCSprite spriteWithSpriteFrameName:@"home_bibobox"];
        bibobox.anchorPoint = ccp(0.5,0.5);
        bibobox.position = ccp(100,30);
        [spriteBatchNode addChild:bibobox z:1];
        
        [self LogoChange];
        [self PiaoChongFly];
        [self Zhongzi];
        isOpenList = NO;
        self.isTouchEnabled = YES;
	}
	return self;
}


-(void)LogoChange //**********各种语言logo 
{
    CCSprite *logo = [CCSprite spriteWithSpriteFrameName:@"home_logo_ch"];
    logo.anchorPoint = ccp(0.5,0.5);
    logo.position = ccp(700,615);
    [spriteBatchNode addChild:logo z:1];
}

-(void)PiaoChongFly//**********瓢虫动画 
{
	NSMutableArray *flashArray=[NSMutableArray array];
	for(int i=1;i<=2;i++)
	{
		[flashArray addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"home_piao_%d",i]]];			
	}
	CCAnimation *flashes=[CCAnimation animationWithFrames:flashArray delay:0.1f];

	CCSprite *fl=[CCSprite spriteWithSpriteFrameName:@"home_piao_1"];
    fl.anchorPoint=ccp(0.5,0.5);
	fl.position=ccp(890,670);
    id ffAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:flashes restoreOriginalFrame:NO] times:2.0f];
	CCAction *fAction=[CCRepeatForever actionWithAction:[CCSequence actions:ffAction,[CCDelayTime actionWithDuration:2.0f],nil]];
    fAction.tag=1;
	[fl runAction:fAction];
	[spriteBatchNode addChild:fl z:1 tag:5];
    PiaoChong = fl;
}

-(void)StartMenu  //**********开始按钮
{
    
    CCSprite *small = [CCSprite spriteWithSpriteFrameName:@"home_make_1"];
    small.anchorPoint = ccp(0.5,0.5);
    small.position = ccp(270,450);
    small.scale = 0.0f;
    [spriteBatchNode addChild:small z:1];
    
    CCSprite *big =[CCSprite spriteWithSpriteFrameName:@"home_make_2"];
    big.anchorPoint = ccp(0.5,0.5);
    big.position = ccp(170,560);
    big.scale = 0.0f;
    [spriteBatchNode addChild:big z:1];
    
    
        id a11 = [CCScaleTo actionWithDuration:0.5f scale:1.0f];
        id a21 = [CCEaseBackOut actionWithAction:a11];
        id a31 = [CCMoveTo actionWithDuration:0.3f position:ccp(250,470)];
        id a41 = [CCFadeIn actionWithDuration:0.3f];
        id a51 = [CCSpawn actions:a21,a31,a41, nil];
        [small runAction:a51];
        
        id b1 = [CCScaleTo actionWithDuration:0.5f scale:1.0f];
        id b2 = [CCEaseBackOut actionWithAction:b1];
        id b3 = [CCFadeIn actionWithDuration:0.3f];
        id b4 = [CCSpawn actions:b2,b3, nil];
        [big runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.4],b4,nil]];
    
    
    
    
    CCSprite *play = [CCSprite spriteWithSpriteFrameName:@"home_play"];
    CCSprite *play2 = [CCSprite spriteWithSpriteFrameName:@"home_play"];
    
    CCMenuItem *menu = [CCMenuItemSprite itemFromNormalSprite:play selectedSprite:play2 target:self selector:@selector(PlayStory)];
    menu.anchorPoint = ccp(0.5,0.5);
    menu.position = ccp(725,280);
    menu.scale = 0.0f;
    id a1 = [CCScaleTo actionWithDuration:0.5f scale:1.0f];
    id a2 = [CCEaseBackOut actionWithAction:a1];
    id a3 = [CCFadeIn actionWithDuration:0.3f];
    id a4 = [CCSpawn actions:a2,a3, nil];
    [menu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.9],a4,nil]];
    
    Playmenu = [CCMenu menuWithItems:menu, nil];
    Playmenu.anchorPoint = ccp(0,0);
    Playmenu.position = ccp(0,0);
    [self addChild:Playmenu z:1];
    
    

}

-(void)NameLists  //**********开发人员
{
    NSLog(@"Lists!!");
    isOpenList = YES;
    
    CGSize wSize = [[CCDirector sharedDirector] winSize];
    
    if([self getChildByTag:5] && [self getChildByTag:6])//[spriteBatchNode getChildByTag:4]
    {
        //[spriteBatchNode removeChild:((CCSprite *)[self getChildByTag:4]) cleanup:YES];
        [self removeChild:((CCMenu *)[self getChildByTag:5]) cleanup:YES];
        [self removeChild:((CCMenu *)[self getChildByTag:6]) cleanup:YES];
    }
    
    CCSprite *blacbg = [CCSprite spriteWithSpriteFrameName:@"comic_blackBg"];
    blacbg.anchorPoint = ccp(0,0);
    blacbg.position = ccp(0,0);
    [spriteBatchNode addChild:blacbg z:1 tag:4];
    id d1 = [CCFadeIn actionWithDuration:0.5f];
    [blacbg runAction:d1];
    
    CCSprite *listbar1 = [CCSprite spriteWithSpriteFrameName:@"home_ren"];
    CCSprite *listbar2 = [CCSprite spriteWithSpriteFrameName:@"home_ren"];
    CCMenuItem *listitem = [CCMenuItemSprite itemFromNormalSprite:listbar1 selectedSprite:listbar2];
    listitem.anchorPoint = ccp(0.5,0.5);
    listitem.position = ccp(wSize.width/2,wSize.height/2);
    CCMenu *list = [CCMenu menuWithItems:listitem, nil];
    list.anchorPoint = ccp(0,0);
    list.position = ccp(0,wSize.height+600);
    [self addChild:list z:3 tag:5];
    
    id b1 = [CCMoveTo actionWithDuration:0.6f position:ccp(0,0)];
    id b2 = [CCEaseBackOut actionWithAction:b1];
    [list runAction:b2];
    
    CCSprite *close1 = [CCSprite spriteWithSpriteFrameName:@"home_ren_bt_1"];
    CCSprite *close2 = [CCSprite spriteWithSpriteFrameName:@"home_ren_bt_2"];
    CCMenuItem *item = [CCMenuItemSprite itemFromNormalSprite:close1 selectedSprite:close2 target:self selector:@selector(CloseList)];
    item.anchorPoint = ccp(0.5,0.5);
    item.position = ccp(890,620);
    CCMenu *CloseButton = [CCMenu menuWithItems:item, nil];
    CloseButton.anchorPoint = ccp(0,0);
    CloseButton.position = ccp(0,wSize.height+600);
    [self addChild:CloseButton z:3 tag:6];
    
    id c1 = [CCMoveTo actionWithDuration:0.6f position:ccp(0,0)];
    id c2 = [CCEaseBackOut actionWithAction:c1];
    [CloseButton runAction:c2];
    
}

-(void)CloseList  //**********关闭开发人员表函数
{
    
    CGSize wSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *blackbg = (CCSprite *)[spriteBatchNode getChildByTag:4];
//    id a1 = [CCFadeOut actionWithDuration:0.5f];
//    [blackbg runAction:a1];
    [spriteBatchNode removeChild:blackbg cleanup:YES];
    
    CCMenu *list = (CCMenu *)[self getChildByTag:5];
    id b1 = [CCMoveTo actionWithDuration:0.6f position:ccp(0,wSize.height+600)];
    id b2 = [CCEaseBackIn actionWithAction:b1];
    [list runAction:b2];
    
    CCMenu *CloseButton = (CCMenu *)[self getChildByTag:6];
    id c1 = [CCMoveTo actionWithDuration:0.6f position:ccp(0,wSize.height+600)];
    id c2 = [CCEaseBackIn actionWithAction:c1];
    id c3 = [CCSequence actions:c2,[CCCallBlock actionWithBlock:BCA(^(void){
        isOpenList = NO;
    })], nil];
    [CloseButton runAction:c3];
    
    //[self removeChild:list cleanup:YES];
    //[self removeChild:CloseButton cleanup:YES];
}

-(void)PlayStory  //**********开始按钮调用的函数
{
    if(isOpenList)
        return;
    NSLog(@"Story!");
    [self nextScene];
}

-(void)Zhongzi  //**********跳动的种子
{
    ZhongZi = [CCSprite spriteWithSpriteFrameName:@"home_zhongzi"];
    ZhongZi.anchorPoint = ccp(0.5,0.5);
    ZhongZi.position = ccp(480,80);
    [spriteBatchNode addChild:ZhongZi z:1];
    
    id a1 = [CCMoveTo actionWithDuration:0.5f position:ccp(480,200)];
    id a2 = [CCEaseIn actionWithAction:a1 rate:0.4];
    id a3 = [CCMoveTo actionWithDuration:0.5f position:ccp(480,80)];
    id a4 = [CCEaseOut actionWithAction:a3 rate:0.4];
    id a5 = [CCRotateBy actionWithDuration:0.5f angle:180];
    id a6 = [CCSpawn actions:a2,a5, nil];
    id a7 = [CCRotateBy actionWithDuration:0.5f angle:180];
    id a8 = [CCSpawn actions:a4,a7, nil];
    id a9 = [CCSequence actions:[CCDelayTime actionWithDuration:0.8f],a6,a8,[CCDelayTime actionWithDuration:0.8f], nil];
    id a0 = [CCRepeatForever actionWithAction:a9];
    [ZhongZi runAction:a0];
    
}

-(void)nextScene
{
    CCScene* scenec = [CCScene node];
    [scenec addChild:[MainMenu scene]];
    //实体－透明－实体(默认无颜色，可以附带颜色)
    CCTransitionFade *transitionScene = [CCTransitionFade transitionWithDuration:1.0f scene:[PageCommon scene] withColor:ccBLACK];
    
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
-(void)onEnterTransitionDidFinish
{
    [self StartMenu];
    //[self PiaoChongFly];
    //[self Zhongzi];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return !isOpenList;
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];
    
    CGPoint local = [PiaoChong convertToNodeSpace:location];
    CGRect r=(CGRect)[PiaoChong boundingBox];
    r.origin = CGPointZero;
    
    if (CGRectContainsPoint(r, local)) {
        [self NameLists];
    }

}
- (void) dealloc
{
	[super dealloc];
}
@end
