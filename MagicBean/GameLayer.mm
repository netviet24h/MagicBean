//
//  GameLayer.m
//  MagicBean
//
//  Created by  on 12-5-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
@interface MailCompose : MFMailComposeViewController {
}
@end

@implementation MailCompose

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end

@interface MyUIViewController : UIViewController {
}

@end

@implementation MyUIViewController

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end


#define kTagShareBg 300
#define kTagDel 301
@implementation GameLayer
+(CCScene*) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
- (id)init
{
    self = [super init];
    if (self) {
        CCSprite *bg = [CCSprite spriteWithFile:@"g_background.jpg"];
        bg.anchorPoint = ccp(0,0);
        [self addChild:bg];
        
        self.isTouchEnabled  = YES;
        CCSprite *leftBar = [CCSprite spriteWithFile:@"share_leftBar.png"];
        leftBar.position = ccp(leftBar.contentSize.width/2, screenSize.height/2);
        [self addChild:leftBar];
        
        CCSprite *bg1 = [CCSprite spriteWithFile:@"share_bg.png"];
        bg1.position = ccp(547,screenSize.height/2);
        [self addChild:bg1 z:0 tag:kTagShareBg];
        

        
        CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"share_btnHome.png" selectedImage:@"share_btnHome.png" target:self selector:@selector(homeCallFunc)];
        CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"share_btnCancel.png" selectedImage:@"share_btnCancel.png" target:self selector:@selector(cancelCallFunc)];
        CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"share_btnOk.png" selectedImage:@"share_btnOk.png" target:self selector:@selector(okCallFunc)];
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3, nil];
        menu.position = ccp(1024-item1.contentSize.width/2,item1.contentSize.height*2);
        [menu alignItemsVertically];
        item3.position = ccpAdd(item3.position, ccp(10,0));
        item1.position = ccp(item1.position.x,item1.position.y+400);
        [self addChild:menu];
        tableLayer = [TableViewScene node];
        [self addChild:tableLayer z:0 tag:0];
        
        [[CCDirector sharedDirector] applyOrientation];
        
        UIPinchGestureRecognizer *pinchRecognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:tableLayer action:@selector(scale:)] autorelease];  
        //[pinchRecognizer setDelegate:self];  
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addGestureRecognizer:pinchRecognizer];  
        
        UIRotationGestureRecognizer *rotationRecognizer = [[[UIRotationGestureRecognizer alloc] initWithTarget:tableLayer action:@selector(rotate:)] autorelease];  
        //[rotationRecognizer setDelegate:self];  
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addGestureRecognizer:rotationRecognizer]; 
        
        
    }
    return self;
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"GAMELAYER");
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            return;
            break;
        case 1:
        {
            [self sendEmail];
            NSLog(@"Email");
        }
            break;
        case 2:
        {
            //[self sendEmail];
            NSLog(@"facebook");
        }
            break;
        case 3:
        {
            //[self sendEmail];
            NSLog(@"sina");
        }
        case 4:
        {
            //[self sendEmail];
            NSLog(@"twitter");
        }
            break;
        default:
            break;
    }
}
-(void)sendEmail
{
	if( [MFMailComposeViewController canSendMail] )
	{
        //CCLOG(@"length%f",length);(@"mail");
		emailController = [[MyUIViewController alloc] initWithNibName:nil bundle:nil];
		picker = [[MailCompose alloc] init];
        picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //picker.modalPresentationStyle = UIModalPresentationCurrentContext
		picker.mailComposeDelegate = self;
		NSArray *toRecipients = [NSArray arrayWithObject:@""];
		[picker setToRecipients:toRecipients];
		[picker setSubject:@"Check out Little Star for iPad"];
		NSString *emailBody = @"Little star is a fully interactive children's book, beautifully illustrated, great story, cute characters, with 2 bonus games included, your kids can read and play the same time. Great for the whole family!\n\ngo get it at:\nhttp://www.bibobox.com/apps/littlestar";
		[picker setMessageBody:emailBody isHTML:NO];
		[[[CCDirector sharedDirector] openGLView] addSubview:emailController.view];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"share.jpg"]];
//        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        
        NSData *data1 = [self glReadImage];
        [self saveToLocal:@"share.jpg" withData:data1];
        [picker addAttachmentData:data1 mimeType:@"image/jpeg" fileName:@"share"];
        
        
       
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            picker.modalPresentationStyle = UIModalPresentationFormSheet;
		[emailController presentModalViewController:picker animated:YES];
		[picker release];
	}
}
-(BOOL)saveToLocal:(NSString*)fileName withData:(NSData*)data
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:fileName]];   // 保存文件的名称
	return [data writeToFile:filePath atomically:YES];
}

-(NSData*)cutTheScreen
{
    CCSprite *sp = (CCSprite*)[self getChildByTag:kTagShareBg];
    CGRect frame= sp.boundingBox; //imageView.frame;
    // imageView.frame=CGRectMake(-420, 300, frame.size.width, frame.size.height);
    
    //    第一种方法　　从原点开始截取
    //    UIGraphicsBeginImageContext(CGSizeMake(320,100));
    //    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];   
    //    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();    
    //    UIGraphicsEndImageContext(); 
    //    
    
    //    第二种方法按制定区域截取
    
    
    UIGraphicsBeginImageContext(sp.contentSize);
    [[CCDirector sharedDirector].openGLView.layer renderInContext:UIGraphicsGetCurrentContext()];   
    UIImage* parentImage=UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef imageRef = parentImage.CGImage;
    CGRect myImageRect=frame;//CGRectMake(0, 100, 320, 100);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    
    CGSize size=sp.contentSize;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    
    UIImage* image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    return (NSData*)UIImagePNGRepresentation(image);
    
}

-(NSData *) glReadImage {
    
    CCSprite *sp = (CCSprite*)[self getChildByTag:kTagShareBg];
    
    int width = (int)(sp.contentSize.width);
    int height = (int)(sp.contentSize.height);
    int tx = sp.position.x;
    int ty = sp.position.y;
    
    NSInteger myDataLength = width * height * 4;
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(tx-width/2,ty-height/2, width, height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y <height ; y++)
    {
        for(int x = 0; x <width* 4; x++)
        {
            buffer2[(height-1 - y) * width * 4 + x] = buffer[y * 4 * width + x];
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * (int)(sp.contentSize.width);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);

    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    UIImage *scaledImage = 
    [UIImage imageWithCGImage:[myImage CGImage] 
                        scale:0.1 orientation:UIImageOrientationUp];

    NSData *data =  UIImageJPEGRepresentation(scaledImage, 12);
    return data;
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	
	[[CCDirector sharedDirector] resume];
	//dismiss view after otherwise the code is not executed
    [emailController dismissModalViewControllerAnimated:YES];
	//[picker dismissModalViewControllerAnimated:YES];
	[picker.view removeFromSuperview];
	[emailController.view removeFromSuperview];
	
	//[[CCDirector sharedDirector] replaceScene:[PageLayer29 scene]];
	[emailController release];
}
-(void)homeCallFunc
{
    //[self unscheduleAllSelectors];
	//self.isAccelerometerEnabled = NO;
    
    CCScene *scene = [PageCommon scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:scene backwards:NO]];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	//[[CCTextureCache sharedTextureCache] removeUnusedTextures];

}
-(void)cancelCallFunc
{
    [tableLayer cancelAllSp];
}
-(void)okCallFunc
{
    
    //[self registerWithTouchDispatcher];
    [self performSelector:@selector(okDelayFunc) withObject:nil afterDelay:0];
    //[self okDelayFunc];
}
-(void)okDelayFunc
{
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"share your photo"
                          message:@"share your photo" 
                          delegate:self 
                          cancelButtonTitle:@"cancel!" 
                          otherButtonTitles:@"mail",@"facebook",@"sina",@"twitter",nil]; 
    
    alert.tag = 0;
    [alert show]; 
}

@end
