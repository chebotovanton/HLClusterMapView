//
//  HLCommonVC.h
//  HotelLook
//
//  Created by Anton Chebotov on 7/23/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringUtils.h"
#import "HLStatKeeper.h"
#import "UIViewController+HLDrawerController.h"
#import "NSObject+RegisterForNotifications.h"
#import "HLErrorModalVC.h"


typedef BOOL (^SidebarGestureShouldRecognizeTouchBlock)(MMDrawerController *drawerController, UIGestureRecognizer *gestureRecognizer, UITouch *touch);

@protocol HLDialogProtocol <NSObject>

- (HLErrorModalVC *)showDialogWithNibName:(NSString *)nibName;
- (void)showNoInternetConnectionDialog;

@end


@interface HLCommonVC : UIViewController <HLNoInternetConnectionDelegate, HLDialogProtocol,  HLErrorModalVCDelegate>

@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIButton *menuButton;
@property (nonatomic, weak) IBOutlet UIView   *navBarView;
@property (nonatomic, weak) IBOutlet UILabel  *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel  *infoLabel;

@property (nonatomic, strong) HLErrorModalVC *errorViewController;

@property (nonatomic, copy) SidebarGestureShouldRecognizeTouchBlock sidebarGestureShouldRecognizeTouchBlock;

@property (nonatomic, assign) MMCloseDrawerGestureMode closeDrawerGestureModeMask;
@property (nonatomic, assign) MMOpenDrawerGestureMode  openDrawerGestureModeMask;

- (IBAction) openMenu;
- (IBAction) goBack;

- (void) closeKeyboard;
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void) showToastWithText:(NSString *)text icon:(UIImage *)icon animated:(BOOL)animated;

@end
