//
//  HLHotelCalloutView.h
//  HotelLook
//
//  Created by Anton Chebotov on 10/4/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLResultVariant.h"

@protocol HLHotelCalloutProtocol <NSObject>
- (void) showFullHotelInfo:(HLResultVariant *)variant;
@end

@interface HLHotelCalloutView : UIButton

@property (nonatomic, strong) HLResultVariant * variant;
@property (nonatomic, weak) id <HLHotelCalloutProtocol> delegate;

- (IBAction)showFullInfo;

- (void) setVariant:(HLResultVariant *)variant;

@end
