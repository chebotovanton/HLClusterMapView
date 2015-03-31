//
//  HLGroupCalloutView.h
//  HotelLook
//
//  Created by Anton Chebotov on 21/02/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLResultVariant.h"

#define HL_GROUP_CALLOUT_CELL_HEIGHT 127.0f
#define HL_GROP_CALLOUT_CANCEL_HEIGHT 47.0f

@protocol HLGroupCalloutProtocol <NSObject>
- (void) showFullHotelInfo:(HLResultVariant *)variant;
@end

@interface HLGroupCalloutView : UIView
@property (nonatomic, weak) id <HLGroupCalloutProtocol> delegate;
@property (nonatomic, strong) NSArray * variants;
- (void) setVariants:(NSArray *) variants;
@end
