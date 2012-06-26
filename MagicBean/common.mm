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

@end