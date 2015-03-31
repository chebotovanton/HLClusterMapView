//
//  HLSingleAnnotationView.h
//  HotelLook
//
//  Created by Anton Chebotov on 25/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLAnnotationView.h"

@interface HLSingleAnnotationView : HLAnnotationView
- (void) expandAnimated:(BOOL)animated;
- (void) collapseAnimated:(BOOL)animated;
@end
