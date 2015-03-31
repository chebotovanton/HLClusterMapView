//
//  HLManagedCity.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/12/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLManagedCity;


@interface HLCity : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy)   NSString   * cityId;
@property (nonatomic, copy)   NSString   * name;
@property (nonatomic, copy)   NSString   * fullName;
@property (nonatomic, copy)   NSString   * country;
@property (nonatomic, copy)	  NSString   * state;
@property (nonatomic, strong) NSNumber   * latitude;
@property (nonatomic, strong) NSNumber   * longitude;
@property (nonatomic, strong) NSNumber   * hotelsCount;
@property (nonatomic, strong) NSArray    * iata;
@property (nonatomic, strong) NSArray    * poi;


@end
