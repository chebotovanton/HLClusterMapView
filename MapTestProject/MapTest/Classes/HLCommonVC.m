//
//  HLCommonVC.m
//  HotelLook
//
//  Created by Anton Chebotov on 7/23/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <objc/runtime.h>

#import "HLCommonVC.h"

@interface HLCommonVC ()

@end


@implementation HLCommonVC

#pragma mark -
#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
		
	if ([self isRootViewController]) {
		self.backButton.hidden = YES;
	} else {
		self.menuButton.hidden = YES;
	}
	
	[self.backButton setImage:[UIImage imageNamed:@"navBarBackButtonHighlighted"] forState:UIControlStateHighlighted];
	[self.menuButton setImage:[UIImage imageNamed:@"sideBarButtonHighlighted"] forState:UIControlStateHighlighted];
	
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


@end
