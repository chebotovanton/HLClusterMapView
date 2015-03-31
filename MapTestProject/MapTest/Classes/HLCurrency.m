//
//  HLCurrency.m
//  HotelLook
//
//  Created by Anton Chebotov on 9/27/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLCurrency.h"

@implementation HLCurrency

- (id) copy
{
	HLCurrency * currency = [HLCurrency new];
	currency.code = _code;
	currency.symbol = _symbol;
	currency.text = _text;
	currency.formatString = _formatString;
	
	return currency;
}

+ (HLCurrency *) currencyWithCode:(NSString *)code symbol:(NSString *)symbol text:(NSString *)text formatString:(NSString *)formatString
{
	HLCurrency * currency = [HLCurrency new];
	currency.code = code;
	currency.symbol = symbol;
	currency.text = text;
	currency.formatString = formatString;
	return currency;
}

- (BOOL) isEqual:(id)object
{
	if([object isKindOfClass:[HLCurrency class]] == NO){
		return NO;
	}
	HLCurrency * otherCurrency = (HLCurrency *)object;
	return [self.code isEqualToString:otherCurrency.code];
}

#pragma mark-
#pragma mark NSCoding Methods

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:_code forKey:@"code"];
	[aCoder encodeObject:_symbol forKey:@"symbol"];
	[aCoder encodeObject:_text forKey:@"text"];
	[aCoder encodeObject:_formatString forKey:@"formatString"];
	
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [self init];
	if(self){
		self.code = [aDecoder decodeObjectForKey:@"code"];
		self.symbol = [aDecoder decodeObjectForKey:@"symbol"];
		self.text = [aDecoder decodeObjectForKey:@"text"];
		self.formatString = [aDecoder decodeObjectForKey:@"formatString"];
	}
	return self;
}

@end
