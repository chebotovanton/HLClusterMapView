//
//  HLSearchInfo.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/7/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLCurrency.h"
#import "HLCity.h"

@class HLManagedSearchInfo;
@class HLCity;
@class HLHotel;


@interface HLSearchInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSMutableArray *kidAgesArray;
@property (nonatomic, strong) NSDate         *checkInDate;
@property (nonatomic, strong) NSDate         *checkOutDate;
@property (nonatomic, strong) HLCity         *city;
@property (nonatomic, strong) HLHotel        *hotel;
@property (nonatomic, strong) HLCurrency     *currency;
@property (nonatomic, copy)   NSString       *language;
@property (nonatomic, copy)   NSString       *token;
@property (nonatomic, assign) NSInteger       adultsCount;


- (void)updateWithDictionary:(NSDictionary *)dict;
- (void)updateExpiredDates;
- (BOOL)readyToSearch;
- (BOOL)areDatesExpired;
- (BOOL)isLocalSearchInfo;

@end
