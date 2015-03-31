//
//  HLSearchManager.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/24/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLVariantsManager.h"
#import "HLSearchInfo.h"
#import "HLRoom.h"
#import "HLResultVariant.h"
#import "HLDistanceCalculator.h"
#import "DateUtil.h"
#import "HLAbstractRoomsLoader.h"
#import "HLHotelsContentLoader.h"

@interface HLVariantsManager()

@property (nonatomic, strong) HLHotelsContentLoader *hotelsLoader;
@property (nonatomic, strong) HLAbstractRoomsLoader *searchLoader;

@property (nonatomic, strong) NSDictionary * roomsPortion;
@property (nonatomic, strong) NSArray * hotels;

@end


@implementation HLVariantsManager

#pragma mark -
#pragma mark Public

- (NSArray *) loadSavedVariants
{
    NSString * fileName = [[NSBundle mainBundle] pathForResource:@"rooms.json" ofType:nil];
    NSData * data = [NSData dataWithContentsOfFile:fileName];
    NSError * error = nil;
    NSDictionary * roomsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.searchLoader = [HLAbstractRoomsLoader new];
    self.roomsPortion = [self.searchLoader processRoomsWithObject:roomsDict];

    fileName = [[NSBundle mainBundle] pathForResource:@"hotels.json" ofType:nil];
    data = [NSData dataWithContentsOfFile:fileName];
    error = nil;
    NSDictionary * hotelsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.hotelsLoader = [HLHotelsContentLoader new];
    self.hotels = [self.hotelsLoader processSuccessWithObject:hotelsDict];
    
    NSArray * variants = [self tryCollectingVariants];
    return variants;
}

#pragma mark -
#pragma mark Private

- (NSArray *) tryCollectingVariants
{
    if(!self.roomsPortion || !self.hotels){
        return nil;
    }
    
    NSArray * variants = [self createEmptyVariantsByHotels:self.hotels];
    [self fillVariants:variants withRoomsPortion:self.roomsPortion];
    return variants;
}

- (void)fillVariants:(NSArray *)variants withRoomsPortion:(NSDictionary *)portion
{
    for (NSString *key in portion) {
        
        @autoreleasepool {
			NSArray *rooms = [portion objectForKey:key];
            if (rooms && rooms.count) {
                HLResultVariant *variant = [self findVariantByHotelId:key inVariantsArray:variants];
                if (variant) {
                    [variant addRooms:rooms];
                } else {
                    NSLog(@"Hotel not found with id: %@", key);
                }
            }
        }
    }
}

- (HLResultVariant *)findVariantByHotelId:(NSString *)hotelId inVariantsArray:(NSArray *)variantsArray
{
    for (HLResultVariant *v in variantsArray) {
        if ([v.hotel.hotelId isEqualToString:hotelId]) {
            return v;
        }
    }
    
    return nil;
}

- (NSArray *)createEmptyVariantsByHotels:(NSArray *)hotels
{
    NSMutableArray *emptyVariants = [NSMutableArray array];
    for (HLHotel *hotel in hotels) {
        @autoreleasepool {
            HLResultVariant *variant = [HLResultVariant new];
            variant.lastUpdate = [NSDate date];
            variant.hotel = hotel;
            
            [variant setDuration:2];
            
            [emptyVariants addObject:variant];
        }
    }
    
    return emptyVariants;
}

@end
