//
//  NSDictionary+StringForKey.h
//  HotelLook
//
//  Created by Oleg on 06/06/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (StringForKey)

- (NSString *)stringForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (NSDictionary *)dictForKey:(id)key;
@end

@interface NSMutableDictionary (StringForKey)

- (NSString *)stringForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;
- (NSDictionary *)dictForKey:(id)key;

@end
