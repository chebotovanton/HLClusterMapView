//
//  HLSearchLoader.h
//  HotelLook
//
//  Created by Anton Chebotov on 6/13/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLHotelsContentLoader;
@class HLSearchInfo;


@interface HLHotelsContentLoader : NSObject

- (NSArray *)processSuccessWithObject:(id)object;

@end
