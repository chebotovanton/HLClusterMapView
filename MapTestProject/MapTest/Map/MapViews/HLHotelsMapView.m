//
//  HLHotelsMapView.m
//  HotelLook
//
//  Created by Anton Chebotov on 30/01/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLHotelsMapView.h"
#import "HLDistanceCalculator.h"

#define HL_VISIBLE_CLOSEST_HOTELS_COUNT 30
#define HL_HOTELS_MAP_VIEW_PIN_DELAY 0.3f

@interface HLHotelsMapView()
{
	NSArray * _visibleHotels;
}

@end

@implementation HLHotelsMapView

- (void) initialize
{
	[super initialize];
	self.maxGroupDistanceInPixels = 70.0;
}

- (void) setupWithHotels:(NSArray *)hotels
{
	[self addHotelAnnotations:hotels];
}

- (void) addHotelAnnotations:(NSArray *) hotels
{
	if(_visibleHotels != nil){
		return;
	}
	_visibleHotels = hotels;
	
	HLDistanceCalculator * calculator = [[HLDistanceCalculator alloc] init];
	CGFloat ratio = self.frame.size.width / self.frame.size.height;
	NSArray * sortedHotels = [calculator sortHotelsInMinimalRectAroundUser:hotels aspectRatio:ratio];

	NSArray * closestHotels = [self selectClosestFromSortedHotels:sortedHotels maxCount:HL_VISIBLE_CLOSEST_HOTELS_COUNT];

	[self setRegionForMultipleHotels:closestHotels];

	[self addPinsFrom:closestHotels delay:0.0];
}

- (void) addPinsFrom:(NSArray *)hotels delay:(CGFloat)delay
{
	NSMutableArray * markersArray = [NSMutableArray new];
	for(int i = 0; i < hotels.count; i++){
		HLMapAnnotation * annotation = [HLMapAnnotation new];
		annotation.variant = nil;
		[markersArray addObject:annotation];
	}
	[self addMarkers:markersArray];
}

- (NSArray *) selectClosestFromSortedHotels:(NSArray *)sortedHotels maxCount:(int)maxCount
{
	unsigned long rangeLength = MIN(maxCount, sortedHotels.count);
	NSRange range;
	range.location = 0;
	range.length = rangeLength;
	
	NSIndexSet * indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
	NSArray * selectedHotels = [sortedHotels objectsAtIndexes:indexSet];
	return selectedHotels;
}

@end
