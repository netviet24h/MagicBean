//
//  ReadScene.h
//  GlassPrince
//
//  Created by Ivan on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ccMacros.h"
#import "common.h"
#import <AvFoundation/AVAudioRecorder.h>
#import "pintu.h"
#import "SCListener.h"
@class pintu;
@class CCParticleBatchNode; 
extern NSString *language;
extern CGSize screenSize;
#define MaxPage 27

@interface readScene : CCLayerColor
{
}
+(id) scene;
@end

@interface PageCommon : CCLayerColor
{
    BOOL isJigsaw;
    b2Body *groundBody;
	CCScene *preScene;
	CCScene *nextScene;
	CCScene *preScene1;
	CCScene *nextScene1;
	NSArray *imageArr;
	b2World* world;					// strong ref
	b2Vec2 m_mouseWorld;
	b2MouseJoint* m_mouseJoint;
	GLESDebugDraw *m_debugDraw;		// strong ref
    b2Fixture *groundTop;
    b2Fixture *groundBottom;
    b2Fixture *groundLeft;
    b2Fixture *groundRight;
	CCSpriteBatchNode *spritesBgNode;
  	//CGSize screenSize;
	CCParticleSystem	*emitter_;
    BOOL    useBox2d;
    CCParticleBatchNode* batchNode_;
    CCLabelTTF *label;
}
@property (retain,nonatomic) CCSpriteBatchNode *spritesBgNode;
-(void)addSpriteName:(NSString*)_name position:(CGPoint)_pos ToBgNode:(void*)_node;
-(void)addSpriteName:(NSString*)_name position:(CGPoint)_pos z:(int)_z;
-(BOOL)isInBox:(CGPoint)p sprite:(CCSprite*)m_texture;
-(void) initMenu;
-(void)loadSpriteSheet;
-(void) nextCallback:(id) sender;
-(void) backCallback:(id) sender;
-(void) menuCallback:(id) sender;
-(void) loadNextScene;
+(id) scene;
+(id)scene_other;
-(id)initOther;
-(void) dealloc;
@end


@class Emitter;
@class CCParticleBatchNode; 
@interface PageLayer1 : PageCommon<AVAudioRecorderDelegate> {
	b2RopeJointDef m_ropeDef;
	b2Joint* m_rope;
	CCSpriteBatchNode* ropeSpriteSheet; //sprite sheet for rope segment
	NSMutableArray* vRopes; //array to hold rope references

    NSMutableDictionary *recordSetting;
    NSMutableArray *files;
    NSString* recorderFilePath;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSData *audioData;
    NSData *m_data;
    
    CCSprite *cloud[5];
	CGPoint vel;
}
@end

@interface PageLayer2 : PageCommon {
	BOOL canMove;
	CGPoint prePoint;
    float speed_;
}
@end
@interface PageLayer3 : PageCommon {
    int m_seedCount;
    int m_seedMax;
    Byte m_seedTotle;
    BOOL isFire;
    
}
-(void)fallSeed;
@end

@interface ButtleFly : CCSprite			//敌方c —— 转向
{
    CCSprite    *texture;//导弹精灵
    CGPoint		src;					//初始地
    float       initRota;
	float		speed;					//移动速度
	float		speedTmp;				//速度临时变量
	BOOL		isDestoryed;			//是否被摧毁
	ccVertex2F	vel;
}
-(id)initWithSpriteFrame:(CCSpriteFrame *)spriteFrame point:(CGPoint)p;
-(void)setRota:(ccTime)dt;
-(void) movesMissile:(ccTime)dt;
@end

@interface PageLayer4 : PageCommon {
    BOOL isRunTv;
	 BOOL canTouch;
}
@end

@interface PageLayer6 : PageCommon {
    
	
}
@end
@interface PageLayer8 : PageCommon {
    BOOL canTouchSeed;
    BOOL isSeed;
    int lCount;
    b2Body *treeBody;
	BOOL canTouch;

}
@end
@interface PageLayer10 : PageCommon {
    BOOL canMs;
	
}
@end
@interface PageLayer12 : PageCommon {
    
	
}
@end
@interface PageLayer14 : PageCommon {
    
	 BOOL canTouch;
}
@end
@interface PageLayer16 : PageCommon {
    BOOL canMove;
    CGPoint firstPos;
}
@end
typedef struct  
{
    CGPoint bl;
    CGPoint br;
    CGPoint tl;
    CGPoint tr;
}My4V;

@interface MySprite : CCSprite

@end
@interface PageLayer18 : PageCommon {
    CCSprite *animal[9];
    CCSprite *animalTz[9];
	CGPoint pos[9];
	
}
@end


@interface PageLayer5 : PageCommon {
    NSMutableArray *breBallArr;
}
-(void)removeButterfly;
@end
@interface PageLayer7 : PageCommon
{
    float m_time;
}
-(void) addGlassesBody;
@end



@interface PageLayer9 : PageCommon
{

    int m_glassCount;
    int m_glassMax;
    BOOL isFire;
    MyContactListener *_contactListener;
    BOOL isScaleDone;
}
-(void)fireItems;
@end

@interface PageLayer11 : PageCommon
{

    int m_glassCount;
    int m_glassMax;
    BOOL isFire;
    CGPoint pArr[60];
    MyContactListener *_contactListener;
}

@end

@interface PageLayer13 : PageCommon
{
   BOOL isScaleDone;
}

@end
@interface PageLayer15 : PageCommon
{
   
}

@end
@interface PageLayer17 : PageCommon
{
     NSMutableArray *array;
     CCSprite *ani[4];
    CGPoint pos[4];
    BOOL isTouch[4];
}
@end
@interface PageLayer19  : PageCommon
{
    
}
@end
@interface PageLayer20  : PageCommon
{
    
}
@end
@interface PageLayer21 : PageCommon
{
    
}
@end
@interface PageLayer22 : PageCommon 
{
    
	
}
@end
@interface PageLayer23 : PageCommon
{
    BOOL isCanTouch;
}
@end
@interface PageLayer24 : PageCommon
{
    
}
@end
@interface PageLayer25 : PageCommon
{
    
}
@end
@interface PageLayer26 : PageCommon
{
    b2WeldJoint *wJoint;
    b2Body *armBody;
    MyContactListener *_contactListener;
}

@end
@interface PageLayer27 : PageCommon
{
    
}
@end
