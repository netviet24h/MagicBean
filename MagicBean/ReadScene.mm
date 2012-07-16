//
//  ReadScene.mm
//  GlassPrince
//
//  Created by Ivan on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define CCCA(x) [[x copy] autorelease]
#import "ReadScene.h"
int sceneIdx = 1;
Class selectAction(int i)
{	
	// HACK: else NSClassFromString will fail
	
	sceneIdx=i;
	NSString *r = [NSString stringWithFormat:@"PageLayer%d",sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}
Class nextAction()
{	
	// HACK: else NSClassFromString will fail
	
	//++sceneIdx;
     sceneIdx+=1;
	NSString *r = [NSString stringWithFormat:@"PageLayer%d",sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}
Class backAction()
{	
	//--sceneIdx;
    sceneIdx-=1;
    
        
    
	// HACK: else NSClassFromString will fail
	NSString *r = [NSString stringWithFormat:@"PageLayer%d",sceneIdx];
    Class c = NSClassFromString(r);
	return c;
}
//123
@implementation readScene
-(void)onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
	[self goFirstPage];
}
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	readScene *layer = [readScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id)init
{
	if ((self = [super init])) {
        //sceneIdx = 1;
		//CCSprite *bg = [CCSprite spriteWithFile:@"g_haibao.jpg"];
		//[self addChild:bg z:0 ];
		//bg.position = ccp(384,512);
		//[self loadNextScene];
		
        //[self goFirstPage];
	}
	return self;
}
-(void)goFirstPage
{
	NSString *r = [NSString stringWithFormat:@"PageLayer%d",sceneIdx];
	Class c = NSClassFromString(r);
	CCScene *scene = [CCScene node];
	[scene addChild:[c node]];
	//self.isAccelerometerEnabled = NO;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:scene]];
	
}
-(void)onExit
{
	[super onExit];

}
-(void)dealloc
{
	[super dealloc];
    
}
@end

@implementation PageCommon
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	//PageCommon *layer1  = [PageCommon node];
	// 'layer' is an autorelease object.
	PageCommon *layer = [NSClassFromString([NSString stringWithFormat:@"PageLayer%d",sceneIdx]) node];
	
	//layerWrite.anchorPoint = CGPointZero;
	// add layer as a child to scene
	[scene addChild: layer ];
    
	//[scene addChild:layer1];
	
	// return the scene
	return scene;
}
-(void)addSpriteName:(NSString*)_name position:(CGPoint)_pos ToBgNode:(CCNode*)_node 
                   z:(int)_z opacity:(GLubyte)_opacity tag:(NSInteger)_tag
{
    CCSprite *sp = [CCSprite spriteWithSpriteFrameName:_name];
    sp.position = _pos;
    sp.opacity = _opacity;
    [_node addChild:sp z:_z tag:_tag];
}
-(void)addSpriteName:(NSString*)_name position:(CGPoint)_pos z:(int)_z
{
    CCSprite *sp = [CCSprite spriteWithSpriteFrameName:_name];
    sp.position = _pos;
    [spritesBgNode addChild:sp z:_z];
    
}
-(id)init
{
	if ((self = [super initWithColor:ccc4(255, 255, 255, 255)])) {
        
        
		screenSize = [CCDirector sharedDirector].winSize;
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"p%d.pvr.ccz",sceneIdx]];
        useBox2d = NO;
        [self addChild:spritesBgNode z:-1];
       	[self initMenu];

    }
	return self;
}
-(void)loadSpriteSheet
{
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d.plist",sceneIdx]];
	if (isJigsaw) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%dOther.plist",sceneIdx]];
    }
}
-(void)initMenu
{
    
    CCLOG(@"in layer%d",sceneIdx);
    if (sceneIdx%2==1) {
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
        CCSprite *bg = [CCSprite spriteWithFile:@"g_background.jpg"];
        [self addChild:bg z:-3];
         bg.position = ccp(screenSize.width/2,screenSize.height/2);
        NSString *wenzi =[NSString stringWithFormat:@"P%dLABEL",sceneIdx];        
        wenzi = NSLocalizedString(wenzi, nil);
        label = [CCLabelTTF labelWithString:wenzi dimensions:CGSizeMake(700, 200) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeClip fontName:@"FZMWFont.ttf" fontSize:25];
        [self addChild:label z:20];
        label.anchorPoint = ccp(0.5,1);
        label.color = ccc3(0, 0, 0);
        label.position = ccp(500,492);//for ipad
    }
//	CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"Anniu_C_Left_up_35.996.png" selectedImage:@"Anniu_C_Left_down_35.996.png" target:self selector:@selector(backCallback:)];
//	CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"Anniu_C_Setup_up_725.45.png" selectedImage:@"Anniu_C_Setup_down_725.45.png" target:self selector:@selector(menuCallback:)];
//	CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"Anniu_C_Right_up_733.996.png" selectedImage:@"Anniu_C_Right_down_733.996.png" target:self selector:@selector(nextCallback:)];
//    item1.position = ccp( 35,27.5);
//	item2.position = ccp( 982,768-45);
//	item3.position = ccp( 983,27.5);
    CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"l_1.png" selectedImage:@"l_2.png" target:self selector:@selector(backCallback:)];
	CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"Anniu_C_Setup_up_725.45.png" selectedImage:@"Anniu_C_Setup_down_725.45.png" target:self selector:@selector(menuCallback:)];
	CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"r_1.png" selectedImage:@"r_2.png" target:self selector:@selector(nextCallback:)];
	CCMenu *menu = [CCMenu menuWithItems:item1, item2, item3, nil];
	menu.position = CGPointZero;
    item1.position = ccp( item1.contentSize.width/2,item1.contentSize.height/2);
	item2.position = ccp( 982,768-45);//for ipad
	item3.position = ccp( screenSize.width-item3.contentSize.width/2,item1.contentSize.height/2);	
	[self addChild:menu z:10];
}
-(void)initBox2d
{
    useBox2d = YES;
	CCLOG(@"initBox2d");
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
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
	groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;		
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
	groundBottom = groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,screenSize.height/PTM_RATIO+5), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO+5));
    groundTop = groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,screenSize.height/PTM_RATIO+5), b2Vec2(0,0));
	groundLeft = groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO+5), b2Vec2(screenSize.width/PTM_RATIO,0));
	groundRight = groundBody->CreateFixture(&groundBox,0);
	
	
	[self schedule:@selector(tick:)];
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
            //b->SetTransform(pos,angle);
		}	
	}
}
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
    if (!useBox2d) {
        return;
    }
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
    #define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( -accelY * 10, accelX * 10);
	
	world->SetGravity( gravity );
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
-(BOOL)isInBox:(CGPoint)p sprite:(CCSprite*)m_texture
{
	
	if (p.x >  m_texture.position.x-m_texture.contentSize.width/2 && p.x < m_texture.position.x+m_texture.contentSize.width/2 
		&& p.y> m_texture.position.y-m_texture.contentSize.height/2-2 &&p.y<m_texture.position.y+m_texture.contentSize.height/2) {
		//isSelected = YES;
		CCLOG(@"inBox");
		return YES;
	}
	else {
		//isSelected = NO;
		return NO;
	}
	//return isSelected;
	
}
-(void)onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
    
    
    //[self loadSpriteSheet];
	//[[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
}
- (void) onEnter     
{
	[super onEnter];
    self.isTouchEnabled = YES;
    if (isJigsaw) {
        self.isTouchEnabled = NO;
    }
	//self.isAccelerometerEnabled = YES;

}
- (void) onExitTransitionDidStart
{
    
}
- (void) onExit
{
	[super onExit];
	
	
	//[CCTextureCache purgeSharedTextureCache];
	//[CCSpriteFrameCache purgeSharedSpriteFrameCache];
	self.isAccelerometerEnabled = NO;
    self.isTouchEnabled = NO;
    useBox2d = NO;

    
}
-(void)nextCallback:(id) sender
{
	if (sceneIdx>MaxPage) {
		return;
	}
	Class layer = nextAction();
	nextScene = [CCScene node];
	[nextScene addChild:[layer node]];
	[self unschedule:@selector(tick:)];
	self.isAccelerometerEnabled = NO;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:nextScene backwards:NO]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"page" ofType:@"wav"];
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
	AudioServicesPlaySystemSound (soundID);	
}
-(void)backCallback:(id) sender
{
	if (sceneIdx<=1) {
        CCLOG(@"1231231");
        [[CCDirector sharedDirector] replaceScene: 
         [CCTransitionFade  transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccc3(0, 0, 0)]];
		return;
	}
	Class layer = backAction();
	preScene = [CCScene node];
	[preScene addChild:[layer node]];
	self.isAccelerometerEnabled = NO;
	[self unschedule:@selector(tick:)];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:preScene backwards:YES]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"page" ofType:@"wav"];
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
	AudioServicesPlaySystemSound (soundID);	
}	
-(void)menuCallback:(id) sender
{
	self.isAccelerometerEnabled = NO;
	[self unschedule:@selector(tick:)];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[NSClassFromString([NSString stringWithFormat:@"PageLayer%d",sceneIdx])  scene]]];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"menubtn" ofType:@"wav"];
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
	AudioServicesPlaySystemSound (soundID);	
	
}
-(void)loadNextScene
{
	NSAutoreleasePool * pool = [ [ NSAutoreleasePool alloc ] init ];
	/* your code... */
	
	for (NSString *str in imageArr) {
		[[CCTextureCache sharedTextureCache] addImageAsync:str target:self selector:@selector(canNext)];
	}
	[ pool release ];
	
	
	
}
-(void)canNext
{
	CCLOG(@"load ready %@",[self class]);
}
/*regist box2d touch method*/
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!useBox2d) {
        return;
    }
	if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 100000000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
	
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	if (!useBox2d) {
        return;
    }
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
	
}
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (!useBox2d) {
        return;
    }
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation=[touch locationInView:[touch view]];
	touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];

	if (m_mouseJoint) {
		
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!useBox2d) {
        return;
    }
	for( UITouch *touch in touches ) {
    }
}
-(void)dealloc
{
	[super dealloc];
	delete world;
	world = NULL;
	delete m_debugDraw;
	m_debugDraw = NULL;
    if ([emitter_ retainCount]!=0) {
        [emitter_ release];
    }
}
@end

@implementation NSObject(forDebuge)
#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif

@end


@implementation PageLayer1
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
- (void)onEnter
{
    [super onEnter];
    
    
//   emitter_ = [[CCParticleSystemQuad alloc] initWithFile:@"LavaFlow.plist"];
//    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:YES]; 
//	[self addChild:batchNode_];
    
 
}
-(void)onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
    [self loadSpriteSheet];
	for (int i = 0; i < 4;  i++) {
		CCSprite *sp = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p1_%d",i+1]];
		//sp.anchorPoint = ccp(0,0);
		//sp.position = CGPointZero;
		sp.position = ccp(screenSize.width/2,-sp.contentSize.height/2);
		// sp.position = ccp(512,sp.contentSize.height/2);
		[spritesBgNode  addChild:sp z:5-i tag:i+100];
		id ac = [CCMoveBy actionWithDuration:0.5 position:ccp(0,sp.contentSize.height)];
		//            id ac1 = [CCEaseElasticInOut actionWithAction:ac period:3.0];
		//            id ac1 = [CCEaseBounceInOut actionWithAction:ac ];
		//            id ac1 = [CCEaseExponentialInOut actionWithAction:ac];
		id ac1 = [CCEaseElasticInOut actionWithAction:ac period:0.5];
		id as = [CCSequence actions:[CCDelayTime actionWithDuration:i*0.13],ac1, nil];
		[sp runAction:as];
	}
	
	//CCLabelTTF *label = [CCLabelTTF labelWithString: dimensions:<#(CGSize)dimensions#> alignment:<#(int)alignment#> fontName:<#(NSString *)name#> fontSize:<#(CGFloat)size#>]
}
- (id)init
{
	if ((self = [super init])) {
		CCLOG(@"in layer1");
		//[self initBox2d];
        [self loadSpriteSheet];
        vel = ccp(1.5,0);
        //cloud 
		for (int i = 0 ; i<5; i++) {
			cloud[i] = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p1_yun_%d",[Common createRandomsizeValueInt:1 toInt:2]]];
			cloud[i].position = ccp(i*200+50,screenSize.height-cloud[i].contentSize.height/2-50 + [Common createRandomsizeValueFloat:-1 toFloat:1] *50);//for ipad
			[spritesBgNode addChild:cloud[i] z:2];
		}
        [self schedule:@selector(step:)];
    } 
	
	return self;
}
-(void)step:(ccTime)dt
{
    float x,y;
    x = cloud[0].position.x;
    y = cloud[0].position.y;
    x-=vel.x*0.75;
    //出街判断
    if (x<=-cloud[0].contentSize.width/2) {
        x = screenSize.width+cloud[0].contentSize.width;		
        y += [Common createRandomsizeValueFloat:-1 toFloat:1]*30 ;
    }
    cloud[0].position = ccp(x,y);
    
    x = cloud[1].position.x;
    y = cloud[1].position.y;
    x-=vel.x*0.5;
    //出街判断
    if (x<=-cloud[1].contentSize.width/2) {
        x = screenSize.width+cloud[1].contentSize.width;		
        y += [Common createRandomsizeValueFloat:-1 toFloat:1]*30 ;
    }
    cloud[1].position = ccp(x,y);
    
    x = cloud[2].position.x;
    y = cloud[2].position.y;
    x-=vel.x*0.3;
    //出街判断
    if (x<=-cloud[2].contentSize.width/2) {
        x = screenSize.width+cloud[2].contentSize.width;		
        y += [Common createRandomsizeValueFloat:-1 toFloat:1]*30 ;
    }
    cloud[2].position = ccp(x,y);
    
    x = cloud[3].position.x;
    y = cloud[3].position.y;
    x-=vel.x*0.2;
    //出街判断
    if (x<=-cloud[3].contentSize.width/2) {
        x = screenSize.width+cloud[3].contentSize.width;		
        y += [Common createRandomsizeValueFloat:-1 toFloat:1]*30 ;
    }
    cloud[3].position = ccp(x,y);
    
    x = cloud[4].position.x;
    y = cloud[4].position.y;
    x-=vel.x*0.4;
    //出街判断
    if (x<=-cloud[4].contentSize.width/2) {
        x = screenSize.width+cloud[4].contentSize.width;		
        y += [Common createRandomsizeValueFloat:-1 toFloat:1]*30 ;
    }
    cloud[4].position = ccp(x,y);
    
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
}
/*********
 HookesLaw
 -(void)applyHookesLaw:(b2Body*)bodyA:(b2Body*)bodyB:(float) k:(float) friction:(float)desiredDist
{
 b2Vec2 pA=bodyA->GetPosition();
 b2Vec2 pB=bodyB->GetPosition();
 b2Vec2 diff=pB- pA;
 b2Vec2 vA=bodyA->GetLinearVelocity();
 b2Vec2 vB=bodyB->GetLinearVelocity();
 b2Vec2 vdiff=vB-vA;
 float dx=diff.Normalize();
 float forceMag= -k*(dx-desiredDist);//-friction*vrel;
 diff*=forceMag;
 bodyA->ApplyForce(-1*diff - friction*vdiff,bodyB->GetPosition());
}
********/
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  	

}
- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  	
    
}
-(void) goToIphone
{
	for (CCSprite *sp in self.children) {
		sp.position = ccp(sp.position.y * (1024.0f/480.0f),sp.position.x *(768.0f/320.0f)   );//for ipad
	}
}
@end

@implementation PageLayer2
-(void)onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
	//[aniWater pauseSchedulerAndActions];
}
-(id)init
{
	if ((self = [super init])) {
		CCLOG(@"in layer2");
       [self loadSpriteSheet];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p2_bg"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg z:0];
        
        CCSprite *spRabit = [CCSprite spriteWithSpriteFrameName:@"p2_mama"]; 
        spRabit.position =  ccp(331,397);//for ipad
        [spritesBgNode addChild:spRabit z:1 tag:100];
        
        CCSprite *aniWater = [CCSprite spriteWithSpriteFrameName:@"p2_w1"];
		aniWater.position = ccp(-36,95);//for ipad
		[spRabit addChild:aniWater z:1 tag:100];
				
        NSMutableArray *aniFrame = [NSMutableArray array];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_w2"]];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_w3"]];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_w1"]];
        id animation = [CCAnimation animationWithFrames:aniFrame delay:0.2];
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:ani];
		[a setTag:101];
        [aniWater runAction:a];
		


		
		//[aniWater stopAllActions];
        [aniWater pauseSchedulerAndActions];
        CCSprite *spFront = [CCSprite spriteWithSpriteFrameName:@"p2_zl"];
        spFront.position = ccp(353,61);//for ipad
        [spritesBgNode addChild:spFront z:2];
	}
	return self;
}
//-(void)registerWithTouchDispatcher
//{
//    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
//}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[super ccTouchesBegan:touches withEvent:event];
	CCSprite *rabbit = (CCSprite*)[spritesBgNode getChildByTag:100];
	CCSprite *watter = (CCSprite*)[rabbit getChildByTag:100];
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [self convertTouchToNodeSpace:touch];
	if (CGRectContainsPoint(rabbit.boundingBox, rightPosition)) {
		canMove = YES;
        [self loadSpriteSheet];
        NSMutableArray *aniFrame = [NSMutableArray array];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_mama_2"]];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_mama"]];
        id animation = [CCAnimation animationWithFrames:aniFrame delay:0.15];
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:ani];
		[a setTag:101];
        [rabbit runAction:a];
		[watter resumeSchedulerAndActions];
		//[watter runAction:action];
		emitter_ = [[CCParticleSystemQuad alloc] initWithFile:@"waterFade.plist"];
		//emitter_.duration = 0.1;
		batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:YES]; 
		emitter_.position = [watter convertToWorldSpaceAR:ccpAdd(watter.position, ccp(0,-100))];
		emitter_.blendAdditive = NO;  
		[batchNode_ addChild:emitter_];
		[self addChild:batchNode_];
        
	}
	else {
		canMove = NO;
	}

}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCSprite *rabbit = (CCSprite*)[spritesBgNode getChildByTag:100];
	CCSprite *watter = (CCSprite*)[rabbit getChildByTag:100];
	UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [self convertTouchToNodeSpace:touch];
    
	CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation  = ccpSub(rightPosition,oldTouchLocation);
    
    if (canMove) {
        
        rabbit.position = ccpAdd(rabbit.position,translation);
        double retvalY=rabbit.position.y;
        retvalY = MIN(retvalY, 494);//for ipad
        retvalY = MAX(retvalY, 397); //for ipad
        rabbit.position = ccp(rabbit.position.x,retvalY); 
        
		emitter_.position = [watter convertToWorldSpaceAR:ccpAdd(watter.position, ccp(0,-100))];
		rabbit.scale = (screenSize.height - rabbit.position.y-(screenSize.height-494))/((494-397)/(1-0.43f))+0.43f;
       // emitter_.scale = rabbit.scale;
		//emitter_.scale = (screenSize.height - rabbit.position.y)/1097.0f+0.3;
        CCLOG(@"x=%f,y=%f scal%f",rightPosition.x,rightPosition.y,rabbit.scale);

	}
    
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (canMove) {
        CCSprite *rabbit = (CCSprite*)[spritesBgNode getChildByTag:100];
        CCSprite *watter = (CCSprite*)[rabbit getChildByTag:100];
        [rabbit stopActionByTag:101];
        UITouch *touch = [touches anyObject];
        CGPoint rightPosition = [touch locationInView:[touch view]];
        rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
        [watter pauseSchedulerAndActions];
        //[batchNode_ removeChild:emitter_ cleanup:YES];
        [emitter_ stopSystem];
        canMove = NO;

    }
        
}
@end      

@implementation PageLayer3
-(void)onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
    [self loadSpriteSheet];
	CCSprite *aniBag = [CCSprite spriteWithSpriteFrameName:@"p3_bag1"];
	aniBag.position = ccp(screenSize.width/2,509.5);//for ipad
	[spritesBgNode addChild:aniBag z:3];
	
    
    
	NSMutableArray *aniFrame = [NSMutableArray array];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag2"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag2"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag3"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag4"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag5"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag6"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag7"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag7"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag8"]];
	[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag8"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag8"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag9"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag9"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag9"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag10"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag10"]];
     [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag10"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p3_bag11"]];
	id animation = [CCAnimation animationWithFrames:aniFrame delay:0.03];
	id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
	//id a = [CCRepeatForever actionWithAction:ani];
	id as = [CCSequence actionOne:ani two:[CCCallBlock actionWithBlock:BCA(^(void){
		CCSprite *sprBag = [CCSprite spriteWithSpriteFrameName:@"p3_bag"];
		sprBag.position = ccp(513,320);//for ipad
		[spritesBgNode addChild:sprBag z:1 tag:100];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p3_body.plist"];
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(sprBag.position.x/PTM_RATIO, sprBag.position.y/PTM_RATIO);
        bodyDef.userData = sprBag;	
        b2Body *bodyTable = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bodyTable forShapeName:@"p3_bag"];
        [sprBag setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p3_bag"]];
		[spritesBgNode removeChild:aniBag cleanup:YES];
	})]];
	[aniBag runAction:as];
	
}
-(id)init
{
	if ((self = [super init])) {
        self.isAccelerometerEnabled = NO;
        
		CCLOG(@"in layer3");
        [self loadSpriteSheet];
        [self initBox2d];
        world->SetGravity(b2Vec2(0,-40));
		CCSprite *sprTable = [CCSprite spriteWithSpriteFrameName:@"p3_zz"];
		[spritesBgNode addChild:sprTable z:1];
		sprTable.position = ccp(screenSize.width/2,sprTable.contentSize.height/2);
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p3_body.plist"];
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(sprTable.position.x/PTM_RATIO, sprTable.position.y/PTM_RATIO);
        bodyDef.userData = sprTable;	
        b2Body *bodyTable = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bodyTable forShapeName:@"p3_zz"];
        [sprTable setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p3_zz"]];
		[self schedule:@selector(step:)];
        
        
	}
	return self;
}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super ccTouchesBegan:touches withEvent:event];
	CCSprite *bag = (CCSprite*)[spritesBgNode getChildByTag:100];
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    if (m_seedTotle<30) {
        if ([self isInBox:rightPosition sprite:bag] && !isFire) {
            [self unschedule:@selector(step:)];
            m_seedMax = [Common createRandomsizeValueInt:1 toInt:2];
            [self schedule:@selector(fallSeed) interval:0.1];
            isFire = YES;
        }
    }
	
}
-(void)fallSeed
{
    if (m_seedCount >= m_seedMax) {
        [self unschedule:_cmd];
        isFire = NO;
        m_seedMax = 0;
        m_seedCount = 0;
        [self schedule:@selector(step:)];
    }
    else{
        CCSprite *bag = (CCSprite*)[spritesBgNode getChildByTag:100];
        id a1 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
        id a2 = [CCScaleTo actionWithDuration:0.05 scale:1.2];
        [bag runAction:[CCSequence actions:a2,a1, nil]];
        CCSprite *phyBall;
        int ran = arc4random()%4+1;
        //double valY = (double)arc4random() / ARC4RANDOM_MAX * (screenSize.width-60);
        [self loadSpriteSheet];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p3_body.plist"];
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        
        NSString *tmpName = [NSString stringWithFormat:@"p3_seed%d",ran];
        CCLOG(@"%@",tmpName);
        phyBall = [CCSprite spriteWithSpriteFrameName:tmpName];
        phyBall.position = ccp(bag.position.x+10,bag.position.y+bag.contentSize.height/2+15);
        phyBall.opacity = 255;
        phyBall.scale = 0.5 ;
        [phyBall runAction:[CCScaleTo actionWithDuration:0.2 scale:1]];
        id action = [CCFadeIn actionWithDuration:.1f];
        //[phyBall runAction:action];
        
        [spritesBgNode addChild:phyBall z:1];	
        bodyDef.position.Set(phyBall.position.x/PTM_RATIO, phyBall.position.y/PTM_RATIO);
        bodyDef.userData = phyBall;	
        b2Body *bodyGlass = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bodyGlass forShapeName:tmpName];
        [phyBall setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];

        b2Vec2 tmpImpulse = b2Vec2([Common createRandomsizeValueFloat:-25 toFloat:25],[Common createRandomsizeValueFloat:40 toFloat:50]);
        bodyGlass->ApplyLinearImpulse(tmpImpulse,bodyGlass->GetPosition());
        m_seedCount++;
        m_seedTotle++;
    }
 
}
-(void)step:(ccTime)dt//standby
{
    [self schedule:_cmd interval:[Common createRandomsizeValueFloat:1 toFloat:3]];
    CCSprite *bag = (CCSprite*)[spritesBgNode getChildByTag:100];
    id a1 = [CCScaleTo actionWithDuration:0.08 scale:1.0];
    id a2 = [CCScaleTo actionWithDuration:0.08 scale:1.08];
    [bag runAction:[CCSequence actions:a2,a1, nil]];
}

@end

#define kTagBody 100
#define kTagLight 200
@implementation PageLayer4
-(id)init
{
	if ((self = [super init])) {
        
        [self loadSpriteSheet];
        [self initBox2d];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p4_bg"];
		[spritesBgNode addChild:bg z:0];
		bg.position = ccp(screenSize.width/2,screenSize.height/2);
        
        {
            CCSprite *sprTime = [CCSprite spriteWithSpriteFrameName:@"p4_sh"];
            sprTime.position = ccp(508,658);//for ipad
            sprTime.anchorPoint = ccp(0.1,0.5);
            [spritesBgNode addChild:sprTime z:0];
            [sprTime runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.5 angle:360]]];
            sprTime.scaleX = 1;
            sprTime.scaleY = 0.4;
        }
        
        {//分针
            CCSprite *sprTime = [CCSprite spriteWithSpriteFrameName:@"p4_sh"];
            sprTime.position = ccp(508,658);//for ipad
            sprTime.anchorPoint = ccp(0.1,0.5);
            [spritesBgNode addChild:sprTime z:0];
            sprTime.rotation = -120;
            [sprTime runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.5*60 angle:360]]];
            sprTime.scaleX = 0.9;
            sprTime.scaleY = 0.7;
        }
        
        {
            CCSprite *sprTime = [CCSprite spriteWithSpriteFrameName:@"p4_sh"];
            sprTime.position = ccp(508,658);//for ipad
            sprTime.anchorPoint = ccp(0.1,0.5);
            [spritesBgNode addChild:sprTime z:0];
            sprTime.rotation = -49;
            [sprTime runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.5*3600 angle:360]]];
            sprTime.scaleX = 0.65;
            sprTime.scaleY = 1.3;
            
        }
        
        
        
        CCSprite *sprTimeMask = [CCSprite spriteWithSpriteFrameName:@"p4_clock_1"];
        sprTimeMask.position = ccp(508,658);//for ipad
        [spritesBgNode addChild:sprTimeMask z:0];
        
        CCSprite *spTv = [CCSprite spriteWithSpriteFrameName:@"p4_tv"];
        spTv.position = ccp(511,516);//for ipad
        [spritesBgNode addChild:spTv z:0 tag:100];
        
        CCSprite *spLight_L = [CCSprite spriteWithSpriteFrameName:@"p4_l_l"];
        spLight_L.position = ccp(335,345+80);//for ipad
        [spritesBgNode addChild:spLight_L z:1 tag:kTagLight];
        spLight_L.visible = NO;
        
        CCSprite *spLight = [CCSprite spriteWithSpriteFrameName:@"p4_l"];
        spLight.position = ccp(335,345+80);//for ipad
        [spritesBgNode addChild:spLight z:1 ];
        
        
        
        //init baby_rabbit**************//
        //create baby_rabbit
        
        NSString *tmpName = @"p4_x_b";
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p4_body.plist"];
        
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody];
        sprBody.position = ccp(312,321);//for ipad
        
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        bodyDef.fixedRotation = YES;
        b2Body *body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        b2WeldJointDef wjd;
        wjd.dampingRatio = 0.1;
        wjd.frequencyHz = 2;
        wjd.Initialize(body, groundBody, body->GetPosition());
        world->CreateJoint(&wjd);


        
        tmpName = @"p4_x_h";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+1];
        sprBody.position = ccp(309,339-8);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *coatBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:coatBody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(coatBody, body, coatBody->GetPosition());
        rjd.motorSpeed = 0;//1.0f * b2_pi;
        rjd.maxMotorTorque = 0;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/15.0f * b2_pi;
        rjd.upperAngle = 1/15.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        b2DistanceJointDef djd;
//        djd.Initialize(coatBody, groundBody, coatBody->GetPosition(), coatBody->GetPosition());
//        djd.dampingRatio = 0.1;
//        djd.frequencyHz = 1;
//        djd.length = 0;
//        djd.collideConnected = false;
//        world->CreateJoint(&djd);
       
        
        //***********MAMA**************//
        tmpName = @"p4_mamab";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+2];
        sprBody.position = ccp(641,210);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        bodyDef.fixedRotation = YES;
        body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        
        djd.Initialize(body, groundBody,body->GetPosition(),body->GetPosition());
        djd.dampingRatio = 0.5;
        djd.frequencyHz = 15.0;
        djd.length = 0;
        djd.collideConnected = false;
        world->CreateJoint(&djd);
        
        tmpName = @"p4_mama arm";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody+2];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(599,282);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *leftHandBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:leftHandBody forShapeName:tmpName];
        
        rjd.Initialize(leftHandBody, body, leftHandBody->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/80.0f* b2_pi;
        rjd.upperAngle = 1/55.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);

        tmpName = @"p4_mamah";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+1];
        sprBody.position = ccp(640,295);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *mamahead = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:mamahead forShapeName:tmpName];
        
        rjd.Initialize(mamahead, body, mamahead->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 0 * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        CCSprite *sprBall = [CCSprite spriteWithSpriteFrameName:@"p4_ball"];
        [spritesBgNode addChild:sprBall z:1];
        sprBall.position = ccp(912,229+300);//for ipad

//        id a1 = [CCEaseIn actionWithAction:[CCMoveBy actionWithDuration:1.1 position:ccp(0,-300)] rate:3] ;
//        id a2 = [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1.1 position:ccp(0,300)] rate:3] ;
//        id as = [CCSequence actions:a1,a2, nil];
//        id af = [CCRepeatForever actionWithAction:as];
//        [sprBall runAction:af];
        b2EdgeShape groundBox;
        groundBox.Set(b2Vec2(0,193/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,193/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
//        groundBox.Set(b2Vec2((912-sprBall.contentSize.width/2-10)/PTM_RATIO,0), b2Vec2((912-sprBall.contentSize.width/2-10)/PTM_RATIO,(screenSize.height+100)));
//        groundBody->CreateFixture(&groundBox,0);
//        
//        groundBox.Set(b2Vec2((912+sprBall.contentSize.width/2+10)/PTM_RATIO,0), b2Vec2((912+sprBall.contentSize.width/2+10)/PTM_RATIO,(screenSize.height+100)/PTM_RATIO));
//        groundBody->CreateFixture(&groundBox,0);
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBall.position.x/PTM_RATIO,sprBall.position.y/PTM_RATIO );
        bodyDef.userData = sprBall;
        bodyDef.fixedRotation = NO;
        body = world->CreateBody(&bodyDef);

        b2CircleShape circleShape;
        circleShape.m_radius = 	sprBall.contentSize.width/2/PTM_RATIO;
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &circleShape;
        fixtureDef.density = 1.0;
        fixtureDef.friction = 0.1;
        fixtureDef.restitution =  1;
        body->CreateFixture(&fixtureDef);
	}
	return self;
}
-(BOOL)touchedLight:(CGPoint)p
{
    
        CCSprite *m_texture = (CCSprite*)[spritesBgNode getChildByTag:kTagLight];
        
        if (p.x >  m_texture.position.x-73 && p.x < m_texture.position.x+73 
            && p.y> m_texture.position.y+m_texture.contentSize.height/2-80 
            && p.y<m_texture.position.y+m_texture.contentSize.height/2+65) {
            //isSelected = YES;
            CCLOG(@"LightInBox");
            return YES;
        }
        else {
            //isSelected = NO;
            return NO;
        }
        //return isSelected;
        
    
}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super ccTouchesBegan:touches withEvent:event];
    [self loadSpriteSheet];
    
	CCSprite *sprTv = (CCSprite*)[spritesBgNode getChildByTag:100];
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    
     CCSprite *sprLight = (CCSprite*)[spritesBgNode getChildByTag:kTagLight];
    if ([self touchedLight:rightPosition]) {
        if (sprLight.visible) 
            sprLight.visible = NO;
        
        else
            sprLight.visible = YES;
    }
        
    
	if ([self isInBox:rightPosition sprite:sprTv] ) {
        if (isRunTv) {
            [sprTv stopAllActions];
            [sprTv setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4_tv"] ];
            isRunTv = NO;
        }
        else{
            NSMutableArray *aniFrame = [NSMutableArray array];
            [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4_tv_xh1"]];
            [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4_tv_xh2"]];
            [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4_tv_xh3"]];
            [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4_tv_xh4"]];
            id animation = [CCAnimation animationWithFrames:aniFrame delay:0.1];
            id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:YES];
            id af = [CCRepeatForever actionWithAction:ani];
            [sprTv runAction:af];
            isRunTv = YES;
        }
       
	}
	
}
@end
@implementation ButtleFly

-(id)initWithSpriteFrame:(CCSpriteFrame *)spriteFrame point:(CGPoint)p
{
    if(self = [super initWithSpriteFrame:spriteFrame])
    {
       
        speed = 5;
        src = p;
        self.position = src;
        
        //self.rotation = CCRANDOM_0_1()*360;
        
        [self schedule:@selector(movesMissile:)	interval:1/60.0];
		[self schedule:@selector(setRota:) interval:0];
    }
    return self;
}
//#define CCRANDOM_0_1() arc4random() / sizeof(u_int32_t)
-(void)setRota:(ccTime)dt
{
    //srandom(time(NULL));
    ;
	CGPoint desTmp = ccp(CCRANDOM_0_1()*1024,CCRANDOM_0_1()*768);
	CGPoint srcTmp = ccp(self.position.x,self.position.y);
	float deltaX =  desTmp.x - srcTmp.x;
	float deltaY =  desTmp.y - srcTmp.y;
	float angle  = 0;
    //CCLOG(@"%f,%f",desTmp.x,desTmp.y);
	if (deltaX < 0) {
        //self.scaleX = -1;
        //if ( deltaY < 0 ) {
            angle = 180-atanf(deltaY/deltaX)*180/3.14f;
            
            //
	}else {
        if (deltaX > 0) {
            //self.scaleX = 1;
        }
        
        angle = -atanf(deltaY/deltaX)*180/3.14f;
         
	}
    float interval = (CCRANDOM_0_1()*0.1);
	[self schedule:_cmd interval:interval];
	////CCLOG(@"近来了%f",moveTime);
	
//	if (abs(angle)<30) {
//		angle = angle>0?30:-30;
//	}
	//[texture stopAllActions];
	[self runAction:[CCRotateTo actionWithDuration:interval angle:angle]];
	if ((self.position.x>1024||self.position.x<=-10)||(self.position.y <0 || self.position.y>1024)  ) {
		[self unschedule:@selector(movesMissile:)];
		[self unschedule:@selector(setRota:)];
        [self.parent removeChild:self cleanup:YES];
        
	}
	
}
-(void) movesMissile:(ccTime)dt
{
	vel.x = speed * sin(CC_DEGREES_TO_RADIANS(self.rotation))*dt*60;
	vel.y = speed * cos(CC_DEGREES_TO_RADIANS(self.rotation))*dt*60;
	self.position = ccp(self.position.x+vel.x,self.position.y+vel.y);
}

@end
@implementation PageLayer5
-(void)onEnterTransitionDidFinish
{
}
-(id)init
{
	if ((self = [super init])) {
		CCLOG(@"in layer%d",sceneIdx);
        [self loadSpriteSheet];

        CCSprite *sprBg = [CCSprite spriteWithSpriteFrameName:@"p5_bg"];
        [spritesBgNode addChild:sprBg z:-1];
        sprBg.position = ccp(screenSize.width/2,sprBg.contentSize.height/2);
        
        CCSprite *sprCao2 = [CCSprite spriteWithSpriteFrameName:@"p5_g2_1"];
        sprCao2.position = ccp(428,224);//for ipad
        [spritesBgNode addChild:sprCao2 z:0];
        {
            id _ani_cao = [CCAnimation animation];
            [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p5_g2_2"]];
            [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p5_g2_1"]];
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            id as = [CCSequence actions:[CCDelayTime actionWithDuration:3],cao, nil];
            [sprCao2 runAction:[CCRepeatForever actionWithAction:as]];
        }
        
        
        CCSprite *sprCao1 = [CCSprite spriteWithSpriteFrameName:@"p5_g1_1"];
        sprCao1.position = ccp(403,57);//for ipad
        [sprCao2 addChild:sprCao1 ];
        {
            id _ani_cao = [CCAnimation animation];
            [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p5_g1_2"]];
            [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p5_g1_1"]];
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            id as = [CCSequence actions:[CCDelayTime actionWithDuration:5],cao, nil];
            [sprCao1 runAction:[CCRepeatForever actionWithAction:as]];
        }
        
        CCSprite *sprCao3 = [CCSprite spriteWithSpriteFrameName:@"p5_g3_1"];
        sprCao3.position = ccp(296,106);//for ipad
        [sprCao2 addChild:sprCao3 z:-1];
        {
            id _ani_cao = [CCAnimation animation];
            [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p5_g3_2"]];
            [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p5_g3_1"]];
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            id as = [CCSequence actions:[CCDelayTime actionWithDuration:4],cao, nil];
            [sprCao3 runAction:[CCRepeatForever actionWithAction:as]];
        }
        
        
        for (int i = 0; i < 6; i++) {
            
            if (i%2==0) {
                CCSprite *footMark;
                if (i == 5) {
                    footMark = [CCSprite spriteWithSpriteFrameName:@"p5_fp3"];
                }
                else footMark = [CCSprite spriteWithSpriteFrameName:@"p5_fp1"];
                [spritesBgNode addChild:footMark z:1];
                [footMark setOpacity:0];
                [footMark runAction:[CCSequence actions:[CCDelayTime actionWithDuration:i*0.8],[CCFadeIn actionWithDuration:0.8],nil]];
                footMark.position = ccp(i/2*130+350,130);//for ipad
            }
            else 
            {
                CCSprite *footMark1;
                if (i == 5) {
                  footMark1 = [CCSprite spriteWithSpriteFrameName:@"p5_fp4"];
                }
                else footMark1 = [CCSprite spriteWithSpriteFrameName:@"p5_fp2"];
                [spritesBgNode addChild:footMark1 z:1];
                [footMark1 setOpacity:0];
                [footMark1 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:i*0.8],[CCFadeIn actionWithDuration:0.8],nil]];
                footMark1.position = ccp(i/2*130+420,100);//for ipad
            }
        }
        CCSprite *spFoot = [CCSprite spriteWithSpriteFrameName:@"p5_fp1"];
		[spritesBgNode addChild:spFoot z:0];
                
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for( UITouch *touch in touches ) {
        CGPoint rightPosition = [touch locationInView:[touch view]];
        rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
        [self addButterfly:rightPosition];
    }
    
}
-(void)addButterfly:(CGPoint)p
{
    [self loadSpriteSheet];
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d.plist",sceneIdx]];
    int _a = [Common createRandomsizeValueInt:0 toInt:2];
    switch (_a) {
        case 0:
        { 
            ButtleFly *bfNode = [[[ButtleFly alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p6_bf_r_1"] point:p] autorelease];
            id _ani_cao = [CCAnimation animation];
            for (int i = 1; i < 9; i++) {
                [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p6_bf_r_%d",i]]];
            }
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            [bfNode runAction:[CCRepeatForever actionWithAction:cao]];
            [spritesBgNode addChild:bfNode z:3];
        }
            break;
        case 1:
        {
            ButtleFly *bfNode = [[[ButtleFly alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p6_bf_v_1"] point:p] autorelease];
            id _ani_cao = [CCAnimation animation];
            for (int i = 1; i < 9; i++) {
                [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p6_bf_v_%d",i]]];
            }
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            [bfNode runAction:[CCRepeatForever actionWithAction:cao]];
            [spritesBgNode addChild:bfNode z:3];
        }
            break;
        case 2:
        {
            ButtleFly *bfNode = [[[ButtleFly alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p6_bf_y_1"] point:p] autorelease];
            id _ani_cao = [CCAnimation animation];
            for (int i = 1; i < 9; i++) {
                [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p6_bf_y_%d",i]]];
            }
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            [bfNode runAction:[CCRepeatForever actionWithAction:cao]];
            [spritesBgNode addChild:bfNode z:3];
        }
            break;
        default:
            break;
    }
    
    
    
}-(void)removeButterfly
{
    [spritesBgNode removeChildByTag:300 cleanup:YES];
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [touch locationInView:[touch view]];
   
    rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d.plist",sceneIdx]];
    [self loadSpriteSheet];
    for (CCSprite *sp in breBallArr) {
        if ([self isInBox:rightPosition sprite:sp]) {
            int ran = arc4random()%3*2+1;
            CCSprite *sprBall = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p5_breBall_%d",ran]];
            ran = arc4random()%3*2+1;
            CCSprite *sprBall1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p5_breBall_%d",ran]];
            [spritesBgNode addChild:sprBall z:0];
            sprBall.position = ccp(sp.position.x+((double)arc4random()/ARC4RANDOM_MAX)*150-75 ,sp.position.y+((double)arc4random()/ARC4RANDOM_MAX)*50-25);//for ipad
            
            [spritesBgNode addChild:sprBall1 z:0];
            sprBall1.position = ccp(sp.position.x+((double)arc4random()/ARC4RANDOM_MAX)*150-75 ,sp.position.y+((double)arc4random()/ARC4RANDOM_MAX)*50-25);//for ipad
            sprBall.opacity = 0;
            sprBall1.opacity = 0;
            id action = [CCFadeIn actionWithDuration:0.5];
            [sprBall runAction:CCCA(action)];
            [sprBall1 runAction:CCCA(action)];
            [breBallArr addObject:sprBall];
            [breBallArr addObject:sprBall1];
            [breBallArr removeObject:sp];
            [sp runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.1],[CCCallBlock actionWithBlock:^{
                [spritesBgNode removeChild:sp cleanup:YES];
            }],nil]];
            break;
        }
    }
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [touch locationInView:[touch view]];
    rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    CCLOG(@"x = %f, y= %f",rightPosition.x,rightPosition.y);
    //CCMenuItem *t = [self getChildByTag:11]
    //CCMenuItem *en = itemAngelLeft ;
    //en.position = rightPosition;
    //bibobox.position = ccp(rightPosition.x-300,rightPosition.y-200);
    
}
-(void)dealloc
{
	[super dealloc];
	//[breBallArr release];
}
@end
@implementation PageLayer6
-(id)init
{
	if ((self = [super init])) {
		[self initBox2d];
        [self loadSpriteSheet];
        self.isAccelerometerEnabled = YES;
        CCSprite *sp = [CCSprite spriteWithSpriteFrameName:@"p6_bg"];
        [spritesBgNode addChild:sp z:0];
        sp.position = ccp(screenSize.width/2,screenSize.height/2);
        
//        CCSprite *rb = [CCSprite spriteWithSpriteFrameName:@"p6_rb"];
//        [spritesBgNode addChild:rb z:0];
//        rb.position = ccp(500,375);
        
        NSString *tmpName = @"p6_rb_b";
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p6_body.plist"];
        
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody];
        sprBody.position = ccp(507,247);//for ipad
        
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        bodyDef.fixedRotation = YES;
        b2Body *body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
//        b2WeldJointDef wjd;
//        wjd.dampingRatio = 0.1;
//        wjd.frequencyHz = 2;
//        wjd.Initialize(body, groundBody, body->GetPosition());
//        world->CreateJoint(&wjd);
        b2DistanceJointDef djd;
        djd.Initialize(body, groundBody, body->GetPosition(),body->GetPosition());
        djd.dampingRatio = 0.5;
        djd.frequencyHz = 15;
        djd.length = 0;
        djd.collideConnected = false;
        world->CreateJoint(&djd);
        
        
        
        
        
        tmpName = @"p6_rb_h";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:4 tag:kTagBody+2];
        sprBody.position = ccp(549,315);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *headBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:headBody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(headBody, body, headBody->GetPosition());
        rjd.motorSpeed = -10;//1.0f * b2_pi;
        rjd.maxMotorTorque = 2;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/40.0f * b2_pi;
        rjd.upperAngle = 1/40.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p6_rb_e1";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:3 tag:kTagBody+3];
        sprBody.position = ccp(534,452);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *e1body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:e1body forShapeName:tmpName];
        
        rjd.Initialize(e1body, headBody, e1body->GetPosition());
        rjd.motorSpeed = 0;//1.0f * b2_pi;
        rjd.maxMotorTorque = 0;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/20.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd); 
        
        tmpName = @"p6_rb_e2";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:3 tag:kTagBody+4];
        sprBody.position = ccp(582,442);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *e2body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:e2body forShapeName:tmpName];
        
        rjd.Initialize(e2body, headBody, e2body->GetPosition());
        rjd.motorSpeed = 0;//1.0f * b2_pi;
        rjd.maxMotorTorque = 0;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/20.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd); 
        
        
        
        tmpName = @"p6_rb_am";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagBody+5];
        sprBody.position = ccp(550,300);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *arml = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:arml forShapeName:tmpName];
        
        rjd.Initialize(arml, body, arml->GetPosition());
        rjd.motorSpeed = 0;//1.0f * b2_pi;
        rjd.maxMotorTorque = 0;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/20.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);   

        tmpName = @"p6_rb_am1";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+6];
        sprBody.position = ccp(508,322);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *armr = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:armr forShapeName:tmpName];
        armr->GetFixtureList()->SetSensor(YES);
        rjd.Initialize(armr, body, armr->GetPosition());
        rjd.motorSpeed = 10;//1.0f * b2_pi;
        rjd.maxMotorTorque = 0;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/40.0f * b2_pi;
        rjd.upperAngle = 1/40.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);    
	}
	return self;
}

-(void)addButterfly:(CGPoint)p
{
    [self loadSpriteSheet];
    //    CCSprite *bFly = [CCSprite spriteWithSpriteFrameName:@"g_bf_r_1"];
    //    [spritesBgNode addChild:bFly z:2 tag:300];
    int _a = [Common createRandomsizeValueInt:0 toInt:2];
    switch (_a) {
        case 0:
        { 
            ButtleFly *bfNode = [[[ButtleFly alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p6_bf_r_1"] point:p] autorelease];
            id _ani_cao = [CCAnimation animation];
            for (int i = 1; i < 9; i++) {
                [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p6_bf_r_%d",i]]];
            }
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            [bfNode runAction:[CCRepeatForever actionWithAction:cao]];
            [spritesBgNode addChild:bfNode z:10];
        }
            break;
        case 1:
        {
            ButtleFly *bfNode = [[[ButtleFly alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p6_bf_v_1"] point:p] autorelease];
            id _ani_cao = [CCAnimation animation];
            for (int i = 1; i < 9; i++) {
                [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p6_bf_v_%d",i]]];
            }
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            [bfNode runAction:[CCRepeatForever actionWithAction:cao]];
            [spritesBgNode addChild:bfNode z:10];
        }
            break;
        case 2:
        {
            ButtleFly *bfNode = [[[ButtleFly alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p6_bf_y_1"] point:p] autorelease];
            id _ani_cao = [CCAnimation animation];
            for (int i = 1; i < 9; i++) {
                [_ani_cao addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p6_bf_y_%d",i]]];
            }
            id cao =[CCAnimate  actionWithDuration:0.5 animation:_ani_cao restoreOriginalFrame:NO];
            [bfNode runAction:[CCRepeatForever actionWithAction:cao]];
            [spritesBgNode addChild:bfNode z:10];
        }
            break;
        default:
            break;
    }
    
  
    
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
    else {
        
       [self addButterfly:rightPosition];
    }
	
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
	
}
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation=[touch locationInView:[touch view]];
	touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    
	if (m_mouseJoint) {
		
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}

@end
@implementation PageLayer7
-(id)init
{
	if ((self = [super init])) {
		[self initBox2d];
        [self loadSpriteSheet];
        
        NSString *tmpName = @"p7_tt1";
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p7_body.plist"];
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:3 tag:kTagBody];
        sprBody.position = ccp(510,2);//for ipad
        
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        bodyDef.fixedRotation = YES;
        b2Body *body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        
        b2DistanceJointDef djd;
        djd.Initialize(body, groundBody, body->GetPosition(), body->GetPosition());
        djd.dampingRatio = 0.5;
        djd.frequencyHz = 15.0;
        djd.length = 0;
        djd.collideConnected = false;
        world->CreateJoint(&djd);
        
     
        
        tmpName = @"p7_tt2";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+1];
        sprBody.position = ccp(499,58);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *coatBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:coatBody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(coatBody, body, coatBody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p7_tt3";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+2];
        sprBody.position = ccp(367,183);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        bodyDef.fixedRotation = YES;
        b2Body *body3 = world->CreateBody(&bodyDef);       
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body3 forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
             
        rjd.Initialize(body3, body, body3->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        
        tmpName = @"p7_tt4";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody+3];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(580,115);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *leftHandBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:leftHandBody forShapeName:tmpName];
        
        rjd.Initialize(leftHandBody, coatBody, leftHandBody->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p7_tt5";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody+4];
        sprBody.position = ccp(397,131);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *mamahead = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:mamahead forShapeName:tmpName];
        
        rjd.Initialize(mamahead, body, mamahead->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        [self schedule:@selector(takeWind) interval:0];
        
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSArray *touchArray = [touches allObjects];
    CCLOG (  @"touchArray count = %d",[touches count]); 
    for ( UITouch *touch in touchArray ) {
        //UITouch *touch = [touches anyObject];
        CGPoint rightPosition = [touch locationInView:[touch view]];
        rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
        [self addHoll:rightPosition];
        CCLOG(@"123");
    }
    
        
}
-(void)takeWind
{
    float _a = [Common createRandomsizeValueFloat:1 toFloat:3.5];
    [self schedule:_cmd interval:_a];
    for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{       
		if (b->GetUserData() != NULL) {
			b->ApplyLinearImpulse(b2Vec2([Common createRandomsizeValueFloat:-200 toFloat:200],[Common createRandomsizeValueFloat:-200 toFloat:200]), b->GetPosition());
            
		}	
	}
}

-(void)addHoll:(CGPoint)p
{
    [self loadSpriteSheet];
    int a = [Common createRandomsizeValueInt:1 toInt:2];
    CCSprite *holl = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p7_h%d_1",a]];
    [spritesBgNode addChild:holl z:0 ];
    
    NSMutableArray *aniFrame = [NSMutableArray array];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p7_h%d_2",a]]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p7_h%d_3",a]]];
    id animation = [CCAnimation animationWithFrames:aniFrame delay:0.15];
    id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
    //id af = [CCRepeatForever actionWithAction:ani];
    [holl runAction:ani];
    
    NSMutableArray *aniFrame1 = [NSMutableArray array];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p7_h%d_2",a]]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"p7_h%d_1",a]]];
    id animation1 = [CCAnimation animationWithFrames:aniFrame1 delay:0.15];
    id ani1 = [CCAnimate actionWithAnimation:animation1 restoreOriginalFrame:NO];
    //id af = [CCRepeatForever actionWithAction:ani];
    

    holl.position = p;
    [holl setOpacity:0];
    [holl runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.3],[CCDelayTime actionWithDuration:3],[CCFadeOut actionWithDuration:0.8],
                     nil]];
    [holl runAction:[CCSequence actions:[CCDelayTime actionWithDuration:3.3],[CCCallBlock actionWithBlock:BCA(^(void){
        [holl runAction:ani1];
    })],nil]];
    
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"7_waterFade.plist"];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
    emitter_.position = p;
    emitter_.autoRemoveOnFinish = YES;
    //emitter_.blendAdditive = YES;  
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:-1];
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}
@end
@implementation PageLayer8
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    canTouchSeed = YES;
    isSeed = NO;
}

-(id)init
{
	if ((self = [super init])) {
        canTouch = YES;
        [self loadSpriteSheet];
        [self initBox2d];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p8_bg"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg z:0];
        
        CCSprite *bag = [CCSprite spriteWithSpriteFrameName:@"p8_bag"];
        bag.position = ccp(screenSize.width/2,bag.contentSize.height/2);
        [spritesBgNode addChild:bag z:0];
        
        CCSprite *my_seed = [CCSprite spriteWithSpriteFrameName:@"p8_seeds"];
        my_seed.position = ccp(287,418);//for ipad
        [my_seed setOpacity:0];
        [spritesBgNode addChild:my_seed z:0 tag:100];
        
        CCSprite *tree = [CCSprite spriteWithSpriteFrameName:@"p8_tff"];
        tree.position = ccp(screenSize.width-tree.contentSize.width/2+30,
                            screenSize.height-tree.contentSize.height/2+30);
        [spritesBgNode addChild:tree z:2 tag:101];
        
        
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(tree.position.x/PTM_RATIO,tree.position.y/PTM_RATIO );
        bodyDef.userData = tree;
        bodyDef.fixedRotation = YES;
        treeBody = world->CreateBody(&bodyDef);
        
        b2PolygonShape bodyBox;
        int num = 5;
        b2Vec2 verts[] = {
            b2Vec2(302.5f / PTM_RATIO, 203.5f / PTM_RATIO),
            b2Vec2(-306.2f / PTM_RATIO, 202.9f / PTM_RATIO),
            b2Vec2(-153.4f / PTM_RATIO, -66.5f / PTM_RATIO),
            b2Vec2(305.5f / PTM_RATIO, -199.4f / PTM_RATIO),
            b2Vec2(303.3f / PTM_RATIO, 203.6f / PTM_RATIO)
        };


        bodyBox.Set(verts, num);  
        
        
        b2FixtureDef fixtureDef;
		fixtureDef.shape = &bodyBox;
		fixtureDef.density = 0.10;
		fixtureDef.friction = 0;
		fixtureDef.restitution = 0;
        fixtureDef.isSensor = YES;
        //fixtureDef.filter.groupIndex = -1;
		treeBody->CreateFixture(&fixtureDef);
        
        b2DistanceJointDef djd;
        djd.Initialize(treeBody, groundBody, treeBody->GetPosition(), treeBody->GetPosition());
        djd.dampingRatio = 1.5;
        djd.frequencyHz = 18;
        djd.length = 0;
        djd.collideConnected = false;
        world->CreateJoint(&djd);

		groundBody->DestroyFixture(groundBottom);
        
	}
	return self;
}
-(void)tick:(ccTime)dt
{
    [super tick:dt];
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
            if (myActor.position.y<-20) {
                [myActor.parent removeChild:myActor cleanup:YES];
                world->DestroyBody(b);
            }
		}	
	}
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	
	m_mouseWorld = p;
	
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
    if (canTouch) {
        [self schedule:@selector(fallBall)];
        float _a = [Common createRandomsizeValueFloat:-200 toFloat:200];
        float _b = [Common createRandomsizeValueFloat:-100 toFloat:100];
        treeBody->ApplyLinearImpulse(b2Vec2(_a,_b), treeBody->GetPosition());
    }
   

	if (callback.m_fixture)
	{
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);

        
	}
    
    [self loadSpriteSheet];
    
    
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    
    
    CCSprite *sprSeed = (CCSprite*)[spritesBgNode getChildByTag:100];
    
    if( [self isInBox:rightPosition sprite:sprSeed] && canTouchSeed)
    {
        canTouchSeed = NO;
        if (isSeed) {
            
            id a1 = [CCFadeOut actionWithDuration:1];
            id a2 = [CCCallBlock actionWithBlock:BCA(^(void){
                canTouchSeed = YES;
            })];
            id a3 = [CCSequence actions:a1,a2,nil];
            isSeed = NO;
            [sprSeed runAction:a3];
            //id a2 = [CCFadeOut actionWithDuration:2];
        }
        else
        {
            id a1 = [CCFadeIn actionWithDuration:1];
            id a2 = [CCCallBlock actionWithBlock:BCA(^(void){
                canTouchSeed = YES;
            })];
            id a3 = [CCSequence actions:a1,a2,nil];
            isSeed = YES;
            [sprSeed runAction:a3];
        }
        
    }
    
}
-(void)fallBall
{
   
        
        [self loadSpriteSheet];
        if (lCount >= 8) {
            lCount = 0;
            [self unschedule:_cmd];
            canTouch = YES;
            return;
        }
        else{
            canTouch = NO;
            [self schedule:_cmd interval:[Common createRandomsizeValueFloat:0.1 toFloat:0.3]];
            [self loadSpriteSheet];
            lCount ++;
            srandom(time(NULL));
            //read stars init
            CCSprite *phyBall;
            int ran = arc4random()%11+1;
            double valX = [Common createRandomsizeValueFloat:623+25 toFloat:1000];
            double valY = [Common createRandomsizeValueFloat:600 toFloat:800];
            [self loadSpriteSheet];
            phyBall = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p8_f%d",ran]];
            phyBall.position = ccp(valX,valY);
            phyBall.opacity = 0;
            id action = [CCFadeIn actionWithDuration:.5f];
            [phyBall runAction:action];
            [spritesBgNode addChild:phyBall z:1];
            b2BodyDef bodyDef;
            bodyDef.type = b2_dynamicBody;
            bodyDef.position.Set(phyBall.position.x/PTM_RATIO, phyBall.position.y/PTM_RATIO);
            
            bodyDef.userData = phyBall;
            b2Body *boxBody;
            boxBody = world->CreateBody(&bodyDef);
            //boxBody->app(1000);
            b2CircleShape circleShape;
            circleShape.m_radius = 	phyBall.contentSize.width/2/PTM_RATIO;
            b2FixtureDef fixtureDef;
            fixtureDef.shape = &circleShape;
            fixtureDef.density = 1.0;
            fixtureDef.friction = 0.1;
            fixtureDef.restitution =  0.15;
            fixtureDef.filter.groupIndex = -1;
            boxBody->CreateFixture(&fixtureDef);
            
        }
    
}
@end
@implementation PageLayer9
#define kTagStick 100
#define kTagBag 101
#define kTagT 102
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d];
        isScaleDone = YES;
        NSString *tmpName = @"p9_st";
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p9_body.plist"];
        
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:0 tag:kTagStick];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(646,8.3);//for ipad
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *stickbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:stickbody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(stickbody, groundBody, stickbody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = 0;//-1/60.0f * b2_pi;
        rjd.upperAngle = 1/60.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p9_bag";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagBag];
        sprBody.position = ccp(437.5,227.2);//for ipad
       
        
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *bagbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bagbody forShapeName:tmpName];
        
        rjd.Initialize(bagbody, stickbody, bagbody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p9_t";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagT];
        sprBody.position = ccp(437.7,224.8);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *tbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:tbody forShapeName:tmpName];
        rjd.Initialize(tbody, bagbody, tbody->GetPosition());
        rjd.motorSpeed = 5.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/60.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);

        
        
	}
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
    else {

        [self addFlower:rightPosition];
    }
	
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
	
}
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation=[touch locationInView:[touch view]];
	touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    
	if (m_mouseJoint) {
		
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}


-(void)addFlower:(CGPoint)p
{
    [self loadSpriteSheet];
    
    int a = [Common createRandomsizeValueInt:1 toInt:3];
    NSString *tmpName = [NSString stringWithFormat:@"p9_fl%d",a];
    CCSprite *fl = [CCSprite spriteWithSpriteFrameName:tmpName];
    [spritesBgNode addChild:fl z:2 ];
    fl.position = p;
    [fl setOpacity:0];
    
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"9_waterFade.plist"];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
    emitter_.position = p;
    emitter_.autoRemoveOnFinish = YES;
    //emitter_.blendAdditive = YES;  
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:-2];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(fl.position.x/PTM_RATIO,fl.position.y/PTM_RATIO );
    bodyDef.userData = fl;
    b2Body *flowerBody = world->CreateBody(&bodyDef);
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:flowerBody forShapeName:tmpName];
    [fl runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.3],[CCDelayTime actionWithDuration:3],[CCFadeOut actionWithDuration:0.8],
                   [CCCallBlock actionWithBlock:BCA(^(void){
        [spritesBgNode removeChild:fl cleanup:YES];
        world->DestroyBody(flowerBody);
    })],nil]];
    
    if (isScaleDone) {
        isScaleDone = NO;
        CCSprite *bag =(CCSprite*) [spritesBgNode getChildByTag:kTagBag];
        id a1 = [CCEaseInOut actionWithAction:[CCScaleBy actionWithDuration:0.1 scale:1.2] rate:2];
        id a2 = [a1 reverse];
        id as = [CCSequence actions:a1,a2,[CCCallBlock actionWithBlock:BCA(^(void){bag.scale = 1;
            isScaleDone = YES;
        })], nil];
        [bag  runAction:as];
    }
   
    
    
    
}

/*-(void)tick:(ccTime)dt
 {
 [super tick:dt];
 for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
 {
 if (b->GetUserData() != NULL) {
 //Synchronize the AtlasSprites position and rotation with the corresponding body
 CCSprite *myActor = (CCSprite*)b->GetUserData();
 if (myActor.position.y<myActor.contentSize.width/2+10) {
 
 }
 }	
 }
 std::vector<b2Body *>toDestroy; 
 std::vector<MyContact>::iterator pos;
 for(pos = _contactListener->_contacts.begin(); 
 pos != _contactListener->_contacts.end(); ++pos) {
 MyContact contact = *pos;
 
 b2Body *bodyA = contact.fixtureA->GetBody();
 b2Body *bodyB = contact.fixtureB->GetBody();
 if(contact.fixtureA == groundBottom ) {
 CCLOG(@"BODYA");
 if (m_mouseJoint) {
 world->DestroyJoint(m_mouseJoint);
 m_mouseJoint = NULL;
 }
 CCSprite *myActor;
 myActor = (CCSprite*)bodyB->GetUserData();
 [spritesBgNode removeChild:myActor cleanup:YES];
 world->DestroyBody(bodyB);
 m_glassCount --;
 break;
 }
 
 else if(contact.fixtureB == groundBottom ) {
 CCLOG(@"BODYB");
 if (m_mouseJoint) {
 world->DestroyJoint(m_mouseJoint);
 m_mouseJoint = NULL;
 }
 CCSprite *myActor;
 myActor = (CCSprite*)bodyA->GetUserData();
 [spritesBgNode removeChild:myActor cleanup:YES];
 world->DestroyBody(bodyA);
 m_glassCount --;
 break;
 }
 }
 }*/
@end
@implementation PageLayer10
#define kTag10ms 101
-(id)init
{
	if ((self = [super init])) {
		[self loadSpriteSheet];
        canMs = YES;
        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p10_bg"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg z:0];
        
        CCSprite *flower = [CCSprite spriteWithSpriteFrameName:@"p10_flower"];
        flower.position = ccp(459.4,275.2);//for ipad
        [spritesBgNode addChild:flower z:0 tag:100];
        
        
        CCSprite *ms = [CCSprite spriteWithSpriteFrameName:@"p10_m_1"];
        ms.position = ccp(753.7,202.4);//for ipad
        [spritesBgNode addChild:ms z: 0 tag:kTag10ms];
       
        id a0 = [CCRotateBy actionWithDuration:0.1 angle:-2];
        id a1 = [CCRotateBy actionWithDuration:0.2 angle:4];
        id a2 = [CCRotateBy actionWithDuration:0.1 angle:-2];
        id a3 = [CCSequence actions:a0,a1,a2, nil];
        id a4 = [CCRepeatForever actionWithAction:a3];
        [ms runAction:a4];
        [a4 setTag:50];
        
        CCSprite *rb = [CCSprite spriteWithSpriteFrameName:@"p10_rb1"];
        rb.position = ccp(761.3,414.2);//for ipad
        [spritesBgNode addChild:rb z:0];
        
        id animation = [CCAnimation animation];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_rb2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_rb3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_rb4"]
                      delay:0.25];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_rb3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_rb2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_rb1"]
                      delay:0.25];
        
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:ani];
        //[a setTag:101];
        [rb runAction:a];

	}
	return self;
}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //[super ccTouchesBegan:touches withEvent:event];
	CCSprite *flower = (CCSprite*)[spritesBgNode getChildByTag:100];
	//CCSprite *watter = (CCSprite*)[rabbit getChildByTag:100];
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	if ([self isInBox:rightPosition sprite:flower]) {
		emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"p10_parti.plist"];
		//emitter_.duration = 0.1;
        NSString *tmp = [NSString stringWithFormat:@"p10_heart%d.png",[Common createRandomsizeValueInt:1 toInt:5]];
        CCSprite *tex = [CCSprite spriteWithFile:tmp];
        emitter_.texture = [tex texture];
		batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
		emitter_.position = ccp(flower.position.x,flower.position.y+flower.contentSize.height/2-50-40);//for ipad
		emitter_.blendAdditive = NO;  
		[batchNode_ addChild:emitter_];
		[self addChild:batchNode_];
        [flower stopAllActions];
        [self loadSpriteSheet];
        //[flower setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_flower"]];
        id animation = [CCAnimation animation];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_flower_2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_flower_3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_flower"]
                      delay:0.1];
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        [flower runAction:ani];
	}
    
    
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
	UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [touch locationInView:[touch view]];
    rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    
    CCSprite *ms = (CCSprite*)[spritesBgNode getChildByTag:kTag10ms];
    
    if (CGRectContainsPoint(ms.boundingBox, rightPosition) && canMs) {
        
        canMs = NO;
        id animation = [CCAnimation animation];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_m_2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_m_3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_m_4"]
                      delay:1.2];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_m_3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_m_2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p10_m_1"]
                      delay:0.1];
        
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [[ms getActionByTag:50] retain];
        [ms stopAction:a];
        CCLOG(@"%d", [a retainCount]);
        [ms runAction:[CCSequence actions:ani,[CCCallBlock actionWithBlock:^(void){
            canMs = YES;
            [ms runAction:a];
            CCLOG(@"%d", [a retainCount]);
        }], nil]];
        [a release];
        CCLOG(@"%d", [a retainCount]);
        
	}
    
    
}
@end
@implementation PageLayer11
#define kTagSoundBall 100
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d];
        
        NSString *tmpName = @"p11_st";
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p11_body.plist"];
        
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:0 tag:kTagStick];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(723,0);//for ipad
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *stickbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:stickbody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(stickbody, groundBody, stickbody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = 0;//-1/80.0f * b2_pi;
        rjd.upperAngle = 1/80.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p11_bag";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagBag];
        sprBody.position = ccp(530.3,201.6);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *bagbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bagbody forShapeName:tmpName];
        rjd.Initialize(bagbody, stickbody, bagbody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p11_t";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagT];
        sprBody.position = ccp(530.3,201.6);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *tbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:tbody forShapeName:tmpName];
        rjd.Initialize(tbody, bagbody, tbody->GetPosition());
        rjd.motorSpeed = 5.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/15.0f * b2_pi;
        rjd.upperAngle = 1/60.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
    else {
        [self addHoll:rightPosition];
    }
	
}
-(void)addHoll:(CGPoint)p
{
    [self loadSpriteSheet];
    int a = [Common createRandomsizeValueInt:1 toInt:3];
    CCSprite *holl = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p11_leaf_%d",a]];
    [spritesBgNode addChild:holl z:2 ];
    holl.position = p;
    [holl setOpacity:0];
    holl.scale = [Common createRandomsizeValueFloat:0.2 toFloat:1];
    float ranTime = [Common createRandomsizeValueFloat:3 toFloat:5];
    float ranY = -80*ranTime;
    CGPoint ranP = ccp([Common createRandomsizeValueFloat:-300 toFloat:300],ranY); 
    
    id a1 = [CCMoveBy actionWithDuration:ranTime position:ranP];
   // id a2 = [CCEaseIn actionWithAction:a1 rate:2];
    id a3 = [CCMoveBy actionWithDuration:ranTime position:ccp(-ranP.x,ranP.y)];
   // id a4 = [CCEaseIn actionWithAction:a3 rate:2];
    id as = [CCSequence actions:a1,a3, nil];
   // id ay = [CCMoveBy actionWithDuration:ranTime position:ccp(0,ranY)];
    //id asp = [CCSpawn actions:as,ay, nil];
    [holl runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.3],[CCDelayTime actionWithDuration:ranTime*2],nil]];
    [holl runAction:as];
    [holl runAction:[CCRotateBy actionWithDuration:[Common createRandomsizeValueFloat:3 toFloat:5] angle:[Common createRandomsizeValueFloat:-200 toFloat:200]]];
    [holl runAction:[CCFadeOut actionWithDuration:ranTime-2]];
    //[holl runAction:ay];
    
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"11_waterFade.plist"];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:YES]; 
    emitter_.position = p;
    emitter_.autoRemoveOnFinish = YES;
    //emitter_.blendAdditive = YES;  
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:-1];
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
	
}
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation=[touch locationInView:[touch view]];
	touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    
	if (m_mouseJoint) {
		
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}
@end
@implementation PageLayer12
#define kTagBag12 200   
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p12_body.plist"];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p12_bg"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg z:-1];
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(bg.position.x/PTM_RATIO,bg.position.y/PTM_RATIO );
        bodyDef.userData = bg;
        //bodyDef.fixedRotation = YES;
        b2Body *bgbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bgbody forShapeName:@"p12_bg"];
        [bg setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p12_bg"]];
        
        CCSprite *zhalan = [CCSprite spriteWithSpriteFrameName:@"p12_br"];
        zhalan.position = ccp(496,178);//for ipad
        [spritesBgNode addChild:zhalan z:3];
        
        CCSprite *frontBg = [CCSprite spriteWithSpriteFrameName:@"p12_fls"];
        frontBg.position = ccp(screenSize.width/2,frontBg.contentSize.height/2);
        [spritesBgNode addChild:frontBg z:3]; 
        
        CCSprite *bag = [CCSprite spriteWithSpriteFrameName:@"p12_bag"];
        bag.position = ccp(523,506);//for ipad
        [spritesBgNode addChild:bag z:-2 tag:kTagBag12];
        
        
        NSString *tmpName = @"p12_rb";
        
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:2 tag:kTagBody];
        sprBody.position = ccp(422,380);//for ipad
        
        
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        bodyDef.fixedRotation = YES;
        b2Body *body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        
        b2DistanceJointDef djd;
        djd.Initialize(body, groundBody, body->GetPosition(), body->GetPosition());
        djd.dampingRatio = 0.5;
        djd.frequencyHz = 10.0;
        djd.length = 0;
        djd.collideConnected = false;
        world->CreateJoint(&djd);
        
        
        
        tmpName = @"p12_rb_a";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody+1];
        sprBody.position = ccp(432,388);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *coatBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:coatBody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(coatBody, body, coatBody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/20.0f *b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p12_rb_el";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody+2];
        sprBody.position = ccp(346,536);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        //bodyDef.fixedRotation = YES;
        b2Body *body3 = world->CreateBody(&bodyDef);       
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body3 forShapeName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        
        rjd.Initialize(body3, body, body3->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/20.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        
        tmpName = @"p12_rb_er";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody+3];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(422,546);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *leftHandBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:leftHandBody forShapeName:tmpName];
        
        rjd.Initialize(leftHandBody, body, leftHandBody->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p12_rb_l";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:1 tag:kTagBody+4];
        sprBody.position = ccp(356,292);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *mamahead = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:mamahead forShapeName:tmpName];
        
        rjd.Initialize(mamahead, body, mamahead->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = YES;
        rjd.lowerAngle = -1/20.0f * b2_pi;
        rjd.upperAngle = 1/10.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"12_waterFade.plist"];
        batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
        //emitter_.position = p;
        emitter_.autoRemoveOnFinish = YES;
        //emitter_.blendAdditive = YES;  
        [batchNode_ addChild:emitter_];
        [self addChild:batchNode_ z:-1];
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!useBox2d) {
        return;
    }
	if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
        CCSprite *bag = (CCSprite*)[spritesBgNode getChildByTag:kTagBag12];
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
        
        CCSprite *phyBall;
        [self loadSpriteSheet];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p12_body.plist"];
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        
        phyBall = [CCSprite spriteWithSpriteFrameName:@"p12_seed"];
        phyBall.position = ccp(bag.position.x+20,bag.position.y-10);
        phyBall.opacity = 0;
        
        
        [spritesBgNode addChild:phyBall z:1];	
        bodyDef.position.Set(phyBall.position.x/PTM_RATIO, phyBall.position.y/PTM_RATIO);
        bodyDef.userData = phyBall;	
        b2Body *bodyGlass = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bodyGlass forShapeName:@"p12_seed"];
        [phyBall setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p12_seed"]];
        
        id a1 = [CCFadeIn actionWithDuration:.5f];
        id a2 = [CCCallBlock actionWithBlock:BCA(^(void){
            if (m_mouseJoint) {
                world->DestroyJoint(m_mouseJoint);
                m_mouseJoint = NULL;
            }
            world->DestroyBody(bodyGlass);
            [spritesBgNode removeChild:phyBall cleanup:YES];
        })];
        id a3 = [CCFadeOut actionWithDuration:.5f];
        id as = [CCSequence actions:a1,[CCDelayTime actionWithDuration:2],a3,a2,nil];
        [phyBall runAction:as];

	}
	
}
@end
@implementation PageLayer13
#define kTagSoundBall 100
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d];
        isScaleDone = YES;
        NSString *tmpName = @"p13_st";
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p13_body.plist"];
        
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:0 tag:kTagStick];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(712,-8);//for ipad
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *stickbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:stickbody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(stickbody, groundBody, stickbody->GetPosition());
        rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        //rjd.enableMotor = YES;
        rjd.lowerAngle = 0;//-1/80.0f * b2_pi;
        rjd.upperAngle = 1/80.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p13_bag";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagBag];
        sprBody.position = ccp(515,187);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *bagbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bagbody forShapeName:tmpName];
        rjd.Initialize(bagbody, stickbody, bagbody->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        //rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/30.0f * b2_pi;
        rjd.upperAngle = 1/30.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        tmpName = @"p13_t";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:0 tag:kTagT];
        sprBody.position = ccp(515,187);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *tbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:tbody forShapeName:tmpName];
        rjd.Initialize(tbody, bagbody, tbody->GetPosition());
        rjd.motorSpeed = 5.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        //rjd.enableMotor = YES;
        rjd.lowerAngle = -1/15.0f * b2_pi;
        rjd.upperAngle = 1/60.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (m_mouseJoint) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
    else {
        [self addPunk:rightPosition];
    }
	
}
-(void)addPunk:(CGPoint)p
{
    [self loadSpriteSheet];
    
    int a = [Common createRandomsizeValueInt:1 toInt:3];
    NSString *tmpName = [NSString stringWithFormat:@"p13_pk%d",a];
    CCSprite *fl = [CCSprite spriteWithSpriteFrameName:tmpName];
    [spritesBgNode addChild:fl z:2 ];
    fl.position = p;
    [fl setOpacity:0];
    
    fl.scale = [Common createRandomsizeValueFloat:0.8 toFloat:1.0];
    if (a == 2) {
        fl.scale = [Common createRandomsizeValueFloat:0.2 toFloat:0.4];
    }
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(fl.position.x/PTM_RATIO,fl.position.y/PTM_RATIO );
    bodyDef.userData = fl;
    b2Body *flowerBody = world->CreateBody(&bodyDef);
    
    b2CircleShape ps;
    ps.m_radius = fl.contentSize.height/2*fl.scale/PTM_RATIO;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &ps;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.1;
    fixtureDef.restitution =  0.15;
    flowerBody->CreateFixture(&fixtureDef);
    
    [fl runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.3],[CCDelayTime actionWithDuration:2],[CCFadeOut actionWithDuration:0.8],
                   [CCCallBlock actionWithBlock:BCA(^(void){
       
        if (m_mouseJoint) {
            world->DestroyJoint(m_mouseJoint);
            m_mouseJoint = NULL;
           
        }
        [spritesBgNode removeChild:fl cleanup:YES];
        world->DestroyBody(flowerBody);
        
    })],nil]];
    if (isScaleDone) {
        isScaleDone = NO;
        CCSprite *bag =(CCSprite*) [spritesBgNode getChildByTag:kTagBag];
        id a1 = [CCEaseInOut actionWithAction:[CCScaleBy actionWithDuration:0.1 scale:1.2] rate:2];
        id a2 = [a1 reverse];
        id as = [CCSequence actions:a1,a2,[CCCallBlock actionWithBlock:BCA(^(void){bag.scale = 1;isScaleDone = YES;})], nil];
        [bag  runAction:as];
    }
   
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
	
}
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation=[touch locationInView:[touch view]];
	touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    
	if (m_mouseJoint) {
		
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}
@end
@implementation PageLayer14
#define kTagLb 100
-(void)onEnter
{
    [super onEnter];
     [self loadSpriteSheet];
}
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self loadSpriteSheet];
    CCSprite *lb = (CCSprite*)[spritesBgNode getChildByTag:kTagLb];
    
    NSMutableArray *aniFrame = [NSMutableArray array];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_2"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_1"]];
    //[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_w1"]];
    id animation = [CCAnimation animationWithFrames:aniFrame delay:0.1];
    id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
    id a = [CCRepeatForever actionWithAction:ani];
    [a setTag:101];
    [lb runAction:a];
    
    CGPoint startP = ccp(1065,263);
    CGPoint contP = ccp(628,774);
    CGPoint endP = ccp(437,509);
    float time = [Common createRandomsizeValueFloat:2 toFloat:5];
    ccBezierConfig bezier; // 创建贝塞尔曲线
    bezier.controlPoint_1 = startP; // 起始点
    bezier.controlPoint_2 = contP; //控制点
    bezier.endPosition = endP; // 结束位置  
    CCBezierTo *actionMove1 = [CCBezierTo actionWithDuration:time bezier:bezier];
    
    
    NSMutableArray *aniFrame1 = [NSMutableArray array];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_3"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_4"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_5"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_6"]];
    id animation1 = [CCAnimation animationWithFrames:aniFrame1 delay:0.15];
    id ani1 = [CCAnimate actionWithAnimation:animation1 restoreOriginalFrame:NO];
    
    id as = [CCSequence actions:actionMove1,[CCCallBlock actionWithBlock:BCA(^(void){
        [lb stopActionByTag:101];
        canTouch = YES;
    })],ani1,nil];
    [lb runAction:as];
    
    CCSprite *pk = (CCSprite*)[spritesBgNode getChildByTag:101];
    
     //pk.visible = YES;
    id a1 = [CCEaseElasticInOut actionWithAction:[CCScaleTo actionWithDuration:1 scale:1] period:0.5];
    
    id a3 = [CCRotateBy actionWithDuration:0.2 angle:3];
    id a4 = [a3 reverse];
  
    
    id a2 = [CCSequence actions:[CCDelayTime actionWithDuration:0.5],a3,a4, nil];
    [pk runAction:a2];
//    id animations = [CCAnimation animation];
//    
//    [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_pk_2"]
//                   delay:0.2];
//    [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_pk_3"]
//                   delay:0.2];  
//    id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
//    [pk runAction:anis];
    [pk runAction:a1];
    [pk runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCJumpBy actionWithDuration:0.1 position:ccp(0,0) height:5  jumps:1],nil]];
}
-(id)init
{
	if ((self = [super init])) {
		[self loadSpriteSheet];
        //canTouch = YES;
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p14_bg"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg];
        
        CCSprite *punk = [CCSprite spriteWithSpriteFrameName:@"p14_pk_3"];
        punk.position = ccp(345,351-punk.contentSize.height/2);//for ipad
        punk.anchorPoint = ccp(0.5,0);
        [spritesBgNode addChild:punk z:0 tag:101];
        //punk.visible = NO;
        punk.scale = 0.1;
        
        CCSprite *lb = [CCSprite spriteWithSpriteFrameName:@"p14_lb_1"];
        lb.position = ccp(133,57);//for ipad
        [spritesBgNode addChild:lb z:1 tag:kTagLb];
        
        CCSprite *flower = [CCSprite spriteWithSpriteFrameName:@"p14_fl_2"];
        flower.position = ccp(flower.contentSize.width/2,flower.contentSize.height/2);//for ipad
        [spritesBgNode addChild:flower z:1];
        

        {
        CCSprite *rb = [CCSprite spriteWithSpriteFrameName:@"p14_rb1"];
        rb.position = ccp(626.4,528.4);//for ipad
        [spritesBgNode addChild:rb z:0];
        
        id animation = [CCAnimation animation];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_rb2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_rb3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_rb4"]
                      delay:0.25];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_rb3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_rb2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_rb1"]
                      delay:0.25];
        
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:ani];
        //[a setTag:101];
           
            [rb runAction:a];
        }
	}
	return self;
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self loadSpriteSheet];
    CCSprite *pk = (CCSprite*)[spritesBgNode getChildByTag:101];
    [pk stopAllActions];
    id animations = [CCAnimation animation];
    [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_pk_3a"]
                   delay:0.1];
    [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_pk_3"]
                   delay:0.1];
    id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
    [pk runAction:anis];
   
    if (canTouch) {
        
        
        canTouch = NO;
        CCSprite *lb = (CCSprite*)[spritesBgNode getChildByTag:kTagLb];
        NSMutableArray *aniFrame2 = [NSMutableArray array];
        [aniFrame2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_6"]];
        [aniFrame2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_5"]];
        [aniFrame2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_4"]];
        [aniFrame2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_3"]];
        id animation2 = [CCAnimation animationWithFrames:aniFrame2 delay:0.15];
        id ani2 = [CCAnimate actionWithAnimation:animation2 restoreOriginalFrame:NO];
        
        NSMutableArray *aniFrame = [NSMutableArray array];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_2"]];
        [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_1"]];
        id animation = [CCAnimation animationWithFrames:aniFrame delay:0.1];
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:ani];
        
        id am2 = [CCMoveTo actionWithDuration:2 position:ccp(-101,710)];
       
        //id as2 = [CCSpawn actions:a,am2,nil];
        id bl = [CCCallBlock actionWithBlock:BCA(^(void){
            [lb stopAllActions];
            [self flyToPunk:lb];
        })];
        
        [lb runAction:[CCSequence actions:ani2,[CCCallBlock actionWithBlock:BCA(^(void){
            [lb runAction:a];
        })],am2,[CCDelayTime actionWithDuration:0.5],bl,nil]];
        
        
    }
}
-(void)flyToPunk:(CCSprite*)lb
{
    [self loadSpriteSheet];


    [lb stopAllActions];
    lb.position = ccp(133,57);//for ipad
    NSMutableArray *aniFrame = [NSMutableArray array];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_2"]];
    [aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_1"]];
    //[aniFrame addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p2_w1"]];
    id animation = [CCAnimation animationWithFrames:aniFrame delay:0.1];
    id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
    id a = [CCRepeatForever actionWithAction:ani];
    [a setTag:101];
    [lb runAction:a];
    
    CGPoint startP = ccp(1065,263);
    CGPoint contP = ccp(628,774);
    CGPoint endP = ccp(437,509);
    float time = [Common createRandomsizeValueFloat:2 toFloat:5];
    //float time = 4;
    ccBezierConfig bezier; // 创建贝塞尔曲线
    bezier.controlPoint_1 = startP; // 起始点
    bezier.controlPoint_2 = contP; //控制点
    bezier.endPosition = endP; // 结束位置  
    CCBezierTo *actionMove1 = [CCBezierTo actionWithDuration:time bezier:bezier];
    
    startP = endP;
    contP = ccp(747,541);
    endP = ccp(509,623);
    time = 2;
    bezier.controlPoint_1 = startP; // 起始点
    bezier.controlPoint_2 = contP; //控制点
    bezier.endPosition = endP; // 结束位置 
    CCBezierTo *actionMove2 = [CCBezierTo actionWithDuration:time bezier:bezier];
    
    startP = endP;
    contP = ccp(335,563);
    endP = ccp(437,509);
    time = 1.3;
    bezier.controlPoint_1 = startP; // 起始点
    bezier.controlPoint_2 = contP; //控制点
    bezier.endPosition = endP; // 结束位置 
    CCBezierTo *actionMove3 = [CCBezierTo actionWithDuration:time bezier:bezier];
    
    
    NSMutableArray *aniFrame1 = [NSMutableArray array];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_3"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_4"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_5"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p14_lb_6"]];
    id animation1 = [CCAnimation animationWithFrames:aniFrame1 delay:0.15];
    id ani1 = [CCAnimate actionWithAnimation:animation1 restoreOriginalFrame:NO];
    
    id as = [CCSequence actions:actionMove1,[CCCallBlock actionWithBlock:BCA(^(void){
        [lb stopActionByTag:101];
        canTouch = YES;
    })],ani1,nil];
    [lb runAction:as];
}
@end

@implementation PageLayer15
-(id)init
{
	if ((self = [super init])) {
        [self initBox2d];
        [self loadSpriteSheet];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p15_body.plist"];
        CCSprite *cloth = [CCSprite spriteWithSpriteFrameName:@"p15_bg"];
        cloth.position = ccp(screenSize.width/2,[cloth contentSize].height/2);
        [spritesBgNode addChild:cloth z:-1];
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(cloth.position.x/PTM_RATIO,cloth.position.y/PTM_RATIO );
        bodyDef.userData = cloth;
        //bodyDef.fixedRotation = YES;
        b2Body *body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:@"p15_bg"];
        [cloth setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p15_bg"]];
        
        
        
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallbackStatic callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		//b2Body* m_mouseBody = callback.m_fixture->GetBody();
        //CCLOG(@"asd");
        [self addHoll:rightPosition];
	}
	
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	if (!useBox2d) {
        return;
    }
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
	
}
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (!useBox2d) {
        return;
    }
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation=[touch locationInView:[touch view]];
	touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    
	if (m_mouseJoint) {
		
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!useBox2d) {
        return;
    }
	for( UITouch *touch in touches ) {
    }
}
-(void)addHoll:(CGPoint)p
{
    [self loadSpriteSheet];
    NSMutableArray *aniFrame1 = [NSMutableArray array];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_1"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_2"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_3"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_4"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_5"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_6"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_7"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_8"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_9"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_10"]];
    [aniFrame1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p15_11"]];
    id animation1 = [CCAnimation animationWithFrames:aniFrame1 delay:0.1];
    id ani1 = [CCAnimate actionWithAnimation:animation1 restoreOriginalFrame:YES];
    
    int a = [Common createRandomsizeValueInt:1 toInt:3];
    CCSprite *holl = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p15_te%d",a]];
    [spritesBgNode addChild:holl z:3 ];
    holl.scale = 0.7;
    holl.position = ccp(p.x,p.y+40);//for ipad
    //[holl runAction:[CCMoveBy actionWithDuration:0.7 position:ccp(0,-100)]];
    [holl setOpacity:0];
    [holl runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.3],[CCDelayTime actionWithDuration:0.5],[CCFadeOut actionWithDuration:0.8],nil]];
    [holl runAction:ani1];
}
@end
@implementation PageLayer16
-(void)onEnterTransitionDidFinish
{
    
    [super onEnterTransitionDidFinish];
    [self loadSpriteSheet];
    CCSprite *door = [CCSprite spriteWithSpriteFrameName:@"p16_d_1"];
    door.position = ccp(666,568.5);//for ipad
    [spritesBgNode addChild:door z:20];
    id animation = [CCAnimation animation];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_1"]
                  delay:2.5];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_2"]
                  delay:0.2];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_3"]
                  delay:0.1];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_4"]
                  delay:5];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_3"]
                  delay:0.1];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_2"]
                  delay:0.1];
    [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_d_1"]
                  delay:0.1];
    id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
    id a = [CCRepeatForever actionWithAction:ani];
    //[a setTag:101];
    [door runAction:a];
}
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d]; 
        //self.isAccelerometerEnabled = YES;
        CCSprite *bg = [CCSprite spriteWithFile:@"p16_bg.pvr.ccz"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [self addChild:bg z:-2];
        
//        CCSprite *bgMs = [CCSprite spriteWithFile:@"p16_mask_bg.pvr.ccz"];
//        bgMs.position = ccp(screenSize.width/2,screenSize.height/2);
//        [self addChild:bgMs z:-2 tag:200];
        
        CCSprite *bg2 = [CCSprite spriteWithSpriteFrameName:@"p16_ms"];
        bg2.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg2 z:0];
        
        CCSprite *tu = [CCSprite spriteWithSpriteFrameName:@"p16_tuzi"];
        tu.position = ccp(389.7,268.5);//for ipad
        [spritesBgNode addChild:tu z:20];
        
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_tuzi_2"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p16_tuzi"]
                       delay:0.1];
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:anis];
        [tu runAction:a];
        
        CCSprite *sun = [CCSprite spriteWithSpriteFrameName:@"p16_sun"];
        sun.position = ccp(269,442);//for ipad
        [spritesBgNode addChild:sun z:-1 tag:100];
        firstPos = sun.position;   
        
//        CCSprite *sun_m = [CCSprite spriteWithSpriteFrameName:@"p16_sun_mask"];
//       sun_m.anchorPoint = ccp(0,0);//for ipad
//        sun_m.position = ccp(0,0);
//        [sun addChild:sun_m z:10 tag:101];
//        [sun_m setOpacity:0];
        //firstPos = sun_m.position;   
//        [sun_m setBlendFunc:(ccBlendFunc){GL_ONE,GL_ZERO}]; 
        
        CCSprite *mask = [CCSprite spriteWithSpriteFrameName:@"p16_mask"];
        mask.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:mask z:2 tag:101];
        
       // [mask setBlendFunc:(ccBlendFunc){GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA}];
        
        [self schedule:@selector(step:)];
        firstPos = sun.position;   
	}
	return self;
}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[super ccTouchesBegan:touches withEvent:event];
	CCSprite *sun = (CCSprite*)[spritesBgNode getChildByTag:100];
	//CCSprite *watter = (CCSprite*)[rabbit getChildByTag:100];
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [self convertTouchToNodeSpace:touch];
	if (CGRectContainsPoint(sun.boundingBox, rightPosition)) {
        [sun stopAllActions];
		canMove = YES;
	}
	else {
		canMove = NO;
	}
    
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCSprite *sun = (CCSprite*)[spritesBgNode getChildByTag:100];
	UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [self convertTouchToNodeSpace:touch];
	CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation  = ccpSub(rightPosition,oldTouchLocation);
    if (CGRectContainsPoint(sun.boundingBox, rightPosition)) {
        [sun stopAllActions];
		canMove = YES;
	}
	else {
		canMove = NO;
	}
    if (canMove) {
        sun.position = ccpAdd(sun.position,translation);
        
        double retvalY=sun.position.y;
        double retvalX=sun.position.x;
        
        retvalY = MIN(retvalY, screenSize.height);
        retvalY = MAX(retvalY, 440); 
        
        retvalX = MIN(retvalX, 510);
        retvalX = MAX(retvalX, 0); 
        
        sun.position = ccp(retvalX,retvalY);         
	}
    
}
-(void) step:(ccTime)dt
{
    CCSprite *sun = (CCSprite*)[spritesBgNode getChildByTag:100];
    //CCSprite *sun_m = (CCSprite*)[sun getChildByTag:101];
     CCSprite *mask = (CCSprite*)[spritesBgNode getChildByTag:101];
    // CCSprite *mask_bg = (CCSprite*)[self getChildByTag:200];
    float dy =  screenSize.height - 440;
    float srcy = sun.position.y - 440;
    float op = 255-srcy/dy*255;
    //CCLOG(@"op = %f",op);
    //[sun_m setOpacity:op];
    [mask setOpacity:op];
    //[mask_bg setOpacity:op];
}
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCSprite *rabbit = (CCSprite*)[spritesBgNode getChildByTag:100];
	
	UITouch *touch = [touches anyObject];
    
    id action = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:firstPos] rate:0.8];
    [rabbit runAction:action];
	canMove = NO;
    
}
/*-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d]; 
        self.isAccelerometerEnabled = YES;
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p16_bg"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg z:-1];
        
        CCSprite *bg2 = [CCSprite spriteWithSpriteFrameName:@"p16_ms"];
        bg2.position = ccp(screenSize.width/2,screenSize.height/2);
        [spritesBgNode addChild:bg2 z:0];
        
        CCSprite *tu = [CCSprite spriteWithSpriteFrameName:@"p16_tuzi"];
        tu.position = ccp(389.7,268.5);//for ipad
        [spritesBgNode addChild:tu z:0];
        
        CCSprite *sun = [CCSprite spriteWithSpriteFrameName:@"p16_sun"];
        sun.position = ccp(269,468+50);//for ipad
        [spritesBgNode addChild:sun z:-1];
        
        b2EdgeShape groundBox;		
        
        // top
        groundBody->DestroyFixture(groundTop);
        groundBox.Set(b2Vec2(0,(screenSize.height+[sun contentSize].height/2)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,(screenSize.height+[sun contentSize].height/2)/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // left
        groundBody->DestroyFixture(groundLeft);
        groundBox.Set(b2Vec2((-[sun contentSize].height/2)/PTM_RATIO,0), 
                      b2Vec2((-[sun contentSize].height/2)/PTM_RATIO,screenSize.height/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // right
        groundBody->DestroyFixture(groundRight);
        groundBox.Set(b2Vec2((510+[sun contentSize].height/2)/PTM_RATIO,0), b2Vec2((510+[sun contentSize].height/2)/PTM_RATIO,screenSize.height/PTM_RATIO));//for ipad
        groundBody->CreateFixture(&groundBox,0);
        
        // bottom
        groundBody->DestroyFixture(groundBottom);
        groundBox.Set(b2Vec2(0,(450-[sun contentSize].height/2)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,(450-[sun contentSize].height/2)/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sun.position.x/PTM_RATIO,sun.position.y/PTM_RATIO );
        bodyDef.userData = sun;
        bodyDef.fixedRotation = YES;
        b2Body *body = world->CreateBody(&bodyDef);
        
        b2CircleShape ps;
        ps.m_radius = [sun contentSize].width/2/PTM_RATIO;
        
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &ps;
        fixtureDef.density = 1.0;
        fixtureDef.friction = 0.1;
        fixtureDef.restitution =  0.1;
        body->CreateFixture(&fixtureDef);
        
	}
	return self;
}*/
@end
#define kTagBody 100
@implementation PageLayer17
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self loadSpriteSheet];
    CCSprite *tear = (CCSprite*)[spritesBgNode getChildByTag:110];
    {
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t1"]
                       delay:0.15];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t2"]
                       delay:0.15];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t3"]
                       delay:0.15];
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        
        
        id animations1 = [CCAnimation animation];
        [animations1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t4"]
                        delay:0.2];
        [animations1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t5"]
                        delay:0.2];
        [animations1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t4"]
                        delay:0.2];
        [animations1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_t3"]
                        delay:0.2];
        id anis1 = [CCAnimate actionWithAnimation:animations1 restoreOriginalFrame:NO];
        id a1 = [CCRepeatForever actionWithAction:anis1];
        
        [tear runAction:[CCSequence actions:anis,[CCCallBlock actionWithBlock:BCA(^(void){
            [tear runAction:a1];
        })],nil]];
    }
}
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p17_rb"];
        bg.position = ccp(screenSize.width/2,263);//for ipad
        [spritesBgNode addChild:bg z:1];
       
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_rb_2"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p17_rb"]
                       delay:0.1];
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:anis];
        [bg runAction:a];
        
        CCSprite *tear = [CCSprite spriteWithSpriteFrameName:@""];
        tear.position = ccp(530.6,205.8);//for ipad
        [spritesBgNode addChild:tear z:2 tag:110];
 
        
        
        
        array = [[NSMutableArray array] retain];
        for (int i = 1 ; i < 5; i++) {
            ani[i-1] = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p17_ani%d",i]];
            [spritesBgNode addChild:ani[i-1] z:0];
            [array addObject:ani[i-1]];
        }
        
        pos[0]= ani[0].position = ccp(246,339+1000);//for ipad
        pos[1]= ani[1].position = ccp(365.7,271.6+1000);//for ipad
        pos[2]= ani[2].position = ccp(682.4,272.2+1000);//for ipad
        pos[3]= ani[3].position = ccp(811.9,140.8+1000);//for ipad
        
        
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	if ([array count]>0) {
        int a = [Common createRandomsizeValueInt:0 toInt:[array count]-1];
        CCSprite* sp = [array objectAtIndex:a];
        id a1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0,-1000)];
        id a2 = [CCEaseElasticOut actionWithAction:a1 period:0.9];
        [sp runAction:a2];
        [array removeObjectAtIndex:a];
    }
	else {
        for (int i = 3; i >=0; i--) {
            if (CGRectContainsPoint(ani[i].boundingBoxInPixels, rightPosition)) {
                isTouch[i] = YES;
                break;
            }
        }
    }
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    for (int i = 3; i >=0; i--) {
        if (CGRectContainsPoint(ani[i].boundingBoxInPixels, rightPosition)) {
            isTouch[i] = YES;
            break;
        }
    }
    for (int i = 0; i <4; i++) {
        if (isTouch[i]) {
            CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
            oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
            oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
            
            CGPoint translation = ccpSub(rightPosition, oldTouchLocation);
            CGPoint newPos = ccpAdd(ani[i].position, translation);
            ani[i].position = newPos;
            break;
        }
    }
    
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    for (int i = 0; i <4; i++) {
        if (isTouch[i]) {
            //ani[i].position = rightPosition;
            //float time = sqrtf(powf(ani[i].position.y-pos[i].y-1000,2)+powf(ani[i].position.x-pos[i].x, 2));
            id a1= [CCMoveTo actionWithDuration:0.5 position:ccp(pos[i].x,pos[i].y-1000)];
            id a2 = [CCEaseElasticOut actionWithAction:a1 period:0.9];        
            [ani[i] runAction:a2];
            isTouch[i] = NO;
            break;
        }
    }
    
}
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    for (int i = 0; i <4; i++) {
        if (isTouch[i]) {
            //ani[i].position = rightPosition;
            float time = sqrtf(powf(ani[i].position.y-pos[i].y,2)+powf(ani[i].position.x-pos[i].x, 2));
            id a1= [CCMoveTo actionWithDuration:time/500.0f position:ccp(pos[i].x,pos[i].y-1000)];
            id a2 = [CCEaseElasticOut actionWithAction:a1 period:0.9];        
            [ani[i] runAction:a2];
            isTouch[i] = NO;
            break;
        }
    }
    
}

@end
@implementation PageLayer18
#define kTagAni 100
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_bg"];
            sprAni.position = ccp(screenSize.width/2,screenSize.height/2);
            [spritesBgNode addChild:sprAni z:0];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_li_1"];
            sprAni.position = ccp(601.1,477.2);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_li_tz"];
            sprTz.position = ccp(601.2,560.4);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_cat_1"];
            sprAni.position = ccp(855.7,380.8);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+1];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_li_tz"];
            sprTz.position = ccp(890.5,394.2);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_d_1"];
            sprAni.position = ccp(354.6,399.2);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+2];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_d_tz"];
            sprTz.position = ccp(380.1,434.5);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_grf_1"];
            sprAni.position = ccp(137.4,498.7);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+3];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_grf_tz"];
            sprTz.position = ccp(141.1,612.3);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_lb_1"];
            sprAni.position = ccp(724.1,330.8);
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+4];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_lb_tz"];
            sprTz.position = ccp(702.8,310.2);//for ipad//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_ms_1"];
            sprAni.position = ccp(524.6,218.1);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+5];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_ms_tz"];
            sprTz.position = ccp(480,194.5);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_mk_1"];
            sprAni.position = ccp(216.7,288.7);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+6];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_mk_tz"];
            sprTz.position = ccp(179.7,358.5);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_pig_1"];
            sprAni.position = ccp(875.7,126.6);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+7];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_pig_tz"];
            sprTz.position = ccp(872.4,106.8);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_sp_2"];
            sprAni.position = ccp(141.2,91.1);//for ipad
            [spritesBgNode addChild:sprAni z:0 tag:kTagAni+8];
            animal[sprAni.tag-100] = sprAni;
            pos[sprAni.tag-100] = sprAni.position;
            
            CCSprite *sprTz = [CCSprite spriteWithSpriteFrameName:@"p18_sp_tz"];
            sprTz.position = ccp(127.6,98);//for ipad
            animalTz[sprAni.tag-100] = sprTz;
            [spritesBgNode addChild:sprTz z:-3];
            
        }
        
        {
            CCSprite *sprAni = [CCSprite spriteWithSpriteFrameName:@"p18_rb"];
            sprAni.position = ccp(screenSize.width/2,[sprAni contentSize].height/2);
            [spritesBgNode addChild:sprAni z:0];
        }
        
	}
	return self;
  }
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	for (int i = 0; i<9; i++) {
        
        if ([self isInBox:rightPosition sprite:animalTz[i]]) {
            for (int j = 0; j<9; j++) {
                [animal[j] stopAllActions];
                animal[j].position = pos[j];
                
            }
            id a1 = [CCJumpBy actionWithDuration:50 position:ccp(0,0) height:20.0f jumps:100];
            [animal[i] runAction:a1];
            //break;
            return;
        }
        
        
    }	
}
@end

@implementation PageLayer19
-(id)init
{
    if ( self = [super init] ) {
        [self loadSpriteSheet];
        [self initBox2d];
        //self.isAccelerometerEnabled = YES;
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p19_body.plist"];
        
        CCSprite *sprfl = [CCSprite spriteWithSpriteFrameName:@"p19_fl"];
        sprfl.position = ccp(screenSize.width/2,13);//for ipad
        [spritesBgNode addChild:sprfl z:0 ];
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprfl.position.x/PTM_RATIO,sprfl.position.y/PTM_RATIO );
        bodyDef.userData = sprfl;
        bodyDef.fixedRotation = NO;
        b2Body *body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:@"p19_fl"];
        [sprfl setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p19_fl"]];     
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(body, groundBody, b2Vec2(body->GetPosition().x,body->GetPosition().y-3));
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/10.0f * b2_pi;
        rjd.upperAngle = 1/5.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        //rjd.localAnchorA = body->GetPosition();
        //rjd.localAnchorB = b2Vec2(body->GetPosition().x,body->GetPosition().y-5);
        world->CreateJoint(&rjd);
        
        CCSprite *sprms = [CCSprite spriteWithSpriteFrameName:@"p19_ms"];
        sprms.position = ccp(504,213);//for ipad
        [spritesBgNode addChild:sprms z:0 tag:100];
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprms.position.x/PTM_RATIO,sprms.position.y/PTM_RATIO );
        bodyDef.userData = sprms;
        bodyDef.fixedRotation = NO;
        b2Body *body1 = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body1 forShapeName:@"p19_ms"];
        [sprms setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p19_ms"]];  
        
        rjd.Initialize(body1, body, body1->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/10.0f * b2_pi;
        rjd.upperAngle = 1/10.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);

        
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
        b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);

        
        emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"19_waterFade.plist"];
        batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
        emitter_.position = rightPosition;
        emitter_.autoRemoveOnFinish = YES;
        emitter_.positionType =  kCCPositionTypeGrouped;
        emitter_.blendAdditive = YES;  
        [batchNode_ addChild:emitter_];
        [self addChild:batchNode_ z:-2];
	}
	
}
-(void)tick:(ccTime)dt
{
    [super tick:dt];
    CCSprite *fl = (CCSprite*)[spritesBgNode getChildByTag:100];
    if (emitter_) {
        emitter_.position = fl.position;
    }
    
}
@end
@implementation PageLayer20
-(id)init
{
	if ((self = [super init])) {
        CCLOG(@"in layer%d",sceneIdx);
        isJigsaw = YES;
		[self addChild:[[[pintu alloc] initWithPage:sceneIdx type:1] autorelease] z:2];
    }
    return self;
}
+(id)scene_other
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	//PageCommon *layer1  = [PageCommon node];
	// 'layer' is an autorelease object.
	PageCommon *layer = [[[NSClassFromString([NSString stringWithFormat:@"PageLayer%d",sceneIdx]) alloc] initOther] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer ];
	//[scene addChild:layer1];
	
	// return the scene
	return scene;
}
-(id)initOther
{
    if ((self = [super init])) {
        isJigsaw = NO;
        [self loadSpriteSheet];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p20_bg_2"];
        [self addChild:bg z:-2];
        bg.anchorPoint = ccp(0,0);
        
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p20_F_546_352_"];
            bg.position = ccp(631.1,309.8);//for ipad
            [spritesBgNode addChild:bg z:-2];
            bg.anchorPoint = ccp(0.7,0.25);
            bg.rotation = -5;
            [bg runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:0.2 angle:2.5],[CCRotateBy actionWithDuration:0.2 angle:-2.5], nil]]];
        }
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p20_G_1_219_441"];
            bg.position = ccp(219,screenSize.height-441);//for ipad
            [spritesBgNode addChild:bg z:-2];
       
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p20_G_2_219_441"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p20_G_3_219_441"]
                           delay:0.2]; 
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p20_G_1_219_441"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
        }
        
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p20_M_1_799_455"];
            bg.position = ccp(799,screenSize.height-455);//for ipad
            [spritesBgNode addChild:bg z:-2];
            
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p20_M_2_799_455"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p20_M_1_799_455"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
        }   
        
        
        
    }
	return self;
    
    
}
-(void)dealloc
{
    [[[CCDirector sharedDirector] openGLView] setMultipleTouchEnabled:YES];
    [super dealloc];
}
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	//UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    [batchNode_ removeAllChildrenWithCleanup:YES];
    [self removeChild:batchNode_ cleanup:YES];
    
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:[NSString stringWithFormat:@"%d_waterFade.plist",sceneIdx]];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
    emitter_.position = rightPosition;
    emitter_.autoRemoveOnFinish = YES;
    emitter_.positionType =  kCCPositionTypeRelative;
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:2];
    
    return YES;
}
- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    emitter_.position = rightPosition;
    
}
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	CCLOG(@"emitter_%f,%f",rightPosition.x,rightPosition.y);
    [emitter_ stopSystem];
}
- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self ccTouchEnded:touch withEvent:event];
}
@end
@implementation PageLayer21
-(id)init
{
    if ( self = [super init] ) {
        [self loadSpriteSheet];
        [self initBox2d];
        
        label.position = ccpAdd(label.position,ccp(0,-50));
        
                
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p21_body.plist"];
        emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"21_waterFade.plist"];
        batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
        //emitter_.position = rightPosition;
        emitter_.autoRemoveOnFinish = YES;
        emitter_.positionType =  kCCPositionTypeGrouped;
        emitter_.blendAdditive = YES;  
        [batchNode_ addChild:emitter_];
        [self addChild:batchNode_ z:-1];
        
        
        NSString *tmpName = @"p21_leaf";
        CCSprite *sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [spritesBgNode addChild:sprBody z:-1 ];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        sprBody.position = ccp(512,771);//for ipad
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *stickBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:stickBody forShapeName:tmpName];
        
        b2RevoluteJointDef rjd;
        rjd.Initialize(stickBody, groundBody, stickBody->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        //rjd.maxMotorTorque = 10.0f;
        rjd.enableMotor = NO;
        rjd.lowerAngle = -1/10.0f;//-1/80.0f * b2_pi;
        rjd.upperAngle = 1/10.0f * b2_pi;
        rjd.enableLimit = true;
        rjd.collideConnected = false;
        world->CreateJoint(&rjd);
        
        emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:@"21_waterFade.plist"];
        batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
        //emitter_.position = rightPosition;
        emitter_.autoRemoveOnFinish = YES;
        emitter_.positionType =  kCCPositionTypeGrouped;
        emitter_.blendAdditive = YES;  
        [batchNode_ addChild:emitter_];
        [self addChild:batchNode_ z:-1];

        
        tmpName = @"p21_mk";
        sprBody = [CCSprite spriteWithSpriteFrameName:tmpName];
        [sprBody setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:tmpName]];
        [spritesBgNode addChild:sprBody z:-1 ];
        sprBody.position = ccp(560.8,486.4);//for ipad
        
        bodyDef.type = b2_dynamicBody;
        bodyDef.fixedRotation = NO;
        bodyDef.position.Set(sprBody.position.x/PTM_RATIO,sprBody.position.y/PTM_RATIO );
        bodyDef.userData = sprBody;
        b2Body *bagbody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bagbody forShapeName:tmpName];
        
//        b2WeldJointDef wjd;
//        wjd.Initialize(bagbody, stickBody, bagbody->GetPosition());
//        world->CreateJoint(&wjd);
        
        b2RevoluteJointDef rjd1;
        rjd1.Initialize(bagbody,stickBody, bagbody->GetPosition());
        //rjd.motorSpeed = 1.0f * b2_pi;
        //rjd.maxMotorTorque = 10.0f;
        rjd1.enableMotor = NO;
        rjd1.lowerAngle = -1/20.0f * b2_pi;
        rjd1.upperAngle = 1/20.0f * b2_pi;
        rjd1.enableLimit = true;
        rjd1.collideConnected = false;
        world->CreateJoint(&rjd1);

        
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	b2Vec2 p =b2Vec2(rightPosition.x/PTM_RATIO,rightPosition.y/PTM_RATIO);
	m_mouseWorld = p;
	b2BodyDef bodyDef;
	b2Body *m_groundBody = world->CreateBody(&bodyDef);
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	// Query the world for overlapping shapes.
	
	MyQueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
        b2Body* m_mouseBody = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = m_mouseBody;
		md.target = p;
		md.maxForce = 1000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
	
}
@end

@implementation PageLayer22
#define k22TagFish 100
#define k22TagQw   200
-(id)init
{
	if ((self = [super init])) {
		CCLOG(@"in layer%d",sceneIdx);
        //isJigsaw = YES;
		//[self addChild:[[[pintu alloc] initWithPage:sceneIdx] autorelease] z:2];
        //CCLOG(@"in layer%d",sceneIdx);
        isJigsaw = YES;
		[self addChild:[[[pintu alloc] initWithPage:sceneIdx type:1] autorelease] z:2];
        
	}
	return self;
}
+(id)scene_other
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	//PageCommon *layer1  = [PageCommon node];
	// 'layer' is an autorelease object.
	PageCommon *layer = [[[NSClassFromString([NSString stringWithFormat:@"PageLayer%d",sceneIdx]) alloc] initOther] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer ];
	//[scene addChild:layer1];
	
	// return the scene
	return scene;
}
-(id)initOther
{
    if ((self = [super init])) {
        isJigsaw = NO;
        [self loadSpriteSheet];        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_bg.plist",sceneIdx]];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_bg"];
        [self addChild:bg z:-2];
        bg.anchorPoint = ccp(0,0);
        //================================rain==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_r1"];
            //bg.position = ccp(0,0);
            [self addChild:bg z:-2];
            bg.anchorPoint = ccp(0,0);
            bg.position = ccp(0,8);
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_r2"]
                           delay:0.1];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_r3"]
                           delay:0.1]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        //================================Flower water==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_w1"];
            bg.position = ccp(516.2,583.8);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_w2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_w3"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        //================================Flower sub==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ww1"];
            bg.position = ccp(122.1,211.6);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ww2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ww3"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
       
 
        //================================water-drop2==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ly1_1"];
            bg.position = ccp(235.9,145);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nil]
                           delay:[Common createRandomsizeValueFloat:0 toFloat:2]];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly1_2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly1_3"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        
        //================================water-drop2==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ly2_1"];
            bg.position = ccp(548.2,342.6);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nil]
                           delay:[Common createRandomsizeValueFloat:0 toFloat:2]];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly2_2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly2_3"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        //================================water-drop1==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ly3_1"];
            bg.position = ccp(63.2,345.8);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nil]
                           delay:[Common createRandomsizeValueFloat:0 toFloat:2]];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_3"]
                           delay:0.2]; 
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_4"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        
        //================================water-drop1==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ly3_1"];
            bg.position = ccp(268.8,254.1);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nil]
                           delay:[Common createRandomsizeValueFloat:0 toFloat:2]];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_3"]
                           delay:0.2]; 
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_4"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        
        //================================water-drop1==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ly3_1"];
            bg.position = ccp(260.1,118.3);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nil]
                           delay:[Common createRandomsizeValueFloat:0 toFloat:2]];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_3"]
                           delay:0.2]; 
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_4"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        
        //================================water-drop1==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_ly3_1"];
            bg.position = ccp(874.2,271.4);//for ipad
            [self addChild:bg z:-2];
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nil]
                           delay:[Common createRandomsizeValueFloat:0 toFloat:2]];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_2"]
                           delay:0.2];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_3"]
                           delay:0.2]; 
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_ly3_4"]
                           delay:0.2]; 
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [bg runAction:a];
            
        }
        
        //================================Fish==============================
        {
            CCSprite *bg = [CCSprite node];
            bg.position = ccp(155.2,267.6);//for ipad
            [self addChild:bg z:-2 tag:k22TagFish];
            bg.opacity = 0;
        }
        //================================Fish==============================
        {
            CCSprite *bg = [CCSprite node];
            bg.position = ccp(647.4,375.1);//for ipad
            [self addChild:bg z:-2 tag:k22TagFish+1];
            bg.scale = 0.774;
            bg.opacity = 0;
        }
        //================================Fish==============================
        {
            CCSprite *bg = [CCSprite node];
            bg.position = ccp(238.2,410.5);//for ipad
            [self addChild:bg z:-2 tag:k22TagFish+2];
            bg.scale = 0.543;
            bg.flipX = YES;
            bg.opacity = 0;
        }
        //================================青蛙==============================
        {
            CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p22_qw_1"];
            bg.position = ccp(763.7,231.5);//for ipad
            [self addChild:bg z:-2 tag:k22TagQw];
        }
        [self schedule:@selector(fishStep:) interval:0];
        
    }
	return self;
    
    
}
-(void)fishStep:(ccTime)dt
{
    [self loadSpriteSheet];
    [self schedule:_cmd interval:[Common createRandomsizeValueFloat:2.1 toFloat:3]];
    //================================Fish==============================
    {
        CCSprite *bg = (CCSprite*)[self getChildByTag:k22TagFish];
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_1"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_2"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_3"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_4"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_5"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_6"]
                       delay:0.1]; 
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        
        id as = [CCSequence actions:[CCDelayTime actionWithDuration:[Common createRandomsizeValueFloat:0 toFloat:0.5]],[CCCallBlock actionWithBlock:BCA(^(void){
            bg.opacity = 255;
        })],anis,[CCCallBlock actionWithBlock:BCA(^(void){
            bg.opacity = 0;
        })] ,nil];
        [bg runAction:as];
    }
    
    {
        CCSprite *bg = (CCSprite*)[self getChildByTag:k22TagFish+1];
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_1"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_2"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_3"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_4"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_5"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_6"]
                       delay:0.1]; 
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        id as = [CCSequence actions:[CCDelayTime actionWithDuration:[Common createRandomsizeValueFloat:0.8 toFloat:1.2]],[CCCallBlock actionWithBlock:BCA(^(void){
            bg.opacity = 255;
        })],anis,[CCCallBlock actionWithBlock:BCA(^(void){
            bg.opacity = 0;
        })] ,nil];
        [bg runAction:as];

    }
    
    {
        CCSprite *bg = (CCSprite*)[self getChildByTag:k22TagFish+2];
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_1"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_2"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_3"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_4"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_5"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_f_6"]
                       delay:0.1]; 
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        id as = [CCSequence actions:[CCDelayTime actionWithDuration:[Common createRandomsizeValueFloat:1.6 toFloat:2.0]],[CCCallBlock actionWithBlock:BCA(^(void){
            bg.opacity = 255;
        })],anis,[CCCallBlock actionWithBlock:BCA(^(void){
            bg.opacity = 0;
        })] ,nil];
        [bg runAction:as];

    }
    
    //================================青蛙==============================
    {
        CCSprite *bg = (CCSprite*)[self getChildByTag:k22TagQw];
        id animations = [CCAnimation animation];
        
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_qw_2"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_qw_3"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_qw_2"]
                       delay:0.1]; 
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p22_qw_1"]
                       delay:0.1]; 
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
        
        //id a = [CCRepeatForever actionWithAction:anis];
        [bg runAction:anis];
    }
}
-(void)goSomeWhere
{
    
}
-(void)dealloc
{
     [[[CCDirector sharedDirector] openGLView] setMultipleTouchEnabled:YES];
    [super dealloc];
}
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	//UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    [batchNode_ removeAllChildrenWithCleanup:YES];
    [self removeChild:batchNode_ cleanup:YES];
    
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:[NSString stringWithFormat:@"%d_waterFade.plist",sceneIdx]];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
    emitter_.position = rightPosition;
    emitter_.autoRemoveOnFinish = YES;
    emitter_.positionType =  kCCPositionTypeRelative;
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:2];
    
    return YES;
}
- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    emitter_.position = rightPosition;
    
}
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	CCLOG(@"emitter_%f,%f",rightPosition.x,rightPosition.y);
    [emitter_ stopSystem];
}
- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self ccTouchEnded:touch withEvent:event];
}
@end

@implementation PageLayer23
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        CCSprite *punk = [CCSprite spriteWithSpriteFrameName:@"p23_pk"];
        punk.position = ccp(screenSize.width/2,punk.contentSize.height/2);
        [spritesBgNode addChild:punk z:0 tag:101];
        
             
        CCSprite *lb = [CCSprite spriteWithSpriteFrameName:@"p23_lb_1"];
        lb.position = ccp(558.4,229.5);//for ipad
        [spritesBgNode addChild:lb z:0 tag:100];
        isCanTouch = YES;
        
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
         [self loadSpriteSheet];
	UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
   
    CCSprite *punk = (CCSprite*)[spritesBgNode getChildByTag:101];
    id animations = [CCAnimation animation];
    [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_pk_2"]
                   delay:0.1];
    [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_pk"]
                   delay:0.1];
    id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
    //id a = [CCRepeatForever actionWithAction:anis];
    [punk runAction:anis];

    
    if (!isCanTouch) {
        return;
    } 
    isCanTouch = NO;

    CCSprite *lb = (CCSprite*)[spritesBgNode getChildByTag:100];
    id animation1 = [CCAnimation animation];
    [animation1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_2"]
                  delay:0.2];
    [animation1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_3"]
                  delay:0.2];
    [animation1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_4"]
                  delay:0.2];
    [animation1 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_5"]
                  delay:0.2];
    
    id ani1 = [CCAnimate actionWithAnimation:animation1 restoreOriginalFrame:NO];
 
    
    id amv1 = [CCMoveBy actionWithDuration:0.8 position:ccp(0,lb.contentSize.height*2)];
    //id asp1 = [CCSpawn actions:a1,amv1, nil];//起飞
    id amv4 = [amv1 reverse];
    
    id animation2 = [CCAnimation animation];
    [animation2 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_6"]
                  delay:0.1];
    [animation2 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_7"]
                  delay:0.1];
    [animation2 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_8"]
                  delay:0.1];
    [animation2 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_7"]
                  delay:0.1];
    
    id ani2 = [CCAnimate actionWithAnimation:animation2 restoreOriginalFrame:NO];
    CCAction *a2 = [CCRepeat actionWithAction:ani2 times:8];
    //[a2 setac:2];
    a2.tag = 2;
    id amv2 = [CCMoveTo actionWithDuration:1.5 position:ccp(-123.6,477.5)];
    
    
     
    
    id animation3 = [CCAnimation animation];
    [animation3 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_5"]
                   delay:0.2];
    [animation3 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_4"]
                   delay:0.2];
    [animation3 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_3"]
                   delay:0.2];
    [animation3 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_2"]
                   delay:0.2];
    [animation3 addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p23_lb_1"]
                   delay:0.2];
    
    id ani3 = [CCAnimate actionWithAnimation:animation3 restoreOriginalFrame:NO];
    // id a1 = [CCRepeatForever actionWithAction:ani1];
    id amv3 = [CCMoveTo actionWithDuration:1.5 position:ccp(558.4,229.5+lb.contentSize.height*2)];
    
    
    id as2 = [CCSequence actions:amv1,amv2,[CCCallBlock actionWithBlock:BCA(^(void){
        lb.position = ccp(screenSize.width+lb.contentSize.width/2,lb.position.y);
    })],amv3,[CCCallBlock actionWithBlock:BCA(^(void){
        [lb stopAction:ani2];
    })],[CCCallBlock actionWithBlock:BCA(^(void){
        [lb runAction:ani3];
    })],amv4,[CCCallBlock actionWithBlock:BCA(^(void){
        isCanTouch = YES;
    })],nil];
    
    [lb runAction:[CCSequence actions:ani1,a2,nil]];
    [lb runAction:as2];
    //[lb runAction:a];
}
@end


@implementation PageLayer24
-(id)init
{
	if ((self = [super init])) {
		CCLOG(@"in layer%d",sceneIdx);
        isJigsaw = YES;
		[self addChild:[[[pintu alloc] initWithPage:sceneIdx type:1] autorelease] z:2];
        
	}
	return self;
}
+(id)scene_other
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	//PageCommon *layer1  = [PageCommon node];
	// 'layer' is an autorelease object.
	PageCommon *layer = [[[NSClassFromString([NSString stringWithFormat:@"PageLayer%d",sceneIdx]) alloc] initOther] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer ];
	//[scene addChild:layer1];
	
	// return the scene
	return scene;
}
-(id)initOther
{
    if ((self = [super init])) {
        isJigsaw = NO;
        //self.isTouchEnabled = YES;
        [self loadSpriteSheet];
        //[self initBox2d];           
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_bg.plist",sceneIdx]];
        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p24_bg"];
        [self addChild:bg z:-2];
        bg.anchorPoint = ccp(0,0);
        
        CCSprite *lb = [CCSprite spriteWithSpriteFrameName:@"pp24_Co_1_762.501"];
        lb.position = ccp(762,768-501-1);//for ipad
        [spritesBgNode addChild:lb z:0 tag:100];
     
        
        
        id animations = [CCAnimation animation];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pp24_Co_1_762.501"]
                       delay:0.1];
        [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pp24_Co_2_762.501"]
                       delay:0.1];
        
        [animations addFrame:nil delay:0.1];
        id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
        //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
        
        id a = [CCRepeatForever actionWithAction:anis];
        [lb runAction:a];
        
        
        {
            CCSprite *lb = [CCSprite spriteWithSpriteFrameName:@"pp24_Guang_651.417"];
            lb.position = ccp(651,768-417);//for ipad
            [spritesBgNode addChild:lb z:1 ];
            [lb setOpacity:0];
            id a1 = [CCFadeIn actionWithDuration:0.2];
            id a2 = [a1 reverse];
            id as = [CCSequence actions:a1,a2,[CCDelayTime actionWithDuration:1], nil];
             id a = [CCRepeatForever actionWithAction:as];
            [lb runAction:a];
            
        }
        
        {
            CCSprite *lb = [CCSprite spriteWithSpriteFrameName:@"pp24_XG_1.512.114"];
            lb.position = ccp(512,768-114);//for ipad
            [spritesBgNode addChild:lb z:1 ];
            
            id animations = [CCAnimation animation];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pp24_XG_2.512.114"]
                           delay:0.3];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pp24_XG_3.512.114"]
                           delay:0.3];
            [animations addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pp24_XG_1.512.114"]
                           delay:0.3];
            
            id anis = [CCAnimate actionWithAnimation:animations restoreOriginalFrame:NO];
            //id as = [CCSequence actions:<#(CCFiniteTimeAction *), ...#>, nil]
            
            id a = [CCRepeatForever actionWithAction:anis];
            [lb runAction:a];
            
        }
        

        {
            CCSprite *lb = [CCSprite spriteWithSpriteFrameName:@"pp24_Mao_287.533"];
            lb.position = ccp(287,768-533);//for ipad
            [spritesBgNode addChild:lb z:1 ];
            id a1 = [CCCallBlock actionWithBlock:BCA(^(void){
                lb.visible = YES;
            })];
            
            id a2 = [CCCallBlock actionWithBlock:BCA(^(void){
                lb.visible = NO;
            })];
            id a = [CCRepeatForever actionWithAction:[CCSequence actions:a1,[CCDelayTime actionWithDuration:0.1],a2,[CCDelayTime actionWithDuration:2],nil]];
            [lb runAction:a];
            
        }
        
        
        //[spritesBgNode add]
        
    }
	return self;
}
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	//UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    [batchNode_ removeAllChildrenWithCleanup:YES];
    [self removeChild:batchNode_ cleanup:YES];
    
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:[NSString stringWithFormat:@"%d_waterFade.plist",sceneIdx]];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:NO]; 
    emitter_.position = rightPosition;
    emitter_.autoRemoveOnFinish = YES;
    emitter_.positionType =  kCCPositionTypeRelative;
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:2];

    return YES;
}
- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{

	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    emitter_.position = rightPosition;
    
}
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	CCLOG(@"emitter_%f,%f",rightPosition.x,rightPosition.y);
    [emitter_ stopSystem];
}
- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self ccTouchEnded:touch withEvent:event];
}
-(void)dealloc
{
    [[[CCDirector sharedDirector] openGLView] setMultipleTouchEnabled:YES];
    [super dealloc];
}
@end


@implementation PageLayer25
-(id)init
{
	if ((self = [super init])) {
        [self loadSpriteSheet];
        [self initBox2d];
        self.isAccelerometerEnabled = YES;
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p25_body.plist"];
        CCSprite *bottle = [CCSprite spriteWithSpriteFrameName:@"p25_btt_"];
        bottle.position = ccp(484.4,126.6);//for ipad
        [spritesBgNode addChild:bottle z:0];
        
        CCSprite *seed = [CCSprite spriteWithSpriteFrameName:@"p25_seed"];
        seed.position = ccp(493.5,235.9);//for ipad
        [spritesBgNode addChild:seed z:0 ];
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(seed.position.x/PTM_RATIO,seed.position.y/PTM_RATIO );
        bodyDef.userData = seed;
        b2Body *seedBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:seedBody forShapeName:@"p25_seed"];
        [seed setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p25_seed"]];
        
        
        CCSprite *bottle1 = [CCSprite spriteWithSpriteFrameName:@"p25_btt"];
        bottle1.position = ccp(484,259.6);//for ipad
        [spritesBgNode addChild:bottle1 z:0];
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(bottle1.position.x/PTM_RATIO,bottle1.position.y/PTM_RATIO );
        bodyDef.userData = bottle1;
        b2Body *bottleBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bottleBody forShapeName:@"p25_btt"];
        
        
        CCSprite *bottle2 = [CCSprite spriteWithSpriteFrameName:@"p25_btt_y"];
        bottle2.position = ccp(132.3,12);//for ipad
        [bottle1 addChild:bottle2 z:0];
        
	}
	return self;
}
@end

@implementation PageLayer26
-(id)init
{
	if ((self = [super init])) {
        
        CCLOG(@"in layer%d",sceneIdx);
        isJigsaw = YES;
		[self addChild:[[[pintu alloc] initWithPage:sceneIdx type:1] autorelease] z:2];
        
        
        }
	return self;
}
+(id)scene_other
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	//PageCommon *layer1  = [PageCommon node];
	// 'layer' is an autorelease object.
	PageCommon *layer = [[[NSClassFromString([NSString stringWithFormat:@"PageLayer%d",sceneIdx]) alloc] initOther] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer ];
	//[scene addChild:layer1];
	
	// return the scene
	return scene;
}
-(id)initOther
{
    if ((self = [super init])) {
        isJigsaw = NO;
        [self loadSpriteSheet];
        [self initBox2d];    
        _contactListener = new MyContactListener();
        world->SetContactListener(_contactListener);
        CCSprite *rb = [CCSprite spriteWithSpriteFrameName:@"p26_lb_1"];
        rb.position = ccp(578.8,604.4);//for ipad
        [spritesBgNode addChild:rb z:1];
        id animation = [CCAnimation animation];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p26_lb_2"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p26_lb_1"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p26_lb_3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p26_lb_4"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p26_lb_3"]
                      delay:0.1];
        [animation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p26_lb_1"]
                      delay:0.1];
        
        id ani = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        id a = [CCRepeatForever actionWithAction:ani];
        id a11 = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(0,50)] rate:2] ;
        id a22 = [a11 reverse];
        id ass = [CCRepeatForever actionWithAction:[CCSequence actions:a11,a22, nil]];
        //[a setTag:101];
        [rb runAction:a];
        [rb runAction:ass];
        
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p26_body.plist"];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"p26_bg1"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);//for ipad
        [spritesBgNode addChild:bg z:-4];
        
        CCSprite *bg1 = [CCSprite spriteWithSpriteFrameName:@"p26_bg2"];
        bg1.position = ccp(565.9,105.5);//for ipad
        [spritesBgNode addChild:bg1 z:-2];
        
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(bg1.position.x/PTM_RATIO,bg1.position.y/PTM_RATIO );
        bodyDef.userData = bg1;
        b2Body *bg_body = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:bg_body forShapeName:@"p26_bg2"];
        [bg1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p26_bg2"]];
        
        CCSprite *fg = [CCSprite spriteWithSpriteFrameName:@"p26_fg"];
        fg.position = ccp(screenSize.width/2,fg.contentSize.height/2);
        [spritesBgNode addChild:fg z:0];
        
        
        
        
        CCSprite *arm = [CCSprite spriteWithSpriteFrameName:@"p26_arm"];
        arm.position = ccp(644.5,311.1);//for ipad
        //arm.anchorPoint = ccp(0.872,0.681);
        arm.rotation = -15;
        [spritesBgNode addChild:arm z:-1 tag:100];
        bodyDef.type = b2_kinematicBody;
        bodyDef.position.Set(arm.position.x/PTM_RATIO,arm.position.y/PTM_RATIO );
        bodyDef.userData = arm;
        bodyDef.angle = CC_DEGREES_TO_RADIANS(arm.rotation*-1);
        armBody = world->CreateBody(&bodyDef);
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:armBody forShapeName:@"p26_arm"];
        [arm setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p26_arm"]];
        
        
        
        id a1 = [CCRotateBy actionWithDuration:2 angle:30];
        id a2 = [a1 reverse];
        id as = [CCSequence actions:a1,a2, nil];
        id ar = [CCRepeatForever actionWithAction:as];
        [arm runAction:ar];
        
        //b2WeldJointDef wjd;        
        CCSprite *seed = [CCSprite spriteWithSpriteFrameName:@"p26_seed"];
        seed.position = ccp(16.4,8.3);//for ipad
        [arm addChild:seed z:-3 tag:100];

    }
	return self;
        

}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     [self loadSpriteSheet];
    CCSprite *arm = (CCSprite*)[spritesBgNode getChildByTag:100];
    CCSprite *seed = (CCSprite*)[arm getChildByTag:100];
    CGPoint pos =[seed convertToWorldSpace:seed.position];
   
    CCSprite *seed1 = [CCSprite spriteWithSpriteFrameName:@"p26_seed"];
    seed1.position = pos;//for ipad
    [spritesBgNode addChild:seed1 z:-3];
    [seed1 setOpacity:0];
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(seed1.position.x/PTM_RATIO,seed1.position.y/PTM_RATIO );
    bodyDef.userData = seed1;
    b2Body *seedBody = world->CreateBody(&bodyDef);
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:seedBody forShapeName:@"p26_seed"];
    [seed1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"p26_seed"]];
    
    
    id a1 = [CCFadeIn actionWithDuration:0.2];
    id a2 = [a1 reverse];
    id a3 = [CCCallBlock actionWithBlock:BCA(^(void){
        world->DestroyBody(seedBody);
        [spritesBgNode removeChild:seed1 cleanup:YES];
    })];
    [seed1 runAction:[CCSequence actions:a1,[CCDelayTime actionWithDuration:1],a2,a3, nil]];
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
	{
                CCSprite *myActor1 = (CCSprite*)armBody->GetUserData();
                b2Vec2 pos = b2Vec2(myActor1.position.x/PTM_RATIO,myActor1.position.y/PTM_RATIO);
                float angle = CC_DEGREES_TO_RADIANS( myActor1.rotation*-1);
                armBody->SetTransform(pos,angle);
    }
       
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
            if (b->GetType() == b2_kinematicBody) {
                
                break;
                
            }
            //Synchronize the AtlasSprites position and rotation with the corresponding body
            CCSprite *myActor = (CCSprite*)b->GetUserData();
            myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
            myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
			
			
		}	
	}
    
    std::vector<b2Body *>toDestroy; 
	std::vector<MyContact>::iterator pos;
	for(pos = _contactListener->_contacts.begin(); 
		pos != _contactListener->_contacts.end(); ++pos) {
		MyContact contact = *pos;
		NSString *fixtureIdA = (NSString*)(contact.fixtureA->GetUserData());
		NSString *fixtureIdB = (NSString*)(contact.fixtureB->GetUserData());
       // CCLOG(@"ida============%@",fixtureIdA);
        //CCLOG(@"ida============%@",fixtureIdB);
        //NSString* userDataA = (CCNode*)(bodyA->GetUserData());
		//CCNode* userDataB = (CCNode*)(bodyB->GetUserData());
        if (([fixtureIdA isEqualToString:@"2"] && [fixtureIdB isEqualToString:@"3"]) ||
            ([fixtureIdA isEqualToString:@"3"] && [fixtureIdB isEqualToString:@"2"])) {
            //[self nextCallback:self];
            [self seedInHole];
        }
    }
}
-(void)seedInHole
{
    [self unscheduleAllSelectors];
    CCSprite *arm = (CCSprite*)[spritesBgNode getChildByTag:100];
    [arm stopAllActions];
    self.isTouchEnabled = NO;
    //[self unscheduleAllSelectors];
    //加粒子效果
    emitter_ = [[CCParticleSystemQuad alloc]  initWithFile:[NSString stringWithFormat:@"27_waterFade.plist",sceneIdx]];
    batchNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:YES]; 
    //emitter_.position = rightPosition;
    emitter_.autoRemoveOnFinish = YES;
    emitter_.positionType =  kCCPositionTypeRelative;
    [batchNode_ addChild:emitter_];
    [self addChild:batchNode_ z:2];
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:6],[CCCallBlock actionWithBlock:BCA(^(void){
        [emitter_ stopSystem];
        Class layer = nextAction();
        CCScene *scene = [CCScene node];
        [scene addChild:[layer node]];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0  scene:scene withColor:ccc3(255, 255, 255)]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    })], nil]];
    
}
-(void)dealloc
{
    [super dealloc];
    delete _contactListener ;
    _contactListener = NULL;
     [[[CCDirector sharedDirector] openGLView] setMultipleTouchEnabled:YES];
}
@end


@implementation PageLayer27
-(void)onEnterTransitionDidFinish
{
    [self loadSpriteSheet];
    
    id a1 = [CCScaleTo actionWithDuration:0.2 scale:1.2];
    id a2 = [CCScaleTo actionWithDuration:0.2 scale:1.0];
    
    for (int i = 0 ; i < 3; i ++) {
        id as = [CCSequence actions:[CCDelayTime actionWithDuration:(i+1)*0.5],a1,a2,nil];
        id ar = [CCRepeatForever actionWithAction:as];
        CCSprite *wenhao = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p27_%d",i+1]];
        [spritesBgNode addChild:wenhao z:0];
        if (i==0) {
            wenhao.position = ccp(329,271.5);//for ipad
        }
        else if(i==1) {
            wenhao.position = ccp(519,299.5);//for ipad
        }
        else {
            wenhao.position = ccp(707.5,273.5);//for ipad
        }
        [wenhao runAction:ar];
    }
}
-(id)init
{
	if ((self = [super init])) {
        
        
	}
	return self;
}
-(void)nextCallback:(id) sender
{
	
	[self unscheduleAllSelectors];
	self.isAccelerometerEnabled = NO;
    sceneIdx = 0;
    
    
    CCScene *scene = [GameLayer scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:scene backwards:NO]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"page" ofType:@"wav"];
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
	AudioServicesPlaySystemSound (soundID);	
}
@end