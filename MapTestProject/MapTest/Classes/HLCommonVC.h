//
//  HLCommonVC.h
//  HotelLook
//
//  Created by Anton Chebotov on 7/23/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLCommonVC : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIButton *menuButton;
@property (nonatomic, weak) IBOutlet UIView   *navBarView;
@property (nonatomic, weak) IBOutlet UILabel  *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel  *infoLabel;

- (void) closeKeyboard;
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
