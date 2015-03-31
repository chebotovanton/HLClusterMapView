//
//  HLVariantsMapView.h
//  HotelLook
//
//  Created by Anton Chebotov on 05/02/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLMapView.h"

@interface HLVariantsMapView : HLMapView

- (void) setupWithSingleVariant:(HLResultVariant *)variant;
- (void) setupWithFilteredVariants:(NSArray *)filteredVariants;

@end
