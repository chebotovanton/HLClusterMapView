//
//  HLDistanceCalculator.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/21/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "HLHotel.h"

@class HLApiCoordinate;

@interface HLLocationPoint : NSObject <NSCoding>
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) CLLocation * location;
@property (nonatomic, assign) BOOL isUserLocationPoint;

- (id) initWithName:(NSString *)name location:(CLLocation *)location;
- (id) initWithCurrentCity:(HLCity *)city;
@end


@interface HLDistanceCalculator : NSObject
+ (HLDistanceCalculator *) sharedCalculator;
+ (double) getDistanceTo:(HLApiCoordinate *)destination;
+ (double) getDistanceFrom:(CLLocation *)from to:(CLLocation*)to;

+ (double) getDistanceFromLocationPoint:(HLLocationPoint *)point toHotel:(HLHotel *)hotel;
+ (double) getDistanceFromUserToHotel:(HLHotel *)hotel;
+ (double) getDistanceFromCity:(HLCity *)city toHotel:(HLHotel *)hotel;

+ (double) convertKilometersToMiles:(double)kilometers;

- (NSArray *)sortHotelsInMinimalRectAroundUser:(NSArray *)hotels aspectRatio:(CGFloat)ratio;

- (void) calculateDistancesFromVariants:(NSArray *)variants toLocationPoint:(HLLocationPoint *)point;

@end
