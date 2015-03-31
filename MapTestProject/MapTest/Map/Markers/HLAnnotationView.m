//
//  HLAnnotationView.m
//  HotelLook
//
//  Created by Anton Chebotov on 20/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLAnnotationView.h"
#import "StringUtils.h"

@interface HLAnnotationView()
@end

@implementation HLAnnotationView

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	if(self){
		[self initialSetup];
	}
	return self;
}

#pragma mark -
#pragma mark Private

- (void) initialSetup
{
	self.translatesAutoresizingMaskIntoConstraints = NO;
	self.colorCircles = [NSMutableArray new];
	
	self.centerOffset = CGPointMake(0.0, -10.0);

	[self addBackgroundView];
	[self addPriceLabel];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationGreaterThanOrEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:31.0]];
}

- (void) addBackgroundView
{
	self.backgroundView = [UIView new];
	[self addSubview:self.backgroundView];
	self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
	
	UIImageView * leftView = [UIImageView new];
	UIImage * leftPinImage = [self.leftImage resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 4.0, 11.0, 5.0) resizingMode:UIImageResizingModeStretch];
	leftView.image = leftPinImage;
	leftView.translatesAutoresizingMaskIntoConstraints = NO;
	
	UIImageView * rightView = [UIImageView new];
	UIImage * rightPinImage = [self.rightImage resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 5.0, 11.0, 4.0) resizingMode:UIImageResizingModeStretch];
	rightView.image = rightPinImage;
	rightView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.backgroundView addSubview:leftView];
	[self.backgroundView addSubview:rightView];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:leftView
													 attribute:NSLayoutAttributeWidth
													 relatedBy:NSLayoutRelationEqual
														toItem:rightView
													 attribute:NSLayoutAttributeWidth
													multiplier:1.0
													  constant:0.0]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftView]-0-[rightView]-0-|"
																 options:0
																 metrics:nil
																   views:@{@"leftView":leftView, @"rightView":rightView}]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[leftView]-0-|"
																 options:0
																 metrics:nil
																   views:@{@"leftView":leftView}]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[rightView]-0-|"
																 options:0
																 metrics:nil
																   views:@{@"rightView":rightView}]];

	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundView]-0-|"
																 options:0
																 metrics:nil
																   views:@{@"backgroundView":self.backgroundView}]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundView]-0-|"
																 options:0
																 metrics:nil
																   views:@{@"backgroundView":self.backgroundView}]];

}

- (void) addPriceLabel
{
	_priceLabel = [UILabel new];
	self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.priceLabel.textColor = [UIColor darkTextColor];
	[self.backgroundView addSubview:self.priceLabel];
	
	[self.priceLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(>=1)]"
																			options:0
																			metrics:nil
																			  views:@{@"label":self.priceLabel}]];
	
	[self.priceLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[label(>=1)]"
																			options:0
																			metrics:nil
																			  views:@{@"label":self.priceLabel}]];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel
													 attribute:NSLayoutAttributeCenterY
													 relatedBy:NSLayoutRelationEqual
														toItem:self.backgroundView
													 attribute:NSLayoutAttributeCenterY
													multiplier:1.0
													  constant:-4.0]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=6)-[label]-(>=6)-|"
																 options:0
																 metrics:nil
																   views:@{@"label":self.priceLabel}]];
}

- (void) setupWithColors:(NSArray *)colors priceString:(NSString *)priceString
{
	if(!self.priceLabel){
		return;
	}
	for(UIView * circle in self.colorCircles){
		[circle removeFromSuperview];
	}
	[self.colorCircles removeAllObjects];
	
	self.priceLabel.text = priceString;
	
	UIView * leftBoundView = self.backgroundView;
	
	for(UIColor * color in colors){
		UIView * circle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 10.0)];
		circle.backgroundColor = color;
		[self addSubview:circle];
		circle.translatesAutoresizingMaskIntoConstraints = NO;
		circle.layer.cornerRadius = 5.0;
		[self.colorCircles addObject:circle];
		
//		circle size
		[circle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[circle(==11)]"
																				options:0
																				metrics:nil
																				  views:@{@"circle":circle}]];
		
		[circle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[circle(==11)]"
																				options:0
																				metrics:nil
																		 views:@{@"circle":circle}]];


//		vertical circle constraint
		[self addConstraint:[NSLayoutConstraint constraintWithItem:circle
														 attribute:NSLayoutAttributeCenterY
														 relatedBy:NSLayoutRelationEqual
															toItem:self.backgroundView
														 attribute:NSLayoutAttributeCenterY
														multiplier:1.0
														  constant:-2.5]];

//		left circle constraint
		if(leftBoundView == self.backgroundView){
			[self addConstraints:[NSLayoutConstraint
								 constraintsWithVisualFormat:@"H:|-5-[circle]"
								 options:0
								 metrics:nil
								 views:@{@"circle":circle}]];
		}
		else {
			[self addConstraint:[NSLayoutConstraint constraintWithItem:circle
															 attribute:NSLayoutAttributeLeft
															 relatedBy:NSLayoutRelationEqual
																toItem:leftBoundView
															 attribute:NSLayoutAttributeLeft
															multiplier:1.0
															  constant:5.0]];
		}

		leftBoundView = circle;
	}
// label constraint to last circle
	if(leftBoundView != self.backgroundView){
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftBound]-5-[label]"
																	 options:0
																	 metrics:nil
																	   views:@{@"leftBound":leftBoundView, @"label":self.priceLabel}]];
	}
}


@end
