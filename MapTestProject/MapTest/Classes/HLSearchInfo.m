//
//  HLSearchInfo.m
//  HotelLook
//
//  Created by Anton Chebotov on 6/7/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLSearchInfo.h"
#import "HLCity.h"
#import "HLCurrency.h"
#import "HLSearchInfo.h"
#import "DateUtil.h"

@implementation HLSearchInfo

- (id)init
{
	self = [super init];
	if(self){
		_adultsCount = 2;
		_kidAgesArray = [NSMutableArray new];
		_checkInDate = [DateUtil gmtTimeZoneResetTimeForDate:[NSDate date]];
		_checkOutDate = [DateUtil nextDayForDate:_checkInDate];

		NSLocale * locale = [NSLocale currentLocale];
		NSString * newCurrencyCode = [locale objectForKey:NSLocaleCurrencyCode];
	}
    
	return self;
}

- (BOOL)isEqual:(id)object
{
	if (!object) {
		return NO;
	}
	if (![object isKindOfClass:[HLSearchInfo class]]) {
		return NO;
	}
	
	HLSearchInfo *otherSearchInfo = (HLSearchInfo *)object;
    if (![_city isEqual:otherSearchInfo.city]) {
		return NO;
	}
	if (![_checkInDate isEqual:otherSearchInfo.checkInDate]) {
		return NO;
	}
	if (![_checkOutDate isEqual:otherSearchInfo.checkOutDate]) {
		return NO;
	}
    if (![_kidAgesArray isEqual:otherSearchInfo.kidAgesArray]) {
		return NO;
	}
	if (![_currency isEqual:otherSearchInfo.currency]) {
		return NO;
	}
	if (_adultsCount != otherSearchInfo.adultsCount) {
		return NO;
	}
    
	return YES;
}

- (BOOL)areDatesExpired
{
	return [self isCheckInDateExpired] || [self isCheckOutDateExpired];
}

- (BOOL) readyToSearch
{
	if(_adultsCount == 0){
		return NO;
	}
	if(_checkInDate == nil){
		return NO;
	}
	if(_checkOutDate == nil){
		return NO;
	}
	if(_city == nil || _city.cityId == nil){
		return NO;
	}
	return YES;
}

- (void) updateExpiredDates
{
	if([self isCheckInDateExpired]){
		_checkInDate = [DateUtil today];
		_checkOutDate = [DateUtil nextDayForDate:_checkInDate];
	}
	if([self isCheckOutDateExpired]){
		_checkOutDate = [DateUtil nextDayForDate:_checkInDate];
	}
}

- (BOOL) isCheckInDateExpired
{
	NSDate * now = [DateUtil resetTimeForDate:[NSDate date]];
	NSTimeInterval interval = [_checkInDate timeIntervalSinceDate:now];
	if(interval < 0){
		return YES;
	}
	return NO;
}

- (BOOL) isCheckOutDateExpired
{
	if(_checkOutDate == nil){
		return YES;
	}
	NSDate * nextDay = [DateUtil nextDayForDate:_checkInDate];
	NSTimeInterval interval = [_checkOutDate timeIntervalSinceDate:nextDay];
	if(interval < 0){
		return YES;
	}
	return NO;
}

- (void) setCurrency:(HLCurrency *)newCurrency
{
	if(newCurrency != nil){
		_currency = newCurrency;
	}
}

- (void) setCity:(HLCity *)city
{
    _city = city;
}

- (void) updateWithDictionary:(NSDictionary *)dict
{	
	id adults = [dict objectForKey:@"adults"];
	if(adults){
		int newAdultsCount = [adults intValue];
		_adultsCount = newAdultsCount;
		_kidAgesArray = [NSMutableArray new];
	}
	
	NSDateFormatter * formatter = [DateUtil sharedFormatter];
	[formatter setDateFormat:@"dd-MM-yyyy"];
	NSString * checkInString = [dict objectForKey:@"checkInDate"];
	if(checkInString.length > 0){
		NSDate * newCheckInDate = [formatter dateFromString:checkInString];
		_checkInDate = newCheckInDate;
	}
	
	NSString * checkOutString = [dict objectForKey:@"checkOutDate"];
	if(checkOutString.length > 0){
		NSDate * newCheckOutDate = [formatter dateFromString:checkOutString];
		_checkOutDate = newCheckOutDate;
	}
	[self updateExpiredDates];

	self.checkOutDate = [DateUtil dayInLessThan30DaysFromDate:self.checkInDate preferredDate:self.checkOutDate];
}

- (BOOL)isLocalSearchInfo
{
//	HLCity * localCity = [[HLCurrentCityDetector shared] currentCity];
//	if (![self.city isEqual:localCity]) {
//		return NO;
//	}
//    
//	if (![DateUtil isSameDay:self.checkInDate and:[DateUtil today]]) {
//		return NO;
//	}
//    
	return YES;
}

#pragma mark-
#pragma mark NSCoding Methods

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInteger:_adultsCount forKey:@"adultsCount"];
	[aCoder encodeObject:_kidAgesArray forKey:@"kidAgesArray"];
	[aCoder encodeObject:_checkInDate forKey:@"checkInDate"];
	[aCoder encodeObject:_checkOutDate forKey:@"checkOutDate"];
	[aCoder encodeObject:_city forKey:@"city"];
	[aCoder encodeObject:_currency forKey:@"currency"];
	[aCoder encodeObject:_language forKey:@"language"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [self init];
	if (self) {
		self.adultsCount = [aDecoder decodeIntegerForKey:@"adultsCount"];
		self.kidAgesArray = [aDecoder decodeObjectForKey:@"kidAgesArray"];
		self.checkInDate = [aDecoder decodeObjectForKey:@"checkInDate"];
		self.checkOutDate = [aDecoder decodeObjectForKey:@"checkOutDate"];
		self.language = [aDecoder decodeObjectForKey:@"language"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.currency = [aDecoder decodeObjectForKey:@"currency"];
	}
    
	return self;
}


#pragma mark-
#pragma mark NSCopying Methods

- (id)copy
{
	HLSearchInfo * searchInfo = [HLSearchInfo new];
	searchInfo.adultsCount = _adultsCount;
	searchInfo.kidAgesArray = [_kidAgesArray mutableCopy];
	searchInfo.checkInDate = [_checkInDate copy];
	searchInfo.checkOutDate = [_checkOutDate copy];
	searchInfo.city = [_city copy];
	searchInfo.currency = [_currency copy];
	searchInfo.language = [_language copy];
	searchInfo.token = [_token copy];
	
    return searchInfo;
}

- (id)copyWithZone:(NSZone *)zone
{
	HLSearchInfo * copy = [self copy];
	return copy;
}

@end
