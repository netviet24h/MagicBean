//
//  MaskBarSprite.m
//  ZhongziMulu
//
//  Created by ice on 12-8-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MaskBarSprite.h"


@implementation MaskBarSprite

//-(void)registerWithTouchDispatcher
//{
//    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//}

-(void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuMousePriority swallowsTouches:YES];
    rt = [[CCRenderTexture renderTextureWithWidth:1 height:1] retain];
    rt.position = ccp(290, 110);
    [self addChild:rt z:99];
    rt.visible = YES;
    [super onEnter];
}

//监听首次触发事件  
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event  
{   
    //NSLog(@"mask sprite!!");
    
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];
    if(![self isTransparentWithSprite:theSprite pointInNodeSpace:location])
    {
        NSLog(@"图像！");
        return YES;
    }
    else {
        NSLog(@"透明！");
        return NO;
    }
      
}  
//监听移动事件  
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event  
{     
    
}  
//监听离开事件  
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event  
{  
    
} 

-(void)isTheSprite:(CCSprite *)sprite
{
    theSprite = sprite;
}

-(bool)isTransparentWithSprite: (CCSprite *)sprite pointInNodeSpace: (CGPoint) point 
{
    //NSLog(@"in function");
    bool isTransparent = YES;
    // see if the point is transparent. if so, ignore it.
    // http://www.cocos2d-iphone.org/forum/topic/18522
    unsigned int w = 1;
    unsigned int h = 1;
    unsigned int wh = w * h;
    //ccColor4B *buffer = ccColor4B[4];
    Byte buffer[4];
    // Draw into the RenderTexture
    [rt beginWithClear:0 g:0 b:0 a:0];
    
    // move touch point to 0,0 so it goes to the right place on the rt
    // http://www.cocos2d-iphone.org/forum/topic/18796
    // hold onto old position to move it back immediately
    float oldrotation = sprite.rotation; 
    float oldscale = sprite.scale;
    sprite.rotation = 0.0f;
    sprite.scale = 1.0f;
    CGPoint oldPos = sprite.position;
    CGPoint oldAnchor = sprite.anchorPoint;
    sprite.anchorPoint = ccp(0, 0);
    sprite.position = ccp(-point.x, -point.y);
    [sprite visit];
    sprite.anchorPoint = oldAnchor;
    sprite.position = oldPos;
    sprite.rotation = oldrotation;
    sprite.scale = oldscale;
    // read the pixels
    float x = 0;//local.x;
    float y = 0;//local.y;
    glReadPixels(x, y, w, h, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    [rt end];
    
    for(unsigned int i=0; i<wh; i++) {
        if ( buffer[0] || buffer[1] || buffer[2] || buffer[3]) {
            //NSLog(@"%d %d %d %d=== > ",buffer[0],buffer[1],buffer[2],buffer[3]);
            isTransparent = NO;
        }
    }
    return isTransparent;
}

@end
