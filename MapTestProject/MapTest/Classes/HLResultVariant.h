//
//  HLResultVariant.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/24/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLRoom.h"
#import "HLHotel.h"

@class HLManagedVariant;
@class HLSearchInfo;



#define UNKNOWN_MIN_PRICE INT32_MAX

typedef enum
{
    HLVariantLoadingState = 0,
    HLVariantRefreshState,
    HLVariantNoContentState,
    HLVariantNormalState,
	HLVariantOutdatedState,
} HLVariantState;

@interface HLPopularHotelBadge : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, strong) UIImage * icon;
+ (id) badgeWithName:(NSString *)name color:(UIColor *)color icon:(UIImage *)icon;
@end

@interface HLResultVariant : NSObject <NSCoding>

@property (atomic, strong, readonly)    NSMutableArray *filteredRooms;
@property (nonatomic, strong)           NSMutableArray *rooms;
@property (nonatomic, strong)           NSDate         *lastUpdate;
@property (nonatomic, strong)           HLHotel        *hotel;
@property (nonatomic, strong)           HLSearchInfo   *searchInfo;
@property (nonatomic, assign)           CGFloat        distanceToCurrentLocationPoint;
@property (nonatomic, assign)           NSInteger      minimalPrice;
@property (nonatomic, assign)           NSInteger      duration;
@property (nonatomic, assign, readonly) BOOL           isOutdate;
@property (nonatomic, strong)           NSMutableArray *badges;

- (void)outdate;
- (void)addRoom:(HLRoom *)room;
- (void)addRooms:(NSArray *)rooms;
- (void)dropRoomsFiltering;
- (void)filterRoomsWithOptions:(NSArray *)options;
- (NSArray *)sortedRooms;
- (void)calculateMinPrice;
- (NSInteger) countRoomsWithBreakfast;
- (NSInteger) countRoomsWithRefundable;

@end
