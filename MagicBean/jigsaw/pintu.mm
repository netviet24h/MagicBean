//
//  pintu.mm
//  pintu
//
//  Created by ivan on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "pintu.h"
#define SIZE_WIDTH 768.0f
#define SIZE_HEIGHT 1024.0f

#define kTagBg 101
//extern CGPoint** jigsawModel;
CGPoint jigsawModel[][2] =
{
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(4,4),
		ccp(3,3),
	},
	{
		ccp(4,4),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
	{
		ccp(3,3),
		ccp(3,3),
	},
};
@implementation pintu
@synthesize jigsawArr;
@synthesize batch;
@synthesize emitter_;
@synthesize jigsawType;
+(id)scene:(int)_page
{
	
	CCScene *scene = [CCScene node];
	CCLayer *layer = [[[pintu alloc] initWithPage:_page type:1] autorelease];
	[scene addChild:layer];
	return scene;
}
-(id)initWithPage:(int)_page type:(int)tp
{
	if ((self = [super init])) {
        screenSize = [CCDirector sharedDirector].winSize;
        [[[CCDirector sharedDirector] openGLView] setMultipleTouchEnabled:NO];
		page_ = _page;
		model_ = jigsawModel[page_/2-10][0];
        jigsawType = tp;
		CCLOG(@"in Page %d model is %f,%f",page_,model_.x,model_.y);
		jigsawArr = [[NSMutableArray alloc] initWithCapacity:16] ;
		jigsawRandomArr = [[NSMutableArray alloc] initWithCapacity:16];
		batch = nil;
	
		//初始化ui（菜单）
		[self initMenu];
        if (jigsawType==1) {
            [self initJigSaw:_page];
            CCSprite *fp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"p%d_p.pvr.ccz",_page]];
            fp.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:fp z:10];
           
        }
        else if(jigsawType == 2) {
            [self initJigSaw:_page index:1];
        }
		
		//初始化棋盘与棋子
		
	}
	return self;
}
-(void)initMenu
{
	
}
-(void)initJigSaw:(int)_page
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	if (batch!=nil) {
		[batch removeAllChildrenWithCleanup:YES];
		[self removeChild:batch cleanup:YES];
	}	
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_bg.plist",_page]];
        batch = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"p%d_bg.pvr.ccz",_page] capacity:150];
        [self addChild:batch z:1 tag:100];
   		
	if( [jigsawArr count] > 0 )
	{
		for (JigsawData *data in jigsawArr) {
			[self removeChild:data cleanup:YES];
			[jigsawArr removeObject:data];
		}
	}
    for (int i = 0 ; i < model_.x; i ++) {
		for (int j = 0 ; j < model_.y; j ++) {
			
            CCSprite *_texture = nil;
            CCSprite *_mask = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"mask%d%d_1",(int)(model_.x),(int)(model_.y)]];
            
            _texture = [CCSprite spriteWithBatchNode:batch 
                                                rect:CGRectMake( screenSize.width / model_.x  * j, screenSize.height / model_.y * i,screenSize.width / model_.x,screenSize.height / model_.y)];
            
            [batch addChild:_texture z:0];
            
            
			//sprite.position = ccp(_wid * (idx+0.5) + _LeftUp.x,_hei * (-idy-0.5) + _LeftUp.y);
			
			jigsaw[i][j] = [[[JigsawData alloc] initWithTexture:_texture 
                                                          Mask:_mask 
                                                      rightPos:CGPointMake(screenSize.width / model_.x*(0.5f+j),screenSize.height -screenSize.height/model_.y*(0.5f+i))] autorelease];
            jigsaw[i][j].m_page = _page;
            jigsaw[i][j].m_model=model_;
			[jigsawArr addObject:jigsaw[i][j]];
			[jigsawRandomArr addObject:jigsaw[i][j]];
			[self addChild:jigsaw[i][j] z:1];
		}
	}
    
	[self schedule:@selector(randomPlaceChress) interval:2 ];
    
}
-(void)initJigSaw:(int)_page index:(int)_index
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	if (batch!=nil) {
		[batch removeAllChildrenWithCleanup:YES];
		[self removeChild:batch cleanup:YES];
	}
	index_ = _index;	
	if (index_ == 1) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_jigsaw_1.plist",_page]];
        batch = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"p%d_jigsaw_1.pvr.ccz",_page] capacity:150];
        [self addChild:batch z:1 tag:100];
    }
	else {   
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_jigsaw_bg.plist",_page]];
        batch = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"p%d_jigsaw_bg.pvr.ccz",_page] capacity:150];
        [self addChild:batch z:1 tag:100];
    }		
	if( [jigsawArr count] > 0 )
	{
		for (JigsawData *data in jigsawArr) {
			[self removeChild:data cleanup:YES];
			[jigsawArr removeObject:data];
		}
	}
    for (int i = 0 ; i < model_.x; i ++) {
		for (int j = 0 ; j < model_.y; j ++) {
			
            CCSprite *_texture = nil;
            CCSprite *_mask = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"mask%d%d",(int)(model_.x),(int)(model_.y)]];
            
            _texture = [CCSprite spriteWithBatchNode:batch 
                                                rect:CGRectMake( SIZE_WIDTH / model_.y  * j, SIZE_HEIGHT / model_.x * i,SIZE_WIDTH / model_.y,SIZE_HEIGHT / model_.x)];
              
            [batch addChild:_texture z:0];

           
			//sprite.position = ccp(_wid * (idx+0.5) + _LeftUp.x,_hei * (-idy-0.5) + _LeftUp.y);
			
			jigsaw[i][j] = [[JigsawData alloc] initWithTexture:_texture 
                                                           Mask:_mask 
                                                       rightPos:CGPointMake(SIZE_WIDTH /model_.x*(0.5f+j),SIZE_HEIGHT -SIZE_HEIGHT/model_.y*(0.5f+i))];
			[jigsawArr addObject:jigsaw[i][j]];
			[jigsawRandomArr addObject:jigsaw[i][j]];
			[self addChild:jigsaw[i][j] z:1];
		}
	}

	[self schedule:@selector(randomPlaceChress) interval:2 ];
    
}
-(void)randomPlaceChress
{
    [self unschedule:_cmd];
	if ([jigsawRandomArr count]==0) {
		self.isTouchEnabled = YES;
		//[jigsawRandomArr removeAllObjects];
		//[jigsawRandomArr release];
        [self schedule:@selector(randomDone) interval:0.8 ];
        return;
	}
	else {
		int a = [jigsawRandomArr count];
		int i  = [Common createRandomsizeValueInt:0 toInt:a-1];
		JigsawData *jig =  [jigsawRandomArr objectAtIndex:i];
		[jigsawRandomArr removeObject:jig];
		
		a = [jigsawRandomArr count];
		if (a==0) {
			self.isTouchEnabled = YES;
            [self schedule:@selector(randomDone) interval:0.8 ];
			return;
		}
		i  = [Common createRandomsizeValueInt:0 toInt:a-1];
		JigsawData *jig1 =  [jigsawRandomArr objectAtIndex:i];
		
		[jigsawRandomArr removeObject:jig1];
		[self changeJigsaw:jig two:jig1];
		[self schedule:@selector(randomPlaceChress) interval:0.1f ];
	}
}
-(void)randomDone
{
    CCLOG(@"randomDone");
    [self unschedule:_cmd];
    for (JigsawData *jig in jigsawArr) {
		[jig isRightWithJigsaw];
        //[((pintu*)(self.parent)).jigsawArr removeObject:self];
    }
}
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
 
    isMoving = NO;
	//UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	CCLOG(@"begin%f,%f",rightPosition.x,rightPosition.y);

    //[batchPartiNode_ removeAllChildrenWithCleanup:YES];
    //[self removeChild:batchPartiNode_ cleanup:YES];
    
    BOOL useAddBlend = NO;
    if (page_ == 26) {
        useAddBlend = YES;
    }
    emitter_ = [[[CCParticleSystemQuad alloc]  initWithFile:[NSString stringWithFormat:@"%d_waterFade.plist",page_]] autorelease];
    batchPartiNode_ = [CCParticleBatchNode particleBatchNodeWithTexture:emitter_.texture capacity:500 useQuad:YES additiveBlending:useAddBlend]; 
    emitter_.position = rightPosition;
    emitter_.autoRemoveOnFinish = YES;
    emitter_.positionType =  kCCPositionTypeRelative;
    [batchPartiNode_ addChild:emitter_];
    [self addChild:batchPartiNode_ z:2];
    
    /**
     ++++++tap method++++++
     */
    if (isSelected == YES) {//有选中棋子时处理
		for (JigsawData *jig in jigsawArr) {
			if ([jig isInBox:rightPosition]) {
				if (jig ==	selJigsaw) {//选择与前次相同，取消选中。
                    [batch reorderChild:jig.m_texture z:3];
                    //[self reorderChild:jig z:1];
                    [batch reorderBatch:YES];
                    [batch sortAllChildren];
					[selJigsaw cancelSelEffect];
					selJigsaw = nil;
					isSelected = NO;
					return YES;
				}
				//交换选中棋子与当前新棋子位置
                [jig selectedEffect];//目标棋子激活选中效果
                
                [emitter_ stopSystem];
				[self changeJigsaw:selJigsaw two:jig];//交换2棋子
				return YES;
			}
		}
	}
    
	for (JigsawData *jig in jigsawArr) {//初始碰撞
		if ([jig isInBox:rightPosition]) {
			if (selJigsaw!=nil) {
				[selJigsaw cancelSelEffect];
			}
			selJigsaw = jig;
			[selJigsaw selectedEffect];
            //[self reorderChild:selJigsaw z:100];
            [batch reorderChild:selJigsaw.m_texture z:100];
            [batch reorderBatch:YES];
            [batch sortAllChildren];
			isSelected = YES;
            //emitter_.blendAdditive = YES;  
			return YES;
		}
	}
    return YES;
}
- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
    isMoving = YES;
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    emitter_.position = rightPosition;
    
    for (JigsawData *jig in jigsawArr) {
        if ([jig isInBox:rightPosition]  ) {
            if (jig ==	selJigsaw) {//选择与前次相同，取消选中。
                for (JigsawData *jig1 in jigsawArr)
                {
                    if (jig1.m_isSelected) {
                        if (jig1!=selJigsaw) {
                            [jig1 cancelSelEffect];
                        }
                    }
                }
                break;
            }
            else {
                for (JigsawData *jig1 in jigsawArr)
                {
                    if (jig1.m_isSelected) {
                        if (jig1!=selJigsaw) {
                            [jig1 cancelSelEffect];
                        }
                    }
                }
                [jig selectedEffect];
                break;
                
            }
            
        }
    }
    
}
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
	CGPoint rightPosition = [touch locationInView:[touch view]];
	rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
	CCLOG(@"emitter_%f,%f",rightPosition.x,rightPosition.y);
    [emitter_ stopSystem];
    if (!isMoving) {
        
        return;
    }
    //[batchPartiNode_ removeAllChildrenWithCleanup:YES];
    if (isSelected == YES ) {//有选中棋子时处理
        
		for (JigsawData *jig in jigsawArr) {
			if ([jig isInBox:rightPosition]  ) {
				if (jig ==	selJigsaw) {//选择与前次相同，取消选中。
                    [batch reorderChild:jig.m_texture z:3];
                    //[self reorderChild:jig z:1];
                    [batch reorderBatch:YES];
                    [batch sortAllChildren];
					[selJigsaw cancelSelEffect];
					selJigsaw = nil;
					isSelected = NO;
					return;
				}
				//交换选中棋子与当前新棋子位置
				[self changeJigsaw:selJigsaw two:jig];
				break;
			}
		}
	}
}
- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{

    [self ccTouchEnded:touch withEvent:event];
}
-(void)passSceneAnimation
{
    
    //NSArray *storeFilePathMoney = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *doucumentsDirectiory = [storeFilePathMoney objectAtIndex:0];
    //NSString *jigsawPath = [doucumentsDirectiory stringByAppendingPathComponent:@"jigsawData-ipad.plist"];
    NSString *jigsawPath =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"jigsawData-ipad.plist"];    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:jigsawPath];
    NSDictionary *dic2 =  [dic objectForKey:[NSString stringWithFormat:@"p%d",page_]];
     
    float rate = [[dic2 objectForKey:@"rate"] floatValue];
    
    float posX = [[dic2 objectForKey:@"posx"] floatValue];
    
    float posY = [[dic2 objectForKey:@"posy"] floatValue];
    
    //NSMutableArray *jigsawArray = [NSMutableArray arrayWithContentsOfFile:jigsawPath];
    
    
    
    //-- PIC1 完成action--
    self.isTouchEnabled = NO;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"p%d_jigsaw_bg.plist",page_]];
    CCSprite *mask = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"p%d_jigsaw_bg",page_]];
    [self addChild:mask z:0];
    mask.position = ccp(384,512);
    mask.opacity = 0;
    [mask runAction:[CCFadeIn actionWithDuration:2]];
    id block = [CCCallBlock actionWithBlock:BCA(^(void){
        model_ = jigsawModel[page_/2-1][1];
        [self initJigSaw:page_ index:2]; 
        [self removeChild:mask cleanup:YES];
    })];
   
    id aScale = [CCScaleTo actionWithDuration:2 scale:rate];
    id aMove = [CCMoveTo actionWithDuration:2 position:ccp(posX,1024-posY)];
    id a0 = [CCSpawn actionOne:aScale two:aMove];
    id a1 = [CCEaseOut  actionWithAction:a0 rate:1];
    id as = [CCSequence actions:a1,[CCDelayTime actionWithDuration:0.1],block, nil];
    [batch runAction:as];
}
-(void)changeJigsaw:(JigsawData *)jig1 two:(JigsawData *)jig2
{
	CCLOG(@"change");
	[jig1 moveTo:jig2.m_curPos];
	[jig2 moveTo:jig1.m_curPos];
	self.isTouchEnabled = NO;
}
-(void)changeDone
{
	//[self unschedule:_cmd];
	self.isTouchEnabled = YES;
	selJigsaw = nil;
	isSelected = NO;
	//判断是否完成，处理
   
	if ([self isAllRight] ) {
        isAllRight = YES;
        self.isTouchEnabled = NO;
        CCLOG(@"======================isAllRight=================");
        if (jigsawType == 1 ) {
            //if (page_ == 26) {
                //[self.parent removeChild:self cleanup:YES];
                [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.8  scene:[NSClassFromString([NSString stringWithFormat:@"PageLayer%d",page_]) scene_other] withColor:ccc3(255, 255, 255)]];
                [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
                [[CCTextureCache sharedTextureCache] removeUnusedTextures];
            //}
            return;
            //do something
        }
		if (index_==2) {//is all done
			//do something
			return;
		}        
        [self passSceneAnimation];
    }	
}
-(BOOL)isAllRight
{
	for (JigsawData *jig in jigsawArr) {
        if(jig.m_isRight == NO)
            return NO;
    }
	return YES;
}
-(void)dealloc
{
    [jigsawRandomArr removeAllObjects];
    [jigsawRandomArr release];
    
    [jigsawArr removeAllObjects];
    [jigsawArr release];
    //[emitter_ release];
	[super dealloc];
}
@end
