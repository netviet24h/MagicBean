//
//  index_Scene.m
//  ZhongziMulu
//
//  Created by ice on 12-8-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "index_Scene.h"

extern int sceneIdx;
//#define PTM_RATIO 32
@implementation myLayer

@end
@implementation index_Scene
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	index_Scene *layer = [index_Scene node];
	[scene addChild: layer];
	return scene;
}
-(id) init
{
	if( (self=[super init])) {
        
		self.isTouchEnabled = YES;
    
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
		
		// Define the gravity vector.
		b2Vec2 gravity;
		gravity.Set(0.0f, -40.0f);
        bool doSleep = false;
        world = new b2World(gravity);
        world->SetAllowSleeping(doSleep);
        world->SetContinuousPhysics(true);
        
        // Debug Draw functions
        //m_debugDraw = new GLESDebugDraw( PTM_RATIO );
        //world->SetDebugDraw(m_debugDraw);
		
        uint32 flags = 0;
        flags += b2Draw::e_shapeBit;
        flags += b2Draw::e_jointBit;
        //		flags += b2Draw::e_aabbBit;
        //		flags += b2Draw::e_pairBit;
        //		flags += b2Draw::e_centerOfMassBit;
        //m_debugDraw->SetFlags(flags);				
		
		
		// Define the ground body.
		b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0); // bottom-left corner
		
		// Call the body factory which allocates memory for the ground body
		// from a pool and creates the ground box shape (also from a pool).
		// The body is also added to the world.
		b2Body* groundBody = world->CreateBody(&groundBodyDef);
		
		// Define the ground box shape.
		b2EdgeShape groundBox;
        
		// bottom
		groundBox.Set(b2Vec2(-5,-157/PTM_RATIO), b2Vec2((screenSize.width)/PTM_RATIO+5,-157/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
		
		// top
		groundBox.Set(b2Vec2(-5,(screenSize.height+157)/PTM_RATIO), b2Vec2((screenSize.width)/PTM_RATIO+5,(screenSize.height+157)/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
		
		// left
		groundBox.Set(b2Vec2(-5,(screenSize.height+157)/PTM_RATIO), b2Vec2(-5,-157/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
		
		// right
		groundBox.Set(b2Vec2((screenSize.width)/PTM_RATIO+5,(screenSize.height+157)/PTM_RATIO), b2Vec2((screenSize.width)/PTM_RATIO+5,-157/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
        
        
        // center 中间的挡板
        groundBox.Set(b2Vec2(-5,(screenSize.height/2+10)/PTM_RATIO), b2Vec2((screenSize.width)/PTM_RATIO+5,(screenSize.height/2+10)/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
		
        // center 中间的挡板
        groundBox.Set(b2Vec2(-5,(screenSize.height/2-10)/PTM_RATIO), b2Vec2((screenSize.width)/PTM_RATIO+5,(screenSize.height/2-10)/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
        
        [self schedule: @selector(tick:)];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"index_Scene.plist"];
        spriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"index_Scene.pvr.ccz"];
        [self addChild:spriteBatchNode z:-1];
        
        isMusicOn = NO;
        [self List];
		[self BackGround];
        [self MusicButton];
        [self CloseButton];
        
        self.isAccelerometerEnabled = YES;
	}
	return self;
	}
-(void)BackGround  //****************背景，包括挡板
{
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"index_Scene.plist"];
    CCSprite *bg1 = [CCSprite spriteWithSpriteFrameName:@"index_bg"];
    bg1.anchorPoint = ccp(0,0);
    bg1.position = ccp(0,0);
    [self addChild:bg1 z:0];
    
//    //CCSprite *bg2 = [CCSprite spriteWithSpriteFrameName:@"index_cd_1"];
//    //CCSprite *bg2 = [CCSprite spriteWithFile:@"index_cd_1.png"];
//    MaskBarSprite *bg2 = [MaskBarSprite spriteWithSpriteFrameName:@"index_cd_1"];
//    bg2.anchorPoint = ccp(0,0);
//    bg2.position = ccp(0,0);
//    [self addChild:bg2 z:2];
//    [bg2 isTheSprite:bg2];
    myLayer *bglayer ;
     
    bglayer = [myLayer node];
    bglayer.isTouchEnabled = YES;
    [self addChild:bglayer z:2];
    CCSprite *bg3 = [CCSprite spriteWithSpriteFrameName:@"index_cd"];
    bg3.anchorPoint = ccp(0,0);
    bg3.position = ccp(0,0);
    [bglayer addChild:bg3 z:2 ];

}
-(void)MusicButton 
{
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"index_Scene.plist"];
    
    CCSprite *spMask = [CCSprite spriteWithSpriteFrameName:@"index_mu_mask"];
    CCMenuItem *itemMask = [CCMenuItemSprite itemFromNormalSprite:spMask selectedSprite:spMask block:BCA(^(void){
    })];
    itemMask.position = ccp(60,395);
    CCMenu *menuMask = [CCMenu menuWithItems:itemMask, nil];
    menuMask.anchorPoint = CGPointZero;
    menuMask.position = CGPointZero;
    [self addChild:menuMask z:4];
    
    
    
    CCSprite *spOn1 = [CCSprite spriteWithSpriteFrameName:@"index_mu_1"];
    CCSprite *spOff1 = [CCSprite spriteWithSpriteFrameName:@"index_mu_2"];
    CCSprite *spOn2 = [CCSprite spriteWithSpriteFrameName:@"index_mu_1"];
    CCSprite *spOff2 = [CCSprite spriteWithSpriteFrameName:@"index_mu_2"];
    
  
    CCMenuItem *musicItem1;
    CCMenuItem *musicItem2;
    CCMenuItemToggle *musicTurn;
    CCMenu *musicMenu;
    musicItem1 = [CCMenuItemSprite itemFromNormalSprite:spOn1 selectedSprite:spOff1 ];
    musicItem2 = [CCMenuItemSprite itemFromNormalSprite:spOff2 selectedSprite:spOn2 ];
    
    if (isMusicOn == YES) {
        musicTurn = [CCMenuItemToggle itemWithTarget:self selector:@selector(MusicChange) items:musicItem1,musicItem2, nil];
    }
    else {
        musicTurn = [CCMenuItemToggle itemWithTarget:self selector:@selector(MusicChange) items:musicItem2,musicItem1, nil];
    }
    
    musicTurn.anchorPoint = ccp(0.5,0.5);
    musicTurn.position = ccp(60,395);
    
    musicMenu = [CCMenu menuWithItems:musicTurn, nil];
    musicMenu.anchorPoint = ccp(0,0);
    musicMenu.position = ccp(0,0);
    [self addChild:musicMenu z:4];
    
   
}
-(void)MusicChange
{
    if (isMusicOn == YES)
    {
        isMusicOn = NO;
    }
    else 
    {
        isMusicOn = YES;
    }
}
-(void)CloseButton
{
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"index_Scene.plist"];
    
    
    CCSprite *spMask = [CCSprite spriteWithSpriteFrameName:@"index_play_mask"];
    CCMenuItem *itemMask = [CCMenuItemSprite itemFromNormalSprite:spMask selectedSprite:spMask block:BCA(^(void){   
        
        //[item selected];
        //[self CloseList];
    })];
    itemMask.position = ccp(962,395);
    CCMenu *menuMask = [CCMenu menuWithItems:itemMask, nil];
    //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:menuMask priority:-128 swallowsTouches:NO];
    menuMask.anchorPoint = CGPointZero;
    menuMask.position = CGPointZero;
    [self addChild:menuMask z:4];
    
    
    CCSprite *close1 = [CCSprite spriteWithSpriteFrameName:@"index_play_1"];
    CCSprite *close2 = [CCSprite spriteWithSpriteFrameName:@"index_play_2"];
    
    CCMenuItem *item = [CCMenuItemSprite itemFromNormalSprite:close2 selectedSprite:close1 target:self selector:@selector(CloseList)];
    item.anchorPoint = ccp(0.5,0.5);
    item.position = ccp(962,395);
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.anchorPoint = ccp(0,0);
    menu.position = ccp(0,0);
    [self addChild:menu z:5];
    
    
    
}
-(void)CloseList
{
    NSLog(@"Closed!!");
    CCScene* scenec = [CCScene node];
    [scenec addChild:[MainMenu scene]];
    //实体－透明－实体(默认无颜色，可以附带颜色)
    CCTransitionFade *transitionScene = [CCTransitionFade transitionWithDuration:1.0f scene:[PageCommon scene] withColor:ccWHITE];
    
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}


-(void)List     //*********************目录
{
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"index_Scene.plist"];
    CCMenuItemSprite *item[14];
    CCMenu *menu;
    
    for (int i=1; i<=14; i++) {
        CCSprite *sp1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"index_y_%d",i]];
        CCSprite *sp2 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"index_y_%d",i]];
        
        Lists = [[NSMutableArray alloc] init];
        
        if(i < 8)
        {
            item[i-1] = [CCMenuItemSprite itemFromNormalSprite:sp1 selectedSprite:sp2 target:self selector:@selector(GotoList:)];
            item[i-1].anchorPoint = ccp(0.5,0.5);
            item[i-1].position = ccp(147*i-72.5,700);
            item[i-1].tag = i;
        
        }
        else {
            item[i-1] = [CCMenuItemSprite itemFromNormalSprite:sp1 selectedSprite:sp2 target:self selector:@selector(GotoList:)];
            item[i-1].anchorPoint = ccp(0.5,0.5);
            item[i-1].position = ccp(147*(15-i)-72.5,215);
            item[i-1].tag = i;
        }
        
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation=YES;
        bodyDef.position.Set(item[i-1].position.x/PTM_RATIO, item[i-1].position.y/PTM_RATIO);
        bodyDef.userData = item[i-1];
        b2Body *body = world->CreateBody(&bodyDef);
        
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox;
        dynamicBox.SetAsBox(72.5f/PTM_RATIO,215.0f/PTM_RATIO);//These are mid points for our 1m box
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;	
        fixtureDef.density = [Common createRandomsizeValueFloat:0.8 toFloat:1.5];
        fixtureDef.friction = [Common createRandomsizeValueFloat:0.2 toFloat:0.6];
        fixtureDef.restitution= (float)[Common createRandomsizeValueFloat:0.1 toFloat:0.4];
        body->CreateFixture(&fixtureDef);
        
        
        
    }
    menu = [CCMenu menuWithItems:item[0],item[1],item[2],item[3],item[4],item[5],item[6],item[7],item[8],item[9],item[10],item[11],item[12],item[13], nil];
    menu.anchorPoint = ccp(0,0);
    menu.position = ccp(0,0);
    [self addChild:menu z:1];
    //NSLog(@"%d",menu.tag);
    
}

-(void)GotoList:(id)sender      //****************目录的回调函数
{
    int mtag = ((CCMenu *)sender).tag;
    CCScene *scene = [CCScene node];
    if (mtag == 1) {
        scene = [MainMenu scene];
        sceneIdx = mtag;
    }
    else {
        sceneIdx = mtag*2-2;
        PageCommon *layer = [NSClassFromString([NSString stringWithFormat:@"PageLayer%d",mtag*2-2]) node];
        [scene addChild:layer];

    }
    CCTransitionFade *transitionScene = [CCTransitionFade transitionWithDuration:0.5f scene:scene ];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	if (world) {
		
		world->DrawDebugData();
	}
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}

-(void) tick: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
    
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}	
	}
}


- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( accelY * 40, -accelX * 40);
	
	world->SetGravity( gravity );
}

- (void) dealloc
{
	delete world;
	world = NULL;
	delete m_debugDraw;

	[super dealloc];
}
@end
