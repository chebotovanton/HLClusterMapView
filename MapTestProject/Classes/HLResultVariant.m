//
//  HLResultVariant.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/24/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLResultVariant.h"
#import "HLHotelsManager.h"
#import "HLHotelUtils.h"
#import "HLVariantsSorter.h"
#import "HLHotel.h"
#import "HLCity.h"
#import "HLSearchInfo.h"
#import "HLRoom.h"
#import "HLCurrency.h"
#import "HLManagedVariant.h"
#import "HLMenuManager.h"


@implementation HLPopularHotelBadge
+ (id) badgeWithName:(NSString *)name color:(UIColor *)color icon:(UIImage *)icon
{
    HLPopularHotelBadge * badge = [HLPopularHotelBadge new];
    if(badge) {
        badge.name = name;
        badge.color = color;
        badge.icon = icon;
    }
    return badge;
}

- (BOOL) isEqual:(id)object
{
    if(![object isKindOfClass:[HLPopularHotelBadge class]]){
        return NO;
    }
    HLPopularHotelBadge * otherBadge = (HLPopularHotelBadge *)object;
    return [otherBadge.name isEqualToString:self.name];
}
@end



@interface HLResultVariant()
@property (atomic, strong) NSLock *lock;

@end


@implementation HLResultVariant

+ (instancetype)resultVariantByManagedVariant:(HLManagedVariant *)managedVariant
{
    HLResultVariant *variant = [HLResultVariant new];
    variant.lastUpdate = managedVariant.lastUpdate;
    variant.minimalPrice = [managedVariant.minimalPrice integerValue];
    variant.duration = [managedVariant.duration integerValue];
    variant.searchInfo = [HLSearchInfo searchInfoByManagedSearchInfo:managedVariant.searchInfo];
    variant.hotel = [HLHotel hotelByManagedHotel:managedVariant.hotel];\
    
    NSMutableArray *rooms = [NSMutableArray array];
    for (HLManagedRoom *managedRoom in managedVariant.rooms) {
        [rooms addObject:[HLRoom roomByManagedRoom:managedRoom]];
    }
    variant.rooms = rooms;
    
    return variant;
}

- (id)init
{
	self = [super init];
	if (self) {
		self.rooms = [NSMutableArray new];
		self.minimalPrice = UNKNOWN_MIN_PRICE;
		self.distanceToCurrentLocationPoint = 0.0f;
        self.lock = [NSLock new];
        self.badges = [NSMutableArray new];
        _filteredRooms = [self.rooms mutableCopy];
	}
    
	return self;
}

- (BOOL)isEqual:(id)object
{
    HLResultVariant *otherVariant = (HLResultVariant *)object;
	if (!otherVariant) {
		return NO;
	}
    
	if (![otherVariant isKindOfClass:[HLResultVariant class]]) {
		return NO;
	}
    
	if (![self.hotel isEqual:otherVariant.hotel]) {
		return NO;
	}
    
	if (![self.searchInfo isEqual:otherVariant.searchInfo]) {
		return NO;
	}
    
	return YES;
}


#pragma mark -
#pragma mark Public

- (BOOL)isOutdate
{
    HLCurrency *currency = [HLMenuManager shared].searchInfo.currency;
	if (![self.searchInfo.currency isEqual:currency]){
		return YES;
	}
    
	if (!self.lastUpdate) {
		return YES;
	}
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.lastUpdate];
    if (interval >= HL_FAVOURITE_LIFETIME) {
        return YES;
    }
    
	return NO;
}

- (void)outdate
{
    self.lastUpdate = nil;
	self.rooms = nil;
	self.minimalPrice = UNKNOWN_MIN_PRICE;
}

- (void)dropRoomsFiltering
{
    [self.lock lock];
    
    _filteredRooms = [self.rooms mutableCopy];
    [self calculateMinPrice];
    
    [self.lock unlock];
}

- (void)setRooms:(NSMutableArray *)newRooms
{
	_rooms = newRooms;
    
	[self dropRoomsFiltering];
}

- (void)addRoom:(HLRoom *)room
{
    if (!self.rooms) {
        _rooms = [NSMutableArray new];
    }
    
    [self.rooms addObject:room];
    
    [self dropRoomsFiltering];
}

- (void)addRooms:(NSArray *)newRooms
{
    if (!self.rooms) {
        _rooms = [NSMutableArray new];
    }
    
    [self.rooms addObjectsFromArray:newRooms];
    
    [self dropRoomsFiltering];
}

- (NSInteger) countRoomsWithBreakfast
{
    NSInteger count = 0;
    for(HLRoom * room in self.rooms)
    {
        if([[room.options objectForKey:@"breakfast"] integerValue]){
            count ++;
        }
    }
    return count;
}

- (NSInteger) countRoomsWithRefundable
{
    NSInteger count = 0;
    for(HLRoom * room in self.rooms)
    {
        if([[room.options objectForKey:@"refundable"] integerValue]){
            count ++;
        }
    }
    return count;
}

- (void)filterRoomsWithOptions:(NSArray *)options
{
    NSMutableArray *array = [self.rooms mutableCopy];
	NSIndexSet *indexesToBeRemoved = [array indexesOfObjectsPassingTest:^BOOL(HLRoom * room, NSUInteger idx, BOOL *stop) {
        
        for(NSString * option in options){
            if (![[room.options objectForKey:option] integerValue]) {
                return YES;
            }
        }
        return NO;
	}];
	
	[array removeObjectsAtIndexes:indexesToBeRemoved];
    
    [self.lock lock];
    
    _filteredRooms = array;
    [self calculateMinPrice];
    
    [self.lock unlock];
}

- (NSArray *)sortedRooms
{
	return [HLVariantsSorter sortRoomsByPrice:self.filteredRooms];
}


#pragma mark -
#pragma mark Private

- (void)calculateMinPrice
{    
	self.minimalPrice = UNKNOWN_MIN_PRICE;
	for (HLRoom *room in self.filteredRooms) {
		self.minimalPrice = MIN(self.minimalPrice, [room.price integerValue]);
	}    
}


#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lastUpdate forKey:@"lastUpdate"];
	[aCoder encodeObject:self.searchInfo forKey:@"searchInfo"];
	[aCoder encodeObject:self.rooms forKey:@"rooms"];
    [aCoder encodeObject:self.hotel forKey:@"hotel"];
    
	[aCoder encodeInteger:self.minimalPrice forKey:@"minimalPrice"];
    [aCoder encodeInteger:self.duration forKey:@"duration"];
	
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
        self.lastUpdate = [aDecoder decodeObjectForKey:@"lastUpdate"];
        self.searchInfo = [aDecoder decodeObjectForKey:@"searchInfo"];
        self.rooms = [aDecoder decodeObjectForKey:@"rooms"];
        self.hotel = [aDecoder decodeObjectForKey:@"hotel"];
		
		self.minimalPrice = [aDecoder decodeIntegerForKey:@"minimalPrice"];
        self.duration = [aDecoder decodeIntegerForKey:@"duration"];
	}
    
	return self;
}

@end
