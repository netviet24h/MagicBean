//
//  StoryLayer.m
//  StoryLayer
//
//  Created by ice on 12-7-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoryLayer.h"


@implementation StoryLayer
@synthesize Finished=_finished;
@synthesize PicName;
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	StoryLayer *layer = [[[StoryLayer alloc] initWithName:@"p1_story" totallNum:3] autorelease];
	//StoryLayer *layer = [StoryLayer node];
	[scene addChild: layer];
	return scene;
}
-(void)initBox2d
{
    //useBox2d = YES;
	CCLOG(@"initBox2d");
	b2Vec2 gravity;
	gravity.Set(0.0f, -300);
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
	
	groundBox.Set(b2Vec2(0,0-100), b2Vec2(screenSize.width/PTM_RATIO,0-100));
	groundBottom = groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,(screenSize.height+645)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,(screenSize.height+645)/PTM_RATIO));
    groundTop = groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0-100,(screenSize.height+645)/PTM_RATIO), b2Vec2(0-100,0));
	groundLeft = groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(screenSize.width/PTM_RATIO+100,(screenSize.height+645)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO+100,0));
	groundRight = groundBody->CreateFixture(&groundBox,0);
	
//    // top
//	groundBox.Set(b2Vec2(0,(screenSize.height)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,(screenSize.height)/PTM_RATIO));
//    groundTop = groundBody->CreateFixture(&groundBox,0);
//	
//	// left
//	groundBox.Set(b2Vec2(0,(screenSize.height)/PTM_RATIO), b2Vec2(0,0));
//	groundLeft = groundBody->CreateFixture(&groundBox,0);
//	
//	// right
//	groundBox.Set(b2Vec2(screenSize.width/PTM_RATIO,(screenSize.height)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
//	groundRight = groundBody->CreateFixture(&groundBox,0);

	
	[self schedule:@selector(tick:)];
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
            //b->SetTransform(pos,angle);
		}	
	}
}
-(void)AddPicturs
{
    //CCSprite *newPic=[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@-%d",picName,i]];
    currentNum++;
    if (currentNum<=totallNum) {
        CGSize wSize = [[CCDirector sharedDirector] winSize];
        CCSprite *sp=[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_story_%d.png",PicName,currentNum]];
        sp.opacity = 0;
        [sp runAction:[CCFadeIn actionWithDuration:0.5]];
        sp.anchorPoint=ccp(0.5,0.5);
        sp.position=ccp(wSize.width/2,wSize.height/2);
        [self addChild:sp z:1 tag:currentNum];
        //[self performSelector:@selector(PicIn:) withObject:sp afterDelay:3.0f];
       // b2BodyDef bdf;
        // [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"p3_body.plist"];
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(sp.position.x/PTM_RATIO, sp.position.y/PTM_RATIO);
        bodyDef.userData = sp;	
        
        pictureBody= world->CreateBody(&bodyDef);
        b2PolygonShape shape;
        shape.SetAsBox(sp.contentSize.width/2/PTM_RATIO,sp.contentSize.height/2/PTM_RATIO);
        
        b2FixtureDef fixtureDef;
        fixtureDef.isSensor = false;
        fixtureDef.shape = &shape;
        fixtureDef.density = 0.3;
        fixtureDef.friction = 0.1;
        fixtureDef.restitution =  1;
        pictureBody->CreateFixture(&fixtureDef);
        
        
            
        {
            CCSprite *xian = [CCSprite spriteWithFile:@"p1_story_xian.png"];    
            xian.opacity = 0;
            [xian runAction:[CCFadeIn actionWithDuration:0.1]];
            xian.position = ccp(179,640);
           // xian.position = ccp(512,620);
            xian.anchorPoint = ccp(0.5,0);
            [self addChild:xian z:0];
            bodyDef.type = b2_dynamicBody;
            
            bodyDef.position.Set(xian.position.x/PTM_RATIO, xian.position.y/PTM_RATIO);
            bodyDef.userData = xian;
            
            bodyxian1 = world->CreateBody(&bodyDef);
            b2PolygonShape shapexian;
            shapexian.SetAsBox(xian.contentSize.width/2/PTM_RATIO,xian.contentSize.height/2/PTM_RATIO);
            fixtureDef.isSensor = true;
            fixtureDef.shape = &shape;
            fixtureDef.density = 0.0;
            fixtureDef.friction = 0.1;
            fixtureDef.restitution =  1;
            bodyxian1->CreateFixture(&fixtureDef);
            
            b2RevoluteJointDef rjd;
            rjd.Initialize(bodyxian1, pictureBody, bodyxian1->GetPosition());
            rjd.motorSpeed = 0;//1.0f * b2_pi;
            rjd.maxMotorTorque = 0;
            rjd.enableMotor = NO;
            rjd.lowerAngle = -1/15.0f * b2_pi;
            rjd.upperAngle = 1/15.0f * b2_pi;
            rjd.enableLimit = false;
            rjd.collideConnected = false;
            revJoint1 = world->CreateJoint(&rjd);
            
            b2DistanceJointDef djd;
            djd.Initialize(bodyxian1, groundBody,b2Vec2(bodyxian1->GetPosition().x,(bodyxian1->GetPosition().y+793)/PTM_RATIO), b2Vec2(bodyxian1->GetPosition().x,(bodyxian1->GetPosition().y+793)/PTM_RATIO));
            //djd.Initialize(bodyxian, groundBody,b2Vec2(bodyxian->GetPosition().x,screenSize.height/PTM_RATIO), b2Vec2(bodyxian->GetPosition().x,screenSize.height/PTM_RATIO));
            djd.dampingRatio = 1.0;
            djd.frequencyHz = 10;
            djd.length = 0.2;
            djd.collideConnected = false;
            world->CreateJoint(&djd);

        }        
        
        {
            CCSprite *xian = [CCSprite spriteWithFile:@"p1_story_xian.png"];
            xian.opacity = 0;
            [xian runAction:[CCFadeIn actionWithDuration:0.1]];
            
            xian.position = ccp(843,640);
            xian.anchorPoint = ccp(0.5,0);
            [self addChild:xian z:0];
            bodyDef.type = b2_dynamicBody;
            
            bodyDef.position.Set(xian.position.x/PTM_RATIO, xian.position.y/PTM_RATIO);
            bodyDef.userData = xian;
            
            bodyxian2 = world->CreateBody(&bodyDef);
            b2PolygonShape shapexian;
            shapexian.SetAsBox(xian.contentSize.width/2/PTM_RATIO,xian.contentSize.height/2/PTM_RATIO);
            fixtureDef.isSensor = true;
            fixtureDef.shape = &shape;
            fixtureDef.density = 0.0;
            fixtureDef.friction = 0.1;
            fixtureDef.restitution =  1;
            bodyxian2->CreateFixture(&fixtureDef);
            
            
            b2RevoluteJointDef rjd;
            rjd.Initialize(bodyxian2, pictureBody, bodyxian2->GetPosition());
            rjd.motorSpeed = 0;//1.0f * b2_pi;
            rjd.maxMotorTorque = 0;
            rjd.enableMotor = NO;
            rjd.lowerAngle = -1/15.0f * b2_pi;
            rjd.upperAngle = 1/15.0f * b2_pi;
            rjd.enableLimit = false;
            rjd.collideConnected = false;
            revJoint2 = world->CreateJoint(&rjd);
            
            b2DistanceJointDef djd;
            djd.Initialize(bodyxian2, groundBody,b2Vec2(bodyxian2->GetPosition().x,(bodyxian2->GetPosition().y+793)/PTM_RATIO), b2Vec2(bodyxian2->GetPosition().x,(bodyxian2->GetPosition().y+793)/PTM_RATIO));
            //djd.Initialize(bodyxian, groundBody,b2Vec2(bodyxian->GetPosition().x,screenSize.height/PTM_RATIO), b2Vec2(bodyxian->GetPosition().x,screenSize.height/PTM_RATIO));
            djd.dampingRatio = 1.0;
            djd.frequencyHz = 10;
            djd.length = 0.2;
            djd.collideConnected = false;
            world->CreateJoint(&djd);
            
        }
        pictureBody->SetTransform(b2Vec2(pictureBody->GetPosition().x,pictureBody->GetPosition().y+5), pictureBody->GetAngle());
    }
    else {
        [self isFinished]; //[self performSelector:@selector(isFinished) withObject:nil afterDelay:0.0f];
    }
}
-(void)nextPicture
{
    
    [self unschedule:_cmd];
   
    [self removeChild:(CCSprite*)(pictureBody->GetUserData())  cleanup:YES];
    world->DestroyBody(pictureBody);
  
    [self AddPicturs];
}
 
-(void)cutJoint
{
    [self unschedule:_cmd];
    world->DestroyJoint(revJoint1);
    world->DestroyJoint(revJoint2);
    [(CCSprite*)pictureBody->GetUserData() runAction:[CCFadeOut actionWithDuration:1.5]];
    [self removeChild:(CCSprite*)bodyxian1->GetUserData()  cleanup:YES];
    [self removeChild:(CCSprite*)bodyxian2->GetUserData()  cleanup:YES];
    world->DestroyBody(bodyxian1);
    world->DestroyBody(bodyxian2);
//    [(CCSprite*)bodyxian1->GetUserData() runAction:[CCFadeOut actionWithDuration:1.5]];
//    [(CCSprite*)bodyxian2->GetUserData() runAction:[CCFadeOut actionWithDuration:1.5]];
    [self schedule:@selector(nextPicture) interval:0.3];
}
-(void)isFinished
{
    _finished=YES;
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1], [CCCallBlock actionWithBlock:BCA(^(void){
        [self.parent removeChild:self cleanup:YES];
    })],nil]];
    CCLOG(@"FINISHED!!");
}

-(id)initWithName:(NSString *)picname   totallNum:(int)to_num
{
    if((self=[super init]))
    {
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
        self.isAccelerometerEnabled = YES;
        currentNum=0;
        totallNum=to_num;
        PicName = picname;
        _finished=NO;
        couldTouch=NO;
        [self initBox2d];
        [self AddPicturs];
        
//        CCSprite *touchButton = [CCSprite spriteWithFile:@"Icon.png"];
//        touchButton.position = ccp(screenSize.width/2,touchButton.contentSize.height/2);
//        [self addChild:touchButton z: 2 tag:11111];
        
        CCSprite *bg = [CCSprite spriteWithFile:@"hei.png"];
        bg.position  = ccp(screenSize.width/2,screenSize.height/2);
        [self addChild:bg z: -1 ];
        
        //[self initOther];
    }
    self.isTouchEnabled=YES;
    return self;
}

/*regist box2d touch method*/
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
		md.maxForce = 10000.0f*m_mouseBody->GetMass();
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		m_mouseBody->SetAwake(true);
	}
	
}
//- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
//{	
//	static float prevX=0, prevY=0;
//	
//	//#define kFilterFactor 0.05f
//#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
//	
//	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
//	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
//	
//	prevX = accelX;
//	prevY = accelY;
//	
//	// accelerometer values are in "Portrait" mode. Change them to Landscape left
//	// multiply the gravity by 10
//	b2Vec2 gravity( -accelY * 40, accelY * 40);
//	
//	world->SetGravity( gravity );
//}
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
		[self cutJoint];
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
	}
	
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
	for( UITouch *touch in touches ) {
    }
}


-(void)dealloc
{
    [super dealloc];
    [PicName release];
}

@end
