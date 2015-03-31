//
//  HLCoordinates.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/20/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLApiCoordinate : NSObject <NSCoding>

+ (instancetype)coordinateWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

- (HLApiCoordinate *)initWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

@property (nonatomic, strong) NSNumber * latitude;
@property (nonatomic, strong) NSNumber * longitude;

@end
