//
//  pintu.h
//  pintu
//
//  Created by ivan on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ReadScene.h"
#import "JigsawData.h"
@class CCParticleBatchNode; 
@class PageCommon;

@interface pintu : CCLayer {
	JigsawData *jigsaw[100][100];
	NSMutableArray *jigsawArr;
    NSMutableArray *jigsawArr2;
	NSMutableArray *jigsawRandomArr;
	JigsawData *selJigsaw;
    JigsawData *selJigsaw2;
	BOOL isSelected;
	CCSpriteBatchNode *batch;
	CGPoint model_;
	int page_;
	int index_;
	CCSpriteBatchNode *batch2;
    CCParticleSystem	*emitter_;
    CCParticleBatchNode* batchPartiNode_;
    int jigsawType;
    CGSize screenSize;
    BOOL isAllRight;
    BOOL isMoving;
}
@property (nonatomic,assign) int page_;
@property (nonatomic,assign) int jigsawType;
@property (nonatomic,retain) NSMutableArray *jigsawArr;
@property (nonatomic,retain) CCSpriteBatchNode *batch;
@property (nonatomic,retain) CCParticleSystem *emitter_;
-(void)initMenu;
-(void)initJigSaw:(int)_page index:(int)_index;
-(id)initWithPage:(int)_page type:(int)tp;
+(id)scene:(int)_page;
-(void)changeJigsaw:(JigsawData *)jig1 two:(JigsawData *)jig2;
-(void)changeDone;
-(void)randomPlaceChress;
-(void)randomDone;
-(BOOL)isAllRight;
@end
