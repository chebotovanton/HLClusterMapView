//
//  HLMapVC.h
//  HotelLook
//
//  Created by Anton Chebotov on 7/15/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HLCommonVC.h"
#import "HLHotelCalloutView.h"
#import "HLGroupCalloutView.h"
#import "ADClusterMapView.h"

@class HLSearchInfo;

@interface HLMapVC : HLCommonVC <HLHotelCalloutProtocol, HLGroupCalloutProtocol, ADClusterMapViewDelegate>

@property (nonatomic, strong) HLSearchInfo * searchInfo;
@property (nonatomic, assign) BOOL fullscreenMode;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint * groupCalloutConstraint;
@property (nonatomic, weak) IBOutlet UIView             * groupCalloutBackground;

@property (nonatomic, assign) CGFloat initialMapZoom;

- (void)variantsManagerStarted;
- (void)showUserLocation;
- (void)showCity;
- (void)setupWithMinPrice:(CGFloat)minPrice maxPrice:(CGFloat)maxPrice zoom:(CGFloat)zoom variants:(NSArray *)variants;
- (void)showVisibleVariants:(NSArray *)variants;

@end
