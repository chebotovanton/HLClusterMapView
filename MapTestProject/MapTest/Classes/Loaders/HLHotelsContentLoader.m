//
//  HLSearchLoader.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/13/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLHotelsContentLoader.h"
#import "HLSearchInfo.h"
#import "HLHotel.h"
#import "HLCity.h"
#import "NSDictionary+StringForKey.h"


@interface HLHotelsContentLoader ()
@end


@implementation HLHotelsContentLoader

- (NSArray *)processSuccessWithObject:(id)object
{

    NSMutableArray *hotels = [NSMutableArray array];
    for (NSDictionary *hotelDict in object) {
        if (![hotelDict isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        HLHotel *hotel = [HLHotel new];
        hotel.hotelId = [hotelDict stringForKey:@"id"];
        hotel.name = [hotelDict stringForKey:@"name"];
        hotel.address = [hotelDict stringForKey:@"address"];
        hotel.type = [[hotelDict objectForKey:@"propertyType"] integerValue];
        hotel.photosCount = [[hotelDict objectForKey:@"photoCount"] integerValue];
        hotel.rating = [[hotelDict objectForKey:@"rating"] integerValue];
        hotel.popularity = [[hotelDict objectForKey:@"popularity"] integerValue];
        hotel.stars = [[hotelDict objectForKey:@"stars"] integerValue];
        hotel.distance = [[hotelDict objectForKey:@"distance"] floatValue];
        hotel.fullAmenities = [hotelDict objectForKey:@"amenities"];
        hotel.amenities = [hotelDict objectForKey:@"amenitiesShort"];
        hotel.ordersCount = [[hotelDict objectForKey:@"ordersCount"] integerValue];
//        hotel.foursquareCheckinCount = [hotelDict objectForKey:@"4sqUsersCnt"];
        hotel.hasFoursquareTips = [[hotelDict objectForKey:@"hasFoursquareTips"] boolValue];
        
        hotel.scoring = [hotelDict objectForKey:@"scoring"];
#warning searchInfo
//        hotel.city = self.searchInfo.city;
        
        NSDictionary *locationDict = [hotelDict objectForKey:@"location"];
        if (locationDict && [locationDict isKindOfClass:[NSDictionary class]]) {
            hotel.latitude = [[locationDict objectForKey:@"lat"] floatValue];
            hotel.longitude = [[locationDict objectForKey:@"lon"] floatValue];
        }
        
        [hotels addObject:hotel];
    }
    return hotels;
}

@end
