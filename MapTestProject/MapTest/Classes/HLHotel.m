//
//  HLHotel.m
//  HotelLook
//
//  Created by Anton Chebotov on 31/10/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLHotel.h"
#import "HLCity.h"

@implementation HLHotel

+ (NSArray *)allAmenities
{
    return @[@"restaurant", @"parking", @"non-smoking", @"pets", @"tv", @"laundry", @"conditioning", @"internet", @"pool", @"fitness"];
}

- (BOOL)isEqual:(id)object{

	if (![object isKindOfClass:[HLHotel class]]) {
		return NO;
	}
    
	if (![[(HLHotel *)object hotelId] isEqualToString:self.hotelId]) {
		return NO;
	}
    
	return YES;
}


#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.chain forKey:@"chain"];
    [aCoder encodeObject:self.hotelId forKey:@"hotelId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.photoHash forKey:@"photoHash"];
    [aCoder encodeObject:self.hotelDescription forKey:@"description"];
    [aCoder encodeObject:self.checkInTime forKey:@"checkInTime"];
    [aCoder encodeObject:self.checkOutTime forKey:@"checkOutTime"];
    [aCoder encodeObject:self.fullAmenities forKey:@"fullAmenities"];
    [aCoder encodeObject:self.trustYouIfno forKey:@"trustYouIfno"];
    [aCoder encodeObject:self.amenities forKey:@"amenities"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.foursquareReviews forKey:@"foursquareReviews"];
    
    [aCoder encodeFloat:self.latitude forKey:@"latitude"];
    [aCoder encodeFloat:self.longitude forKey:@"longitude"];
    [aCoder encodeFloat:self.distance forKey:@"distance"];
    
	[aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeInteger:self.photosCount forKey:@"photosCount"];
    [aCoder encodeInteger:self.popularity forKey:@"popularity"];
    [aCoder encodeInteger:self.rating forKey:@"rating"];
    [aCoder encodeInteger:self.stars forKey:@"stars"];

    [aCoder encodeInteger:self.ordersCount forKey:@"ordersCount"];
    [aCoder encodeInteger:self.foursquareCheckinCount forKey:@"foursquareReviewsCount"];
    [aCoder encodeBool:self.hasFoursquareTips forKey:@"hasFoursquareTips"];
    [aCoder encodeObject:self.scoring forKey:@"scoring"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		self.address = [aDecoder decodeObjectForKey:@"address"];
        self.chain = [aDecoder decodeObjectForKey:@"chain"];
        self.hotelId = [aDecoder decodeObjectForKey:@"hotelId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.photoHash = [aDecoder decodeObjectForKey:@"photoHash"];
        self.hotelDescription = [aDecoder decodeObjectForKey:@"description"];
        self.checkInTime = [aDecoder decodeObjectForKey:@"checkInTime"];
        self.checkOutTime = [aDecoder decodeObjectForKey:@"checkOutTime"];
        self.fullAmenities = [aDecoder decodeObjectForKey:@"fullAmenities"];
        self.trustYouIfno = [aDecoder decodeObjectForKey:@"trustYouIfno"];
        self.amenities = [aDecoder decodeObjectForKey:@"amenities"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.foursquareReviews = [aDecoder decodeObjectForKey:@"foursquareReviews"];
        
		self.latitude = [aDecoder decodeFloatForKey:@"latitude"];
        self.longitude = [aDecoder decodeFloatForKey:@"longitude"];
        self.distance = [aDecoder decodeFloatForKey:@"distance"];
        
		self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.photosCount = [aDecoder decodeIntegerForKey:@"photosCount"];
        self.popularity = [aDecoder decodeIntegerForKey:@"popularity"];
        self.rating = [aDecoder decodeIntegerForKey:@"rating"];
        self.stars = [aDecoder decodeIntegerForKey:@"stars"];
        self.ordersCount = [aDecoder decodeIntegerForKey:@"ordersCount"];
        self.foursquareCheckinCount = [aDecoder decodeIntegerForKey:@"foursquareReviewsCount"];
        self.hasFoursquareTips = [aDecoder decodeBoolForKey:@"hasFoursquareTips"];
        
        self.scoring = [aDecoder decodeObjectForKey:@"scoring"];
	}
    
	return self;
}

@end
