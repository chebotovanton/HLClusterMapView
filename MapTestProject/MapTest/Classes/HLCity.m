//
//  HLManagedCity.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/12/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLCity.h"

@implementation HLCity


- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[HLCity class]]) {
		return NO;
	}    
	return [[(HLCity *)object cityId] isEqual:_cityId];
}


#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    HLCity * city = [HLCity new];
	city.name = [_name copy];
	city.fullName = [_fullName copy];
	city.country = [_country copy];
	city.state = [_state copy];
	city.iata = [_iata copy];
	city.cityId = [_cityId copy];
	city.latitude = [_latitude copy];
    city.longitude = [_longitude copy];
	city.hotelsCount = _hotelsCount;
    
    city.poi = [_poi copy];
	
	return city;
}


#pragma mark -
#pragma mark NSCoding Methods

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:_name forKey:@"name"];
	[coder encodeObject:_fullName forKey:@"fullName"];
	[coder encodeObject:_country forKey:@"country"];
	[coder encodeObject:_state forKey:@"state"];
	[coder encodeObject:_iata forKey:@"iata"];
	[coder encodeObject:_cityId forKey:@"cityId"];
	[coder encodeObject:_latitude forKey:@"latitude"];
    [coder encodeObject:_longitude forKey:@"longitude"];
	[coder encodeObject:_hotelsCount forKey:@"hotelsCount"];
    
    [coder encodeObject:_poi forKey:@"poi"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
		self.name = [coder decodeObjectForKey:@"name"];
		self.fullName = [coder decodeObjectForKey:@"fullName"];
		self.country = [coder decodeObjectForKey:@"country"];
		self.state = [coder decodeObjectForKey:@"state"];
		self.iata = [coder decodeObjectForKey:@"iata"];
		self.cityId = [coder decodeObjectForKey:@"cityId"];
		self.latitude = [coder decodeObjectForKey:@"latitude"];
        self.longitude = [coder decodeObjectForKey:@"longitude"];
		self.hotelsCount = [coder decodeObjectForKey:@"hotelsCount"];
        self.poi = [coder decodeObjectForKey:@"poi"];
    }
    
    return self;
}

@end
