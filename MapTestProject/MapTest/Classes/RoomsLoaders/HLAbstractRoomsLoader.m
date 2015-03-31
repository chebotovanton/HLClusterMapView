//
//  HLAbstractRoomsLoader.m
//  HotelLook
//
//  Created by Oleg on 12/05/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLAbstractRoomsLoader.h"
#import "HLRoom.h"

@implementation HLAbstractRoomsLoader

#pragma mark -
#pragma mark Private methods
- (NSDictionary *)processRoomsWithObject:(id)object
{
    NSMutableDictionary *collectedRooms = [NSMutableDictionary dictionary];
	
    NSDictionary *roomTypes = [object objectForKey:@"roomTypes"];
	NSDictionary *hotelsDict = object;
	
    if (hotelsDict && [hotelsDict isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in hotelsDict) {
            @autoreleasepool {
                NSArray *rawRooms = [hotelsDict objectForKey:key];
                NSMutableArray *rooms = [NSMutableArray array];
                for (NSDictionary *roomDict in rawRooms) {
                    HLRoom *room = [HLRoom new];
                    room.hotelId = key;
                    room.roomId = [roomDict objectForKey:@"roomId"];
                    room.roomDescription = [roomDict objectForKey:@"name"];
					room.price = [roomDict objectForKey:@"price"];
                    room.options = [roomDict objectForKey:@"options"];
                    room.gateId = [roomDict objectForKey:@"gateId"];
                    room.gateName = [roomDict objectForKey:@"gateName"];
                    room.internalTypeId = [roomDict objectForKey:@"internalTypeId"];
                    
                    if (room.internalTypeId && ![room.internalTypeId isKindOfClass:[NSNull class]]) {
                        room.type = [roomTypes objectForKey:room.internalTypeId];
                        if (!room.type) {
                            room.type = [roomTypes objectForKey:[room.internalTypeId stringValue]];
                        }
                    }
                    
                    [rooms addObject:room];
                }
                
                [collectedRooms setObject:rooms forKey:key];
            }
        }
    }
	
    return collectedRooms;
}

@end
