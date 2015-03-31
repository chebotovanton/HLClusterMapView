//
//  HLMapView.m
//  HotelLook
//
//  Created by Anton Chebotov on 8/12/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//
#import <objc/message.h>
#import "HLMapView.h"
#import "HLCity.h"
#import "HLResultVariant.h"
#import "HLApiCoordinate.h"
#import "HLHotelCalloutView.h"

#define HL_CITY_REGION_SPAN 0.075f
#define HL_SINGLE_HOTEL_REGION_SPAN 0.01f
#define HL_USER_REGION_SPAN 0.05f

#define HL_PIN_CALLOUT_VERTICAL_OFFSET 107.0f


@interface HLMapView()
{
	HLSearchInfo * searchInfo;
}
@property (strong) id <ADClusterMapViewDelegate> defaultDelegate;
@end

@implementation HLMapView

- (id) init
{
	self = [super init];
	if(self){
		[self initialize];
	}
	return self;
}

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self initialize];
}

- (void) initialize
{	
	self.showsUserLocation = YES;
	
	self.delegate = self.defaultDelegate;
	
	self.rotateEnabled = NO;
}

- (void)showCity:(HLCity *)city
{
	self.showedCity = city;
	MKCoordinateRegion region = [self regionForCity:city];
	[self setRegion:region animated:YES];
}

- (BOOL) isHotelCoordinateValid:(HLHotel *)hotel
{
	if([hotel isKindOfClass:[HLHotel class]] == NO){
		return NO;
	}
	
	float lat = hotel.latitude;
	float lon = hotel.longitude;
	
	if(fabsf(lat) < 0.1){
		return NO;
	}
	if( fabs(lon) < 0.1){
		return NO;
	}
	return YES;
}

- (void) clear
{
	[self removeAnnotations:self.annotations];
}

#pragma mark -
#pragma mark Public
- (void) setRegionForSingleHotel:(HLHotel *)hotel
{
	MKCoordinateRegion region = [self regionForSingleHotel:hotel];
	[self setRegion:region animated:YES];
}

- (void) setRegionForMultipleHotels:(NSArray *)array
{
#warning Content insets for small zoom level. Region too big for huge zoom level.
	MKCoordinateRegion region = [self regionForHotels:array];
	[self setRegion:region animated:YES];
}

- (void) setRegionForVariants:(NSArray *)variantsArray
{
	NSMutableArray * hotels = [NSMutableArray new];
	for (HLResultVariant * variant in variantsArray) {
		[hotels addObject:variant.hotel];
	}
	[self setRegionForMultipleHotels:hotels];
}

- (void) setRegionForUserLocation
{
	MKCoordinateRegion region = [self regionForUserLocation];
	[self setRegion:region animated:YES];
}

- (void) addMarkers:(NSArray *) markers
{
	[self setAnnotations:markers];
}

- (void) centerOnVariant:(HLResultVariant *)variant
{
	CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(variant.hotel.latitude, variant.hotel.longitude);
	CGPoint pinPosition = [self convertCoordinate:coord toPointToView:self];
	pinPosition.y -= HL_PIN_CALLOUT_VERTICAL_OFFSET;
	CLLocationCoordinate2D newCenterCoord = [self convertPoint:pinPosition toCoordinateFromView:self];

#warning this animation wrecks everything
	NSLog(@"Center animation started");
	[UIView animateWithDuration:0.3
						  delay:0.0
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self setCenterCoordinate:newCenterCoord animated:NO];
					 }
					 completion:^(BOOL finished) {
						 NSLog(@"Center animation finished: %d", finished);
					 }];
}

- (void) setRegion:(MKCoordinateRegion)region animated:(BOOL)animated
{
	CGFloat duration = animated ? 0.3 : 0.0;
	NSLog(@"Region animation started");
	[UIView animateWithDuration:duration
						  delay:0.0
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [super setRegion:region animated:NO];
					 }
					 completion:^(BOOL finished) {
						 NSLog(@"Region animation finished: %d", finished);
					 }];
}

- (void) setVisibleMapRect:(MKMapRect)mapRect animated:(BOOL)animated
{
	CGFloat duration = animated ? 0.3 : 0.0;
	NSLog(@"Region animation started");
	[UIView animateWithDuration:duration
						  delay:0.0
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [super setVisibleMapRect:mapRect animated:NO];
					 }
					 completion:^(BOOL finished) {
						 NSLog(@"Region animation finished: %d", finished);
					 }];
}

#pragma mark -
#pragma mark Region calculations

- (MKCoordinateRegion) regionForCity:(HLCity *)city;
{
	CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(city.latitude.floatValue, city.longitude.floatValue);
	MKCoordinateSpan span = MKCoordinateSpanMake(HL_CITY_REGION_SPAN, HL_CITY_REGION_SPAN);
	MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
	return region;
}

- (MKCoordinateRegion) regionForSingleHotel:(HLHotel *) hotel
{
	CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(hotel.latitude, hotel.longitude);
	MKCoordinateSpan span = MKCoordinateSpanMake(HL_CITY_REGION_SPAN, HL_CITY_REGION_SPAN);
	MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
	return region;
}

- (MKCoordinateRegion) regionForHotels:(NSArray *) hotels
{
	double minLat = DBL_MAX;
	double maxLat = -DBL_MAX;
	double minLon = DBL_MAX;
	double maxLon = -DBL_MAX;

	for (HLHotel * hotel in hotels) {
		if([self isHotelCoordinateValid:hotel]){
			float lat = hotel.latitude;
			float lon = hotel.longitude;

			minLat = MIN(minLat, lat);
			maxLat = MAX(maxLat, lat);
			minLon = MIN(minLon, lon);
			maxLon = MAX(maxLon, lon);
		}
	}
    
    double spanOffsetFactor = 1.2;
    
	CLLocationCoordinate2D coord = CLLocationCoordinate2DMake((maxLat + minLat)/2.0, (maxLon + minLon)/2.0);
	MKCoordinateSpan span = MKCoordinateSpanMake((maxLat - minLat) * spanOffsetFactor, (maxLon - minLon) * spanOffsetFactor);
	MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
	region = [self regionThatFits:region];
	return region;
	
}

- (MKCoordinateRegion) regionForUserLocation
{
	CLLocationCoordinate2D coord = self.userLocation.location.coordinate;
	MKCoordinateSpan span = MKCoordinateSpanMake(HL_CITY_REGION_SPAN, HL_CITY_REGION_SPAN);
	MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
	return region;
}

@end
