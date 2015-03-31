//
//  HLRoom.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/24/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLRoom : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, strong) NSNumber     *internalTypeId;
@property (nonatomic, strong) NSNumber     *price;
@property (nonatomic, strong) NSNumber     *roomId;
@property (nonatomic, strong) NSNumber     *gateId;
@property (nonatomic, copy)   NSString     *roomDescription;
@property (nonatomic, copy)   NSString     *type;
@property (nonatomic, copy)   NSString     *hotelId;
@property (nonatomic, copy)   NSString     *gateName;

- (NSString *)getAvailableOption;

@end
