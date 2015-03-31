//
//  HLHotelCalloutView.m
//  HotelLook
//
//  Created by Anton Chebotov on 10/4/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLHotelCalloutView.h"
#import "StringUtils.h"
#import "HLRoom.h"
#import "HLStatKeeper.h"
#import "UIView+DrawStars.h"
#import "HLCellDotActivityIndicator.h"

@interface HLHotelCalloutView(){
	NSArray * stars;
}

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * ratingLabel;
@property (nonatomic, weak) IBOutlet UILabel * distanceLabel;

@property (nonatomic, weak) IBOutlet UILabel * roomNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * partnerLabel;
@property (nonatomic, weak) IBOutlet UILabel * priceLabel;
@property (nonatomic, weak) IBOutlet UILabel * noRoomsLabel;

@property (nonatomic, strong) HLCellDotActivityIndicator * activityIndicator;

@end

@implementation HLHotelCalloutView

- (void) setVariant:(HLResultVariant *)variant
{	
	_variant = variant;
	_nameLabel.text = _variant.hotel.name;
	_ratingLabel.text = [StringUtils longRatingStringWithRating:_variant.hotel.rating];
	_distanceLabel.text = [StringUtils longDistanceStringWithHotel:_variant.hotel city:_variant.searchInfo.city];
	
	[self addActivityIndicator];
	
	NSArray * sortedRooms = variant.sortedRooms;
	
	self.noRoomsLabel.hidden = YES;
	self.roomNameLabel.hidden = YES;
	self.priceLabel.hidden = YES;
	self.partnerLabel.hidden = YES;
	self.noRoomsLabel.hidden = YES;
	self.activityIndicator.hidden = YES;
	
	if (sortedRooms.count > 0) {
		HLRoom * room = sortedRooms[0];

		_roomNameLabel.text = [StringUtils roomNameWithRoom:room];
		_partnerLabel.text = room.gateName;

		_priceLabel.attributedText = [StringUtils attributedPriceStringWithPrice:room.price.integerValue currency:_variant.searchInfo.currency font:_priceLabel.font];
		_roomNameLabel.hidden = NO;
		_priceLabel.hidden = NO;
		_partnerLabel.hidden = NO;
	} else {
		_noRoomsLabel.hidden = NO;
		_noRoomsLabel.text = LS(@"HL_LOC_CALLOUT_SORRY_NO_ROOMS_AVAILABLE");
	}
	[self drawStars];
}

- (void) addActivityIndicator
{
	if(self.activityIndicator == nil){
		self.activityIndicator = [HLCellDotActivityIndicator new];
		[self addSubview:self.activityIndicator];
	}
	self.activityIndicator.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 25.0);
}

- (void) drawStars
{
	for( UIView * subview in stars){
		[subview removeFromSuperview];
	}
	UIImage * activeImage = [UIImage imageNamed:@"star"];
	stars = [self drawStars:_variant.hotel.stars fromPoint:CGPointMake(15.0, 10.0) activeImage:activeImage offset:17.0];
}

#pragma mark -
#pragma mark Actions

- (IBAction)showFullInfo
{
	[_delegate showFullHotelInfo:_variant];
}
@end
