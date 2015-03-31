//
//  HLHotel.h
//  HotelLook
//
//  Created by Anton Chebotov on 31/10/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HLManagedHotel;
@class HLCity;


@interface HLHotel : NSObject <NSCoding>

@property (nonatomic, copy) NSString        * address;
@property (nonatomic, copy) NSString        * chain;
@property (nonatomic, copy) NSString        * hotelId;
@property (nonatomic, copy) NSString        * name;
@property (nonatomic, copy) NSString        * photoHash;
@property (nonatomic, copy) NSString        * hotelDescription;

@property (nonatomic, strong) NSDate        * checkInTime;
@property (nonatomic, strong) NSDate        * checkOutTime;
@property (nonatomic, strong) NSDictionary  * fullAmenities;
@property (nonatomic, strong) NSDictionary  * trustYouIfno;
@property (nonatomic, strong) NSDictionary  * amenities;
@property (nonatomic, strong) NSArray       * foursquareReviews;
@property (nonatomic, strong) HLCity        * city;

@property (nonatomic, assign) CGFloat         latitude;
@property (nonatomic, assign) CGFloat         longitude;
@property (nonatomic, assign) CGFloat         distance;
@property (nonatomic, assign) NSInteger       type;
@property (nonatomic, assign) NSInteger       photosCount;
@property (nonatomic, assign) NSInteger       popularity;
@property (nonatomic, assign) NSInteger       rating;
@property (nonatomic, assign) NSInteger       stars;
@property (nonatomic, assign) NSInteger       ordersCount;
@property (nonatomic, assign) NSInteger       foursquareCheckinCount;
@property (nonatomic, assign) BOOL            hasFoursquareTips;

@property (nonatomic, strong) NSDictionary  * scoring;

@end
