//
//  ADMapCluster.h
//  ADClusterMapView
//
//  Created by Patrick Nollet on 27/06/11.
//  Copyright 2011 Applidium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ADMapPointAnnotation.h"

@interface ADMapCluster : NSObject
@property (nonatomic) CLLocationCoordinate2D clusterCoordinate;
@property (weak, nonatomic, readonly) NSString * title;
@property (weak, nonatomic, readonly) NSString * subtitle;
@property (nonatomic, strong) ADMapPointAnnotation * annotation;
@property (weak, nonatomic, readonly) NSMutableArray * originalAnnotations;
@property (nonatomic, readonly) NSInteger depth;
@property (nonatomic, assign) BOOL showSubtitle;

@property (nonatomic, assign) CGSize annotationCollapseSize;

#warning azaza
@property (nonatomic, assign) ADMapCluster * ancestor;


- (id)initWithAnnotations:(NSArray *)annotations atDepth:(NSInteger)depth inMapRect:(MKMapRect)mapRect gamma:(double)gamma clusterTitle:(NSString *)clusterTitle showSubtitle:(BOOL)showSubtitle;
+ (ADMapCluster *)rootClusterForAnnotations:(NSArray *)annotations gamma:(double)gamma clusterTitle:(NSString *)clusterTitle showSubtitle:(BOOL)showSubtitle;
- (NSArray *)findChildrenInMapRect:(MKMapRect)mapRect mapViewSize:(CGSize)mapViewSize;
- (NSArray *)find:(NSInteger)N childrenInMapRect:(MKMapRect)mapRect;
- (NSArray *)children;
- (BOOL)isAncestorOf:(ADMapCluster *)mapCluster;
- (BOOL)isRootClusterForAnnotation:(id<MKAnnotation>)annotation;
- (NSInteger)numberOfChildren;
- (NSArray *)namesOfChildren;
- (CLLocationCoordinate2D) anyCoordinate;
@end
