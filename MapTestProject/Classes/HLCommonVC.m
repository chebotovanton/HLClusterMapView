//
//  HLCommonVC.m
//  HotelLook
//
//  Created by Anton Chebotov on 7/23/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <objc/runtime.h>

#import "HLCommonVC.h"
#import "HLViewDeckController.h"
#import "HLPushNavigationAnimator.h"
#import "HLPopNavigationAnimator.h"
#import "HLErrorModalVC.h"
#import "Hotellook-Swift.h"

@interface HLCommonVC ()

@end


@implementation HLCommonVC

#pragma mark -
#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.sidebarGestureShouldRecognizeTouchBlock = nil;
    self.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
		
	if ([self isRootViewController]) {
		self.backButton.hidden = YES;
	} else {
		self.menuButton.hidden = YES;
	}
	
	[self.backButton setImage:[UIImage imageNamed:@"navBarBackButtonHighlighted"] forState:UIControlStateHighlighted];
	[self.menuButton setImage:[UIImage imageNamed:@"sideBarButtonHighlighted"] forState:UIControlStateHighlighted];
	
	if(is_iPhone6Plus()){
		self.titleLabel.font = [UIFont appRegularFontWithSize:19.0];
	} else {
		self.titleLabel.font = [UIFont appRegularFontWithSize:17.0];
	}
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	UIColor * color = [UIColor navBarDividerColor];
	CGFloat lineWidth = 1.0 / UIScreen.mainScreen.scale;
	CGPoint fromPoint = CGPointMake(CGRectGetMinX(self.navBarView.bounds), CGRectGetMaxY(self.navBarView.bounds));
	CGPoint toPoint = CGPointMake(CGRectGetMaxX(self.navBarView.bounds), CGRectGetMaxY(self.navBarView.bounds));
	[self.navBarView drawLine:fromPoint toPoint:toPoint width:lineWidth color:color tag:@"navBarViewLine"];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    CLS_LOG(@"%@", self);
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
    [self registerForNoInternetConnectionNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
    [self unregisterNotificationResponse];
}

- (BOOL)shouldAutorotate
{
    return is_iPad();
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (is_iPad() ? UIInterfaceOrientationMaskAllButUpsideDown : UIInterfaceOrientationMaskPortrait);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return (is_iPad() ? [super preferredInterfaceOrientationForPresentation] : UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
	[self unregisterNotificationResponse];
}

#pragma mark -
- (BOOL)isRootViewController
{
	if (self.navigationController.viewControllers.count == 0) {
		return YES;
	}
	if ([self.navigationController.viewControllers objectAtIndex:0] == self) {
		return YES;
	}
    
	return NO;
}

- (void) closeKeyboard
{
//Don't touch me! I should be overriden by subclasses who need to close keyboard on sidebar opening.
}

- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message
{
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title
													 message:message
													delegate:nil
										   cancelButtonTitle:@"OK"
										   otherButtonTitles:nil];
	[alert show];
}

#pragma mark -
#pragma mark Public

- (void) showToastWithText:(NSString *)text icon:(UIImage *)icon animated:(BOOL)animated
{
	HLToastView *tv = LOAD_VIEW_FROM_NIB_NAMED(@"HLToastView");
	tv.text = text;
	tv.icon = icon;
	[tv show:self.view animated:animated];

}

#pragma mark -
#pragma mark HLDialogProtocol

- (HLErrorModalVC *)showDialogWithNibName:(NSString *)nibName
{
    HLErrorModalVC *modalVC = [[HLErrorModalVC alloc] initWithNibName:nibName bundle:nil];
    [modalVC setDelegate:self];
	[self presentViewController:modalVC animated:YES completion:^{}];
    
    return modalVC;
}

- (void)showNoInternetConnectionDialog
{
	if (self.errorViewController == nil) {
		self.errorViewController = [self showDialogWithNibName:@"HLNoInternetConnectionErrorModalVC"];
		[self.errorViewController setTitleText:LS(@"HL_ALERT_NO_INTERNET_CONNECTION_TITLE")];
		[self.errorViewController setDescriptionText:LS(@"HL_ALERT_NO_INTERNET_CONNECTION_DESCRIPTION")];
	}
}


#pragma mark -
#pragma mark HLNoInternetConnectionDelegate Methods

- (void) noInternetConnection
{
	[self showNoInternetConnectionDialog];
}

#pragma mark -
#pragma mark Navigation

- (IBAction)goBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openMenu
{
	HLViewDeckController * controller = self.viewDeckController;
	[controller openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
	}];
}

#pragma mark -
#pragma mark HLErrorModalVCDelegate Methods

- (void)errorModalViewControllerDidClose:(HLErrorModalVC *)errorModalVC
{
	[errorModalVC dismissViewControllerAnimated:YES completion:^{
		self.errorViewController = nil;
	}];
}

@end
