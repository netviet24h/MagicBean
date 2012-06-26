//
//  JigsawData.h
//  pintu
//
//  Created by ivan on 11-8-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface JigsawData : CCSprite{
	CCSprite *m_texture;
	CCSprite *m_mask;
	CGPoint m_rightPos;
	CGPoint m_curPos;
	BOOL	m_isRight;
	int m_rightIndex;
    CCParticleSystem	*emitter_;
    CCParticleBatchNode* m_batchNode;
    int m_page;
    CGPoint m_model;
    BOOL m_isSelected;
}
@property (nonatomic,assign) BOOL m_isSelected;
@property (retain,nonatomic) CCSprite* m_mask;
@property (retain,nonatomic) CCSprite* m_texture;
@property (nonatomic,assign) BOOL m_isRight;
@property (nonatomic,assign) CGPoint m_model;
@property (nonatomic,assign) CGPoint m_curPos;
@property (nonatomic,assign) CGPoint m_rightPos;
@property (nonatomic,assign) int m_rightIndex;
@property (nonatomic,assign) int m_page;
-(id)initWithTexture:(CCSprite *)_texture Mask:(CCSprite *)_mask rightPos:(CGPoint )_rightPos;
-(void)moveTo:(CGPoint)des;
-(void)moveDone;

-(void)complete;
-(void)removeMask;
-(BOOL)isInBox:(CGPoint)p;
-(void)selectedEffect;
-(void)cancelSelEffect;
- (BOOL) isRightWithJigsaw;
-(void)dealloc;
@end
