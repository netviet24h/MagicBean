//
//  common.mm
//  GlassPrince
//
//  Created by Ivan on 11-9-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "common.h"

NSString *language =NSLocalizedString(@"LANGUAGE", nil);
CGSize screenSize ;

@implementation Common

+ (NSInteger)createRandomsizeValueInt:(NSInteger)fromInt toInt:(NSInteger)toInt
{
    if (toInt < fromInt)
    {
        return toInt;
    }
    if (toInt == fromInt)  
    {
        return fromInt;
    }
    NSInteger randVal = arc4random() % (toInt - fromInt + 1) + fromInt;
    return randVal;
}

+ (double)createRandomsizeValueFloat:(double)fromFloat toFloat:(double)toFloat
{
    if (toFloat < fromFloat)
    {
        return toFloat;
    }
    if (toFloat == fromFloat)  
    {
        return fromFloat;
    }
    double randVal = ((double)arc4random() / ARC4RANDOM_MAX) * (toFloat - fromFloat) + fromFloat;
    return randVal;
}
+(BOOL) isTransparentWithSprite: (CCSprite *)sprite pointInNodeSpace: (CGPoint) point onto:(CCLayer*)layer//scaleto:(float)scale rotateto:(float)rotate
{    
    CCRenderTexture *rt = [[CCRenderTexture renderTextureWithWidth:1 height:1] retain];
    [layer addChild:rt z:99];
    rt.visible = YES;
    
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
    
    //******************rt begin******************
    [rt beginWithClear:0 g:0 b:0 a:0];
    // move touch point to 0,0 so it goes to the right place on the rt
    // http://www.cocos2d-iphone.org/forum/topic/18796
    // hold onto old position to move it back immediately
    CGPoint oldPos = sprite.position;
    CGPoint oldAnchor = sprite.anchorPoint;
    float oldScale = sprite.scale;
    float oldRot = sprite.rotation;
    double tempx,tempy;
    tempx = -point.x;//*scale;
    tempy = -point.y;//*scale;
    sprite.rotation = 0;
    sprite.scale = 1;
    sprite.anchorPoint = ccp(0, 0);
    sprite.position = ccp(tempx, tempy);
    [sprite visit];
    
    sprite.rotation = oldRot;
    sprite.scale = oldScale;
    sprite.anchorPoint = oldAnchor;
    sprite.position = oldPos;
    // read the pixels
    float x = 0;//local.x;
    float y = 0;//local.y;
    glReadPixels(x, y, w, h, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    [rt end];
    //******************rt end******************
    
    
    // Read buffer
    //ccColor4B color;
    for(unsigned int i=0; i<wh; i++) {
        //color = buffer[i];
        // if untouched, point will be (0, 0, 0, 0). if the sprite was drawn into this pixel (ie not transparent), one of those values will be altered
        if ( buffer[0] || buffer[1] || buffer[2] )//|| buffer[3])
        {
            //NSLog(@" ");
            //NSLog(@"%d %d %d %d=== > ",buffer[0],buffer[1],buffer[2],buffer[3]);
            //NSLog(@" ");
            isTransparent = NO;
        }
    }
    return isTransparent;
}
@end