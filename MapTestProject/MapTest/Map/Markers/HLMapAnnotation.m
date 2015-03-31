//
//  HLMapAnnotation.m
//  HotelLook
//
//  Created by Anton Chebotov on 18/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLMapAnnotation.h"

@implementation HLMapAnnotation

- (id) initWithVariant:(HLResultVariant *)variant
{
	self = [super init];
	if(self){
		self.variant = variant;
	}
	return self;
}

- (void) setVariant:(HLResultVariant *)variant
{
	_variant = variant;
	self.coordinate = CLLocationCoordinate2DMake(variant.hotel.latitude, variant.hotel.longitude);
	self.title = [NSString stringWithFormat:@"%ld", (long)self.variant.minimalPrice];
}

@end
