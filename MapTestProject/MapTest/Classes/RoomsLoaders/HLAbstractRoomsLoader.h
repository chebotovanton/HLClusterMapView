//
//  HLAbstractRoomsLoader.h
//  HotelLook
//
//  Created by Oleg on 12/05/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HLAbstractRoomsLoader : NSObject

- (NSDictionary *)processRoomsWithObject:(id)object;
@end
