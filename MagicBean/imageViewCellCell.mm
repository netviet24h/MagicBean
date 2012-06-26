//
//  imageViewCellCell.m
//  MagicBean
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "imageViewCellCell.h"

@implementation imageViewCellCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Initialization code
        //Touches *t = [[Touches alloc] initWithImage:image];
        //[self addSubview:t];
    }
    return self;
}
- (void)viewDidLoad {
	//self.userInteractionEnabled = YES;
    //[self resignFirstResponder];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
	NSInteger tapcount = [touch tapCount];
    CGPoint rightPos = [[CCDirector sharedDirector] convertToGL:location];  
    NSLog(@"BEGIN in cell");
    //CGImage
    g_table.scrollEnabled = NO;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
	NSInteger tapcount = [touch tapCount];
    CGPoint rightPos = [[CCDirector sharedDirector] convertToGL:location];

    NSLog(@"move in cell");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     [super touchesEnded:touches withEvent:event];
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
	NSInteger tapcount = [touch tapCount];
    CGPoint rightPos = [[CCDirector sharedDirector] convertToGL:location];  
    NSLog(@"end in cell");
     g_table.scrollEnabled = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
