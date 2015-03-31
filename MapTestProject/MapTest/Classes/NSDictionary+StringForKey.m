//
//  NSDictionary+StringForKey.m
//  HotelLook
//
//  Created by Oleg on 06/06/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "NSDictionary+StringForKey.h"


@implementation NSDictionary (StringForKey)

- (NSInteger)integerForKey:(id)key
{
    id object = [self objectForKey:key];
    if (object) {
        if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object integerValue];
        }
        
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object integerValue];
        }
    }
    
    return 0;
}

- (NSString *)stringForKey:(id)key
{
    id object = [self objectForKey:key];
    if (object) {
        if ([object isKindOfClass:[NSString class]]) {
            return object;
        }
        
        if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object stringValue];
        }
    }
    
    return @"";
}

- (NSDictionary *)dictForKey:(id)key
{
	id object = [self objectForKey:key];
	if ([object isKindOfClass:[NSDictionary class]]) {
		return object;
	}
	return nil;
}


@end


@implementation NSMutableDictionary (StringForKey)

- (NSString *)stringForKey:(id)key
{
    id object = [self objectForKey:key];
    if (object) {
        if ([object isKindOfClass:[NSString class]]) {
            return object;
        }
        
        if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object stringValue];
        }
    }
    
    return @"";
}

- (NSInteger)integerForKey:(id)key
{
    id object = [self objectForKey:key];
    if (object) {
        if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object integerValue];
        }
        
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object integerValue];
        }
    }
    
    return 0;
}

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) {
        return;
    }
    
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    } else {
        [self setObject:@"" forKey:aKey];
    }
}

- (NSDictionary *)dictForKey:(id)key
{
	id object = [self objectForKey:key];
	if ([object isKindOfClass:[NSDictionary class]]) {
			return object;
	}
	return nil;
}

@end