//
//  HLRoom.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/24/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLRoom.h"
#import "StringUtils.h"
#import "HLManagedRoom.h"


@implementation HLRoom

+ (instancetype)roomByManagedRoom:(HLManagedRoom *)managedRoom
{
    HLRoom *room = [HLRoom new];
    room.options = managedRoom.options;
    room.internalTypeId = managedRoom.internalTypeId;
    room.price = managedRoom.price;
    room.roomId = managedRoom.roomId;
    room.gateId = managedRoom.gateId;
    room.roomDescription = managedRoom.roomDescription;
    room.type = managedRoom.type;
    room.hotelId = managedRoom.hotel.hotelId;
    room.gateName = managedRoom.gateName;
    
    return room;
}

- (BOOL)isEqual:(id)object
{
    HLRoom *otherRoom = (HLRoom *)object;
	if (![object isKindOfClass:[HLRoom class]]) {
		return NO;
	}
	if (![_hotelId isEqualToString:otherRoom.hotelId]) {
		return NO;
	}
	if (![self.roomDescription isEqualToString:otherRoom.roomDescription]) {
		return NO;
	}
	if (![_gateId isEqualToNumber:otherRoom.gateId]) {
		return NO;
	}
	if (![_type isEqualToString:otherRoom.type]) {
		return NO;
	}
    if (![_internalTypeId isEqualToNumber:otherRoom.internalTypeId]) {
        return NO;
    }
    if (![_price isEqualToNumber:otherRoom.price]) {
		return NO;
	}
    
	return YES;
}

- (void)setInternalTypeId:(NSNumber *)internalTypeId
{
    if (![internalTypeId isKindOfClass:[NSNumber class]]) {
        _internalTypeId = nil;
    } else {
        _internalTypeId = internalTypeId;
    }
}

- (NSString *)getAvailableOption
{
	return [StringUtils getOptionsStringWithOptions:_options];
}


#pragma mark -
#pragma mark NSCoping

- (id)copyWithZone:(NSZone *)zone
{
    HLRoom *copyRoom = [HLRoom new];
    copyRoom.options = [self.options copy];
    copyRoom.internalTypeId = self.internalTypeId;
    copyRoom.price = self.price;
    copyRoom.roomId = self.roomId;
    copyRoom.roomDescription = self.roomDescription;
    copyRoom.type = self.type;
    copyRoom.gateId = self.gateId;
    copyRoom.hotelId = self.hotelId;
    copyRoom.gateName = self.gateName;
    
    return copyRoom;
}


#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_options forKey:@"options"];
    [aCoder encodeObject:_internalTypeId forKey:@"internalTypeId"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:self.roomDescription forKey:@"description"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_gateId forKey:@"partnerId"];
    [aCoder encodeObject:_hotelId forKey:@"hotelId"];
    [aCoder encodeObject:_gateName forKey:@"partnerName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.options = [aDecoder decodeObjectForKey:@"options"];
        self.internalTypeId = [aDecoder decodeObjectForKey:@"internalTypeId"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.roomDescription = [aDecoder decodeObjectForKey:@"description"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.gateId = [aDecoder decodeObjectForKey:@"partnerId"];
        self.hotelId = [aDecoder decodeObjectForKey:@"hotelId"];
        self.gateName = [aDecoder decodeObjectForKey:@"partnerName"];
    }
    
    return self;
}

@end
