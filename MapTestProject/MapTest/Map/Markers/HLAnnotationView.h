//
//  HLAnnotationView.h
//  HotelLook
//
//  Created by Anton Chebotov on 20/11/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "HLResultVariant.h"
#import "HLMapAnnotation.h"

#define HL_MAP_ANNOTATION_REUSE_IDENTIFIER @"singleAnnotationView"
#define HL_MAP_GROUP_ANNOTATION_REUSE_IDENTIFIER @"groupAnnotationView"

@interface HLAnnotationView : MKAnnotationView
{
	
}
@property (strong, nonatomic) UIView * backgroundView;
@property (strong, nonatomic) UIImage * leftImage;
@property (strong, nonatomic) UIImage * rightImage;
@property (strong, nonatomic, readonly) UILabel * priceLabel;
@property (strong, nonatomic) NSMutableArray * colorCircles;

- (void) initialSetup;
- (void) setupWithColors:(NSArray *)colors priceString:(NSString *)priceString;
@end
