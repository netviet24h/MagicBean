//
//  JigsawData.mm
//  pintu
//
//  Created by ivan on 11-8-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JigsawData.h"
#import "pintu.h"

@implementation JigsawData
@synthesize m_isRight;
@synthesize m_curPos;
@synthesize m_rightPos;
@synthesize m_rightIndex;
@synthesize m_texture;
@synthesize m_mask;
@synthesize m_page;
@synthesize m_model;
@synthesize m_isSelected;
-(id)initWithTexture:(CCSprite *)_texture Mask:(CCSprite *)_mask rightPos:(CGPoint)_rightPos
{
	if ( (self = [super init]) ) {
		m_texture = _texture;
		m_mask = _mask;
		m_rightPos = _rightPos;
		m_curPos = _rightPos;
		m_isRight = NO;
        [m_texture addChild:m_mask z:3];
        //[((pintu*)(self.parent)).batch addChild:m_texture z:0];
        m_mask.position = ccp(m_mask.contentSize.width/2,m_mask.contentSize.height/2);//ccp(m_texture.contentSize.width/2,m_texture.contentSize.height/2); 
        m_mask.opacity = 0;
		m_texture.position =CGPointZero;
		self.position = m_rightPos;
		m_texture.position = m_rightPos;
	}
	return self;
}
-(void)moveTo:(CGPoint)des
{
	//id action = [CCEaseBounceIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:des]];
	id action = [CCEaseElasticInOut  actionWithAction:[CCMoveTo actionWithDuration:0.5 position:des] period:10 ];
	id s = [CCSequence actionOne:action two:[CCCallFunc actionWithTarget:self selector:@selector(moveDone)]];
	[m_texture runAction:s];
	[self runAction:action];
	//[action release];
}
-(BOOL)isInBox:(CGPoint)p
{
	if (p.x >  m_texture.position.x-m_texture.contentSize.width/2 && p.x < m_texture.position.x+m_texture.contentSize.width/2 
		&& p.y > m_texture.position.y-m_texture.contentSize.height/2-2 && p.y < m_texture.position.y+m_texture.contentSize.height/2) {
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
-(void)moveDone
{
	m_curPos = m_texture.position;
    [self cancelSelEffect];
	[self isRightWithJigsaw];	
    [(pintu*)(self.parent) changeDone];
    CCLOG(@"curpos=%f,%f;rightpos=%f,%f",m_curPos.x,m_curPos.y,m_rightPos.x,m_rightPos.y);
}
-(BOOL)isRightWithJigsaw
{
	if (  ((int)(m_curPos.x) == (int)(m_rightPos.x)) && ((int)(m_curPos.y) == (int)(m_rightPos.y))) {
		//[self removeMask];
        //[self schedule:@selector(done) interval:0.1];
        m_isRight = YES;
	}
	else {
        m_isRight = NO;
	}
    return m_isRight;
}
-(void)selectedEffect
{
	//m_texture.scale = 1.1f;
	//m_mask.scale = 1.1f;
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_bg.plist",m_page]];
    //[m_mask setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"mask%d%d_2",(int)(m_model.x),(int)(m_model.y)]]];
    m_isSelected = YES;
    m_mask.opacity = 255;
    //[m_mask runAction:[CCFadeIn actionWithDuration:0.1]];
}
-(void)cancelSelEffect
{
	//m_texture.scale = 1.0f;
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_bg.plist",m_page]];
    m_mask.opacity = 0;
    //[m_mask runAction:[CCFadeOut actionWithDuration:0.1]];
	//[m_mask setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"mask%d%d_1",(int)(m_model.x),(int)(m_model.y)]]];
    m_isSelected = NO;
}
-(void)complete
{
}
-(void)removeMask
{
    
	//id a1 = [CCBlink actionWithDuration:0.5 blinks:2 ];
    //[m_texture removeChild:m_mask cleanup:YES];
    [((pintu*)self.parent) changeDone];
   //[((pintu*)self.parent).jigsawArr removeObject:self];
	m_isRight = YES;
}
-(void)dealloc
{
	[super dealloc];
	//[self removeChild:m_mask cleanup:YES];
	
}
@end
