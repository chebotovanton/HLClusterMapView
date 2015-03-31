//
//  HLMapViewDelegate.h
//  HotelLook
//
//  Created by Anton Chebotov on 8/13/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLResultVariant.h"

@protocol HLMapViewDelegate <NSObject>
@optional
- (void) showHotelCallout:(HLResultVariant *)variant;
- (void) showGroupCallout:(NSArray *)variants;
@end
