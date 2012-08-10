//
//  StoryLayer.h
//  StoryLayer
//
//  Created by ice on 12-7-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "common.h"

@interface StoryLayer : CCLayer {
    int currentNum;
    int totallNum;
    BOOL _finished;
    BOOL couldTouch;
    NSString *PicName;
    //CCSpriteBatchNode *spriteBatch;
    b2Body *groundBody;
    b2World* world;	
    b2Vec2 m_mouseWorld;
    b2MouseJoint* m_mouseJoint;
    GLESDebugDraw *m_debugDraw;
    b2Fixture *groundTop;
    b2Fixture *groundBottom;
    b2Fixture *groundLeft;
    b2Fixture *groundRight;
    b2Joint *revJoint1;
    b2Joint *revJoint2;
    b2Body *pictureBody;
    b2Body *bodyxian1;
    b2Body *bodyxian2;
}
@property (assign,nonatomic) BOOL Finished;
@property (copy,nonatomic) NSString *PicName;
+(CCScene *) scene;
-(void)initBox2d;
-(id)initWithName:(NSString *)picname   totallNum:(int)to_num;
@end
