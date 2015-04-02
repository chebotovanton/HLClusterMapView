//
//  HLGroupAnnotationView.m
//  HotelLook
//
//  Created by Anton Chebotov on 25/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLGroupAnnotationView.h"
#import "StringUtils.h"

@interface HLGroupAnnotationView ()

@property (nonatomic, strong) NSArray * variants;
@end

@implementation HLGroupAnnotationView

- (void) initialSetup
{
	self.leftImage = [UIImage imageNamed:@"pinGroupImageLeft.png"];
	self.rightImage = [UIImage imageNamed:@"pinGroupImageRight.png"];
	[super initialSetup];
	self.priceLabel.textColor = [UIColor whiteColor];
}

- (void) setAnnotation:(id<MKAnnotation>)annotation
{
    if(self.annotation) {
        ADClusterAnnotation * clusterAnnotation = (ADClusterAnnotation *) self.annotation;
        [clusterAnnotation removeObserver:self forKeyPath:@"cluster"];
    }
	[super setAnnotation:annotation];
    ADClusterAnnotation * clusterAnnotation = (ADClusterAnnotation *) self.annotation;
    [clusterAnnotation addObserver:self forKeyPath:@"cluster" options:NSKeyValueObservingOptionNew context:NULL];
    [self update];
}

- (void) update
{
    HLResultVariant * bestVariant = nil;
    NSInteger bestPrice = UNKNOWN_MIN_PRICE;
    NSMutableArray * colors = [NSMutableArray new];
    
    ADClusterAnnotation * clusterAnnotation = (ADClusterAnnotation *)self.annotation;

    if(clusterAnnotation.cluster == nil) {
        return;
    }
    NSArray * originalAnnotations = clusterAnnotation.cluster.visibleOriginalAnnotations;

    for(HLMapAnnotation * mapAnnotation in originalAnnotations) {
        HLResultVariant * variant = mapAnnotation.variant;
        if(variant.minimalPrice < bestPrice){
            bestPrice = variant.minimalPrice;
            bestVariant = variant;
        }
        for(HLPopularHotelBadge * badge in variant.badges) {
            [colors addObject:badge.color];
        }
    }
    NSString * priceString = [StringUtils priceStringWithVariant:bestVariant];
    if(bestVariant.rooms.count > 0){
        priceString = [NSString stringWithFormat:@"%@ +", priceString];
    }
#warning azazaz    
    priceString = [NSString stringWithFormat:@"%li", originalAnnotations.count];
    [self setupWithColors:colors priceString:priceString];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self update];
}

@end
