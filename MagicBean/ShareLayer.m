//
//  ShareLayer.m
//  MagicBean
//
//  Created by  on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareLayer.h"
UITableView *g_table;

@interface MFMailComposeViewController (AutoRotation)
// to stop auto rotation
@end

@implementation MFMailComposeViewController (AutoRotation)
// stop auto rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // should support all interface orientations.
    return (UIInterfaceOrientationIsLandscape( interfaceOrientation ));
}
@end


@implementation MYTableView
@synthesize isSelected;
@end

@implementation ShareLayer
@synthesize myTableView;
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ShareLayer *layer = [ShareLayer node];
	
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
        [self addChild:bg1];
        
        CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"share_btnHome.png" selectedImage:@"share_btnHome.png" target:self selector:@selector(homeCallFunc)];
        CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"share_btnCancel.png" selectedImage:@"share_btnCancel.png" target:self selector:@selector(cancelCallFunc)];
        CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"share_btnOk.png" selectedImage:@"share_btnOk.png" target:self selector:@selector(okCallFunc)];
        
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3, nil];
        menu.position = ccp(1024-item1.contentSize.width/2,item1.contentSize.height*2);
        [menu alignItemsVertically];
        item1.position = ccp(item1.position.x,item1.position.y+400);
        [self addChild:menu];
        
        CGRect frame = leftBar.boundingBox;//CGRectMake(0+20, 768-300-20, 300, 300);
        MYTableView *table = [[MYTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        [table setOpaque:YES];
        self.myTableView = table;
        table.showsHorizontalScrollIndicator = NO;
        table.showsVerticalScrollIndicator = NO;
        [table setBackgroundColor:[UIColor clearColor]];
        //table. 
        //[self.myTableView setEditing:!self.myTableView.editing animated:YES];
        [[[CCDirector sharedDirector] openGLView] addSubview:self.myTableView];
        
        myTableView.separatorStyle = NO;//取消cell间横线
        myTableView.delaysContentTouches = 5;
        //myTableView.scrollEnabled = NO;
        g_table = myTableView;
        [table release];
       // myTableView.
        
        
       
    }
    return self;
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
		emailController = [[UIViewController alloc] init];
		picker = [[MFMailComposeViewController alloc] init];
        //[picker setWantsFullScreenLayout:YES];
		[[[CCDirector sharedDirector] openGLView] addSubview:emailController.view];
		picker.mailComposeDelegate = self;
		NSArray *toRecipients = [NSArray arrayWithObject:@""];
		[picker setToRecipients:toRecipients];
		[picker setSubject:@"Check out Little Star for iPad"];
		NSString *emailBody = @"Little star is a fully interactive children's book, beautifully illustrated, great story, cute characters, with 2 bonus games included, your kids can read and play the same time. Great for the whole family!\n\ngo get it at:\nhttp://www.bibobox.com/apps/littlestar";
		[picker setMessageBody:emailBody isHTML:NO];
		[picker addAttachmentData:nil mimeType:@"image/jpeg" fileName:@"g_background.jpg"];
		[emailController presentModalViewController:picker animated:YES];
		
		[picker release];
	}
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	
	[[CCDirector sharedDirector] resume];
	//dismiss view after otherwise the code is not executed
	[picker dismissModalViewControllerAnimated:YES];
	[picker.view removeFromSuperview];
	[emailController.view removeFromSuperview];
	
	//[[CCDirector sharedDirector] replaceScene:[PageLayer29 scene]];
	[emailController release];
}
-(void)homeCallFunc
{
}
-(void)cancelCallFunc
{
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
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [touch locationInView:[touch view]];
    rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    myTableView.userInteractionEnabled = NO;
    //[super touchesBegan:touches withEvent:event];
    NSLog(@"touch begin layer");
    
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [touch locationInView:[touch view]];
    rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    myTableView.userInteractionEnabled = YES;
    NSLog(@"touch end layer");

}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint rightPosition = [touch locationInView:[touch view]];
    rightPosition = [[CCDirector sharedDirector] convertToGL:rightPosition];
    myTableView.userInteractionEnabled = YES;
    NSLog(@"touch end layer");
    
}
#pragma mark -
#pragma mark Table view data source
// Override to support row selection in the table view.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Navigation logic may go here -- for example, create and push another view controller.
    // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
    // [self.navigationController pushViewController:anotherViewController animated:YES];
    // [anotherViewController release];
    //取消选中行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    tableView.userInteractionEnabled = YES;
     tableView.scrollEnabled = YES;
    NSLog(@"xxxxx");
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ass");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 15;//[myTableInfos count];
}
//向下拖更新
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    NSLog(@"222");
    return YES;
    
}
//删除
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    NSLog(@"555");
    return YES;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[imageViewCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setNeedsDisplay];
    cell.tag = [indexPath row];
    // Configure the cell...
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"p_%d.png",[indexPath row]+1]];
    cell.imageView.image = image;
    [cell.imageView setOpaque:YES];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    //只相应横板旋转
//    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
//    {
//        return YES;
//        
//    }
    //只相应竖版旋转
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        return YES;
    
    }
    return NO;
    
}

@end
