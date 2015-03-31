//
//  HLMapView.h
//  HotelLook
//
//  Created by Anton Chebotov on 8/12/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "ADClusterMapView.h"
#import "HLMapViewDelegate.h"
#import <MapKit/MapKit.h>
#import "HLMapAnnotation.h"

@class HLSearchInfo;

@interface HLMapView : ADClusterMapView

@property (nonatomic, copy) HLCity *showedCity;
@property (nonatomic, weak) id<HLMapViewDelegate> mapViewDelegate;
@property (nonatomic, assign) NSInteger minimalGroupCount;
@property (nonatomic, assign) CGFloat singleHotelRegionSpan;
@property (nonatomic, assign) CGFloat maxGroupDistanceInPixels;

- (void) initialize;

- (void) centerOnVariant:(HLResultVariant *)variant;
- (void) showCity:(HLCity *)city;
- (void) setRegionForMultipleHotels:(NSArray *)array;
- (void) setRegionForVariants:(NSArray *)variantsArray;
- (void) setRegionForSingleHotel:(HLHotel *)hotel;
- (void) setRegionForUserLocation;

- (void) addMarkers:(NSArray *) markers;
@end
