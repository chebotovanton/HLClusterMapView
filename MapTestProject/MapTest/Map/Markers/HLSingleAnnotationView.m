//
//  HLSingleAnnotationView.m
//  HotelLook
//
//  Created by Anton Chebotov on 25/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLSingleAnnotationView.h"
#import "HLHotelCalloutView.h"
#import "StringUtils.h"

#define HL_CALLOUT_ANIMATION_DURATION 0.2f

@interface HLSingleAnnotationView ()
@property (nonatomic, strong) HLHotelCalloutView * calloutContentView;
@property (nonatomic, strong) NSMutableArray * calloutConstraints;
@end

@implementation HLSingleAnnotationView

- (void) initialSetup
{
	self.leftImage = [UIImage imageNamed:@"pinImageLeft.png"];
	self.rightImage = [UIImage imageNamed:@"pinImageRight.png"];
	[super initialSetup];
}

- (void) setAnnotation:(id<MKAnnotation>)annotation
{
	[super setAnnotation:annotation];
	
	HLMapAnnotation * mapAnnotation = [(ADClusterAnnotation *)annotation originalAnnotations][0];
	if(![mapAnnotation isKindOfClass:[HLMapAnnotation class]]){
		return;
	}
	HLResultVariant * variant = mapAnnotation.variant;
	
	NSString * priceString = [StringUtils priceStringWithVariant:variant];
    NSMutableArray * colors = [NSMutableArray new];
    for(HLPopularHotelBadge * badge in variant.badges){
        [colors addObject:badge.color];
    }
	[self setupWithColors:colors priceString:priceString];
}

- (void) hidePinContent
{
	self.priceLabel.alpha = 0.0;
	for(UIView * circle in self.colorCircles){
		circle.alpha = 0.0;
	}
}

- (void) showPinContent
{
	self.priceLabel.alpha = 1.0;
	for(UIView * circle in self.colorCircles){
		circle.alpha = 1.0;
	}
}

- (void) addCalloutContent
{
	HLMapAnnotation * mapAnnotation = [(ADClusterAnnotation *)self.annotation originalAnnotations][0];
	if(![mapAnnotation isKindOfClass:[HLMapAnnotation class]]){
		return;
	}
	HLResultVariant * variant = mapAnnotation.variant;
	[self.calloutContentView setVariant:variant];
	
	self.calloutConstraints = [NSMutableArray new];
	[self.calloutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[calloutView]-15-|"
																						 options:0
																						 metrics:nil
																						   views:@{@"calloutView":self.calloutContentView}]];
	
	[self.calloutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[calloutView]-5-|"
																 options:0
																 metrics:nil
																   views:@{@"calloutView":self.calloutContentView}]];
	
	[self.calloutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[calloutView(==250)]"
																 options:0
																 metrics:nil
																   views:@{@"calloutView":self.calloutContentView}]];
	
	[self addConstraints:self.calloutConstraints];
	[self layoutIfNeeded];
	
	self.centerOffset = CGPointMake(0.0, -self.calloutContentView.frame.size.height/2.0);
}

- (void) removeCalloutContent
{
	[self removeConstraints:self.calloutConstraints];
	[self layoutIfNeeded];
	self.centerOffset = CGPointMake(0.0, -10.0);
}

- (void) showCalloutContent
{
	self.calloutContentView.alpha = 1.0;
}

- (void) hideCalloutContent
{
	self.calloutContentView.alpha = 0.0;
}

#pragma mark -
#pragma mark Public

- (void) expandAnimated:(BOOL)animated
{
#warning azazaz
//	self.calloutContentView = LOAD_VIEW_FROM_NIB_NAMED(@"HLHotelCalloutView");
	self.calloutContentView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.backgroundView addSubview:self.calloutContentView];
	self.calloutContentView.alpha = 0.0;
	
	CGFloat delay = 0.0;
	
	NSLog(@"Expand animation started");
	
	CGFloat duration = animated ? HL_CALLOUT_ANIMATION_DURATION : 0.0;
	[UIView animateWithDuration:duration
						  delay:delay
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews |UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self hidePinContent];
					 }
					 completion:^(BOOL finished) {
					 }];
	delay += duration;
	
	[UIView animateWithDuration:duration
						  delay:delay
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews |UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self addCalloutContent];
					 }
					 completion:^(BOOL finished) {
					 }];
	delay += duration;
	
	[UIView animateWithDuration:duration
						  delay:delay
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews |UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self showCalloutContent];
					 }
					 completion:^(BOOL finished) {
						 NSLog(@"Expand animation finished: %d", finished);
					 }];
}

- (void) collapseAnimated:(BOOL)animated
{
	CGFloat duration = animated ? HL_CALLOUT_ANIMATION_DURATION : 0.0;
	CGFloat delay = 0.0;
	
	NSLog(@"Collapse animation started");
	
	[UIView animateWithDuration:duration
						  delay:delay
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews |UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self hideCalloutContent];
					 }
					 completion:^(BOOL finished) {
					 }];
	delay += duration;
	
	[UIView animateWithDuration:duration
						  delay:delay
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews |UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self removeCalloutContent];
					 }
					 completion:^(BOOL finished) {
					 }];
	delay += duration;

	[UIView animateWithDuration:duration
						  delay:delay
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionLayoutSubviews |UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [self showPinContent];
					 }
					 completion:^(BOOL finished) {
						 NSLog(@"Collapse animation finished: %d", finished);
						 [self.calloutContentView removeFromSuperview];
					 }];
}

@end
