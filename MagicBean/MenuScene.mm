//
//  MenuScene.mm
//  eBookTest
//
//  Created by ivan on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "AppSpecificValues.h"
extern NSString *language;
@implementation MenuScene
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuScene *layer = [MenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController 

{
	
	[gameCenterView dismissModalViewControllerAnimated:YES];
	
	[gameCenterView release];
	
}

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuMohu_375.479.png"]] autorelease]; 
    imageView.center = ccp(375,479);
    [[[CCDirector sharedDirector] openGLView] addSubview:imageView];
	imageView.userInteractionEnabled = YES; 
    self.isTouchEnabled = YES;
}

-(void)onEnter
{
	[super onEnter];
//	if (soundFlag) {
////		//[[GlassPrinceAppDelegate getMenuBg] setCurrentTime:0];
////		[[GlassPrinceAppDelegate getMenuBg] play];
////		[[GlassPrinceAppDelegate getBgMusic] stop];
////		[[GlassPrinceAppDelegate getGameBg] stop];
////		[[GlassPrinceAppDelegate getHaibaoBg] stop];
//	}
}
-(id) init
{

	if( (self=[super init] )) {
		
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"menu.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"aniGuang.plist"];
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"menu.pvr.ccz"];
     
        
		CCSprite *bg = [CCSprite spriteWithFile:@"menuBg.pvr.ccz"];
		bg.position =  ccp( screenSize.width /2 , screenSize.height/2 );
		// add the label as a child to this Layer
		[self addChild:bg z:0];
        
        CCSprite *sprGuang = [CCSprite spriteWithSpriteFrameName:@"menuGuang_1"];	
		id _ani_guang = [CCAnimation animation];
		for (int i =1; i< 4; i++) {
			[_ani_guang addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuGuang_%d",i]]];
		}
		id _action =[CCAnimate  actionWithDuration:1 animation:_ani_guang restoreOriginalFrame:NO];
		[sprGuang runAction:[CCRepeatForever actionWithAction:_action]];
		sprGuang.anchorPoint = CGPointZero;
		[self addChild:sprGuang z:1 tag:88];
                
        id as1 = [CCEaseIn actionWithAction:[CCScaleTo actionWithDuration:0.5 scale:1.1] rate:2.0f];
        id as1r = [CCEaseOut actionWithAction:[CCScaleTo actionWithDuration:0.5 scale:1.0] rate:2.0f];
      //id as2 = [CCEaseOut actionWithAction:[CCScaleTo actionWithDuration:0.5 scale:0.9] rate:2.0f];
      //id as2r = [as2 reverse];
        id as = [CCSequence actions:as1,as1r, nil];
        id ac = [CCRepeatForever actionWithAction:as];
                
        read = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menuRead_380.867"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menuRead_380.867"] block:BCA(^(void){
            [[CCDirector sharedDirector] replaceScene: [CCTransitionFade  transitionWithDuration:1.0 scene:[readScene scene] withColor:ccc3(0, 0, 0)]];
			UIView *openGLView = [[CCDirector sharedDirector] openGLView] ;
			for (UIView *view in [openGLView subviews]) 
				[view removeFromSuperview];
        })];        
		[read runAction:ac];
        game = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menuGame_197.868"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menuGame_197.868"] block:BCA(^(void){
            
        })]; 
        more = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menuMore_566.868"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menuMore_566.868"] block:BCA(^(void){
        })]; 
        twitter = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menuTwrite_716.984"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menuTwrite_716.984"] block:BCA(^(void){
           // [[CCDirector sharedDirector] replaceScene:[readScene scene]];
        })];        
        facebook = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menuFacebook_631.984"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menuFacebook_631.984"] block:BCA(^(void){
            
            
        })]; 
        bibobox = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menuBibobox_99.992"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menuBibobox_99.992"] block:BCA(^(void){
        })]; 
        
        CCMenu *mainMenu = [CCMenu menuWithItems:read,game,more,twitter,facebook,bibobox,nil];
        read.position = ccp(380,1024-867);
        game.position = ccp(197,1024-868);
        more.position = ccp(566,1024-868);
        twitter.position = ccp(716,1024-984);
        facebook.position = ccp(631,1024-984);
        bibobox.position = ccp(99,1024-992);
        //[mainMenu alignItemsHorizontallyWithPadding:20];
         mainMenu.position = CGPointZero;
        [self addChild:mainMenu z:1];
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{ 
    //CCLOG(@"length%f",length);(@"===="); 
	UITouch *touch = [touches anyObject]; 
	CGPoint currentPoint = [touch locationInView:[touch view]]; 
	if ([touch view] == imageView) { 
		//CCLOG(@"length%f",length);(@"====");
		canEarse = YES; 
	} 	
} 
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
	for (UITouch *touch in [event allTouches]) {
		if(canEarse) 
		{ 
			CGPoint currentPoint = [touch locationInView:imageView]; 
            //CCLOG(@"length%f",length);(@"pos x:%f,y:%f",currentPoint.x,currentPoint.y); 
			UIGraphicsBeginImageContext(imageView.frame.size); 
			[imageView.image drawInRect:imageView.bounds]; 
			CGRect cirleRect = CGRectMake(currentPoint.x-75, currentPoint.y-75, 150, 150);  
			CGContextRef context = UIGraphicsGetCurrentContext(); 
			CGContextAddArc(context, currentPoint.x, currentPoint.y, 75, 0.0, 2*M_PI, 0); 
			CGContextClip(context);  
			CGContextClearRect(context,cirleRect); 
			imageView.image = UIGraphicsGetImageFromCurrentImageContext();  
			UIGraphicsEndImageContext();
		} 
	}
	
} 
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	canEarse = NO; 
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
