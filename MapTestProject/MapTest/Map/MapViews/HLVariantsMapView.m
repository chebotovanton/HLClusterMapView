//
//  HLVariantsMapView.m
//  HotelLook
//
//  Created by Anton Chebotov on 05/02/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLVariantsMapView.h"
#import "HLCity.h"
#import "HLHotel.h"
#import "StringUtils.h"

#define HL_MIN_DIFFERENT_COORDINATES_EPSILON 0.003f

#define HL_DEFAULT_INITIAL_MAP_ZOOM 11.5f


@interface HLVariantsMapView ()
{
	NSArray * _variants;
	NSArray * _lastTappedMarkers;
}

@end


@implementation HLVariantsMapView

- (void) setupWithFilteredVariants:(NSArray *)filteredVariants
{	
	NSMutableArray * anns = [NSMutableArray new];
	for(HLResultVariant * variant in filteredVariants){
		HLMapAnnotation * ann = [[HLMapAnnotation alloc] initWithVariant:variant];
		if(ann){
			[anns addObject:ann];
		}
	}
    if(filteredVariants.count > 1){
        [self setRegionForVariants:filteredVariants];
    }
	[self addMarkers:anns];
}


#pragma mark -

- (void) setupWithSingleVariant:(HLResultVariant *)variant
{
	HLMapAnnotation * marker = [[HLMapAnnotation alloc] initWithVariant:variant];
	[self addMarkers:@[marker]];
	[self setRegionForSingleHotel:variant.hotel];
}

- (void) addVariantMarkers:(NSArray *)variants
{
	NSMutableArray * newMarkers = [NSMutableArray new];
	for (HLResultVariant * variant in variants){
		HLMapAnnotation * marker = [[HLMapAnnotation alloc] initWithVariant:variant];
		[newMarkers addObject:marker];
	}
	[self addMarkers:newMarkers];
}

- (void) showGroupCalloutIfNeeded:(NSArray *)markers
{
}
@end
