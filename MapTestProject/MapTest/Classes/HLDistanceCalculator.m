//
//  HLDistanceCalculator.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/21/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLDistanceCalculator.h"
#import "HLApiCoordinate.h"
#import "HLHotel.h"
#import "HlCity.h"
#import "HLResultVariant.h"

@implementation HLLocationPoint

- (id) initWithName:(NSString *)name location:(CLLocation *)location
{
    self = [super init];
    if(self) {
        _name = name;
        _location = location;
    }
    return self;
}

- (id) initWithCurrentCity:(HLCity *)city
{
    self = [super init];
    if(self) {
        CLLocationDegrees lat = city.latitude.doubleValue;
        CLLocationDegrees lon = city.longitude.doubleValue;
        CLLocation * cityLocation = [[CLLocation alloc] initWithLatitude:lat
                                                               longitude:lon];
//        self.name = LS(@"HL_LOC_FILTER_DISTANCE_CRITERIA_CENTER");
        self.location = cityLocation;
    }
    return self;
}

- (BOOL) isEqual:(id)object
{
    if(![object isKindOfClass:[HLLocationPoint class]]){
        return NO;
    }
    HLLocationPoint * otherPoint = (HLLocationPoint *)object;
    if(![otherPoint.name.lowercaseString isEqualToString:self.name.lowercaseString]){
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark NSCoding Methods

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_location forKey:@"location"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.location = [coder decodeObjectForKey:@"location"];
    }
    return self;
}

@end

@implementation HLDistanceCalculator

+ (HLDistanceCalculator *) sharedCalculator
{
	static HLDistanceCalculator *calculator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calculator = [[HLDistanceCalculator alloc] init];
    });
    
	return calculator;
}

- (double) getDistanceFromUserToLocation:(CLLocation *)location
{
//	HLLocationManager * manager = [HLLocationManager sharedManager];
//	CLLocation * currentLocation = [manager location];
//	if(currentLocation){
//		return [location distanceFromLocation:currentLocation]/1000.0;
//	}
//	else{
		return -1;
//	}
}

+ (double) getDistanceTo:(HLApiCoordinate *)destination
{
	CLLocationDegrees latDegrees = [destination.latitude doubleValue];
	CLLocationDegrees lonDegrees = [destination.longitude doubleValue];

	CLLocation * location = [[CLLocation alloc] initWithLatitude:latDegrees longitude:lonDegrees];
	return [[HLDistanceCalculator sharedCalculator] getDistanceFromUserToLocation:location];
}

+ (double) getDistanceFrom:(CLLocation *)from to:(CLLocation*)to
{
	return [to distanceFromLocation:from]/1000.0;
}

+ (double) getDistanceFromUserToHotel:(HLHotel *)hotel
{
	CLLocation * location = [[CLLocation alloc] initWithLatitude:hotel.latitude longitude:hotel.longitude];
	return [[HLDistanceCalculator sharedCalculator] getDistanceFromUserToLocation:location];
}

+ (double) getDistanceFromLocationPoint:(HLLocationPoint *)point toHotel:(HLHotel *)hotel
{
    CLLocation * loc1 = [[CLLocation alloc] initWithLatitude:hotel.latitude longitude:hotel.longitude];
    return ([loc1 distanceFromLocation:point.location] / 1000.0);
}

+ (double) getDistanceFromCity:(HLCity *)city toHotel:(HLHotel *)hotel{
	CLLocation * loc1 = [[CLLocation alloc] initWithLatitude:hotel.latitude longitude:hotel.longitude];
	CLLocation * loc2 = [[CLLocation alloc] initWithLatitude:city.latitude.doubleValue longitude:city.longitude.doubleValue];
	
    return ([loc1 distanceFromLocation:loc2] / 1000);
}

+ (double) convertKilometersToMiles:(double)kilometers
{
	return kilometers/1.6;
}

- (NSArray *)sortHotelsInMinimalRectAroundUser:(NSArray *)hotels aspectRatio:(CGFloat)ratio
{
//	NSArray * result = [self sortHotels:hotels userLocation:[HLLocationManager sharedManager].location ratio:ratio];
//	return result;
    return hotels;
}

- (NSArray *) sortHotels:(NSArray *)hotels userLocation:(CLLocation *)userLocation ratio:(CGFloat)ratio
{
	NSArray * result = [hotels sortedArrayUsingComparator:^NSComparisonResult(HLHotel *hotel1, HLHotel * hotel2) {
		CGFloat y1 = fabsf(userLocation.coordinate.latitude - hotel1.latitude);
		CGFloat x1 = fabsf(userLocation.coordinate.longitude - hotel1.longitude);
		CGFloat value1 = MAX(x1/ratio, y1);
		
		CGFloat y2 = fabsf(userLocation.coordinate.latitude - hotel2.latitude);
		CGFloat x2 = fabsf(userLocation.coordinate.longitude - hotel2.longitude);
		CGFloat value2 = MAX(x2/ratio, y2);

		
		if(value1 < value2){
			return NSOrderedAscending;
		}
		else if(value1 > value2){
			return NSOrderedDescending;
		}
		return NSOrderedSame;
	}];
	return result;
}

- (void) calculateDistancesFromVariants:(NSArray *)variants toLocationPoint:(HLLocationPoint *)point
{
    for (HLResultVariant * variant in variants) {
        CGFloat distance = [HLDistanceCalculator getDistanceFromLocationPoint:point toHotel:variant.hotel];
        variant.distanceToCurrentLocationPoint = distance;
    }
}

@end
