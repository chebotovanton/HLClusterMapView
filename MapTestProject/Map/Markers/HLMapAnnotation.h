//
//  HLMapAnnotation.h
//  HotelLook
//
//  Created by Anton Chebotov on 18/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "HLResultVariant.h"
#import "ADClusterMapView.h"


@interface HLMapAnnotation : ADMapPointAnnotation <MKAnnotation>

@property (strong, nonatomic) HLResultVariant * variant;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

- (id) initWithVariant:(HLResultVariant *)variant;
@end
