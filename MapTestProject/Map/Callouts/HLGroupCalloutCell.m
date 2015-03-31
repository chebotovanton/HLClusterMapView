//
//  HLGroupCalloutCell.m
//  HotelLook
//
//  Created by Anton Chebotov on 24/02/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLGroupCalloutCell.h"
#import "StringUtils.h"
#import "UIView+DrawStars.h"
#import "HLRoom.h"
#import "HLCellDotActivityIndicator.h"

@interface HLGroupCalloutCell ()
{
	NSArray * stars;
}
@property (weak) IBOutlet UILabel * nameLabel;
@property (weak) IBOutlet UILabel * ratingLabel;
@property (weak) IBOutlet UILabel * distanceLabel;

@property (weak) IBOutlet UILabel * roomNameLabel;
@property (weak) IBOutlet UILabel * partnerLabel;
@property (weak) IBOutlet UILabel * priceLabel;
@property (weak) IBOutlet UILabel * noRoomsLabel;

@property (weak) IBOutlet UIView * whiteBackground;

@end


@implementation HLGroupCalloutCell

- (void) setHighlighted:(BOOL)highlighted
{
	if(highlighted){
		_whiteBackground.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
	}
	else{
		_whiteBackground.backgroundColor = [UIColor whiteColor];
	}
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[self setHighlighted:highlighted];
}

- (void) setupWithVariant:(HLResultVariant *)variant
{
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
	_nameLabel.text = variant.hotel.name;
	_ratingLabel.text = [StringUtils longRatingStringWithRating:variant.hotel.rating];
	_distanceLabel.text = [StringUtils longDistanceStringWithHotel:variant.hotel city:variant.searchInfo.city];
	
	self.noRoomsLabel.hidden = YES;
	self.roomNameLabel.hidden = YES;
	self.priceLabel.hidden = YES;
	self.partnerLabel.hidden = YES;
	self.noRoomsLabel.hidden = YES;
	
	if(variant.rooms.count > 0){
		HLRoom * room = variant.rooms[0];
		
		_roomNameLabel.text = [StringUtils roomNameWithRoom:room];
		_partnerLabel.text = room.gateName;
		
		_priceLabel.attributedText = [StringUtils attributedPriceStringWithPrice:room.price.integerValue currency:variant.searchInfo.currency font:_priceLabel.font];
		
		_roomNameLabel.hidden = NO;
		_priceLabel.hidden = NO;
		_partnerLabel.hidden = NO;
	}
	else{
		_noRoomsLabel.hidden = NO;
		_noRoomsLabel.text = LS(@"HL_LOC_CALLOUT_SORRY_NO_ROOMS_AVAILABLE");
	}
	[self drawStarsWithCount:variant.hotel.stars];
}

- (void) drawStarsWithCount:(NSInteger)count
{
	for( UIView * subview in stars){
		[subview removeFromSuperview];
	}
	UIImage * activeImage = [UIImage imageNamed:@"star"];
	stars = [self drawStars:count fromPoint:CGPointMake(15.0, 10.0) activeImage:activeImage offset:17.0];
}
@end
