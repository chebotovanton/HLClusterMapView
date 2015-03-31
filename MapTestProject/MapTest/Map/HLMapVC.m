//
//  HLMapVC.m
//  HotelLook
//
//  Created by Anton Chebotov on 7/15/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLMapVC.h"
#import "HLCity.h"
#import "HLResultVariant.h"
#import "HLVariantsMapView.h"
#import "HLAnnotationView.h"
#import "HLSingleAnnotationView.h"
#import "HLGroupAnnotationView.h"
#import "HLSearchInfo.h"
#import "HLVariantsManager.h"

#define HL_MAP_CALLOUT_ANIMATION_DURATION 0.2f
#define HL_MAP_LOCATE_ME_ANIMATION_DURATION 0.2f


@interface HLMapVC () <HLMapViewDelegate>

@property (nonatomic, strong) NSArray *variants;

@property (nonatomic, strong) HLSingleAnnotationView * selectedAnnotationView;

@property (nonatomic, strong) HLGroupCalloutView * groupCallout;

@property (nonatomic, weak) IBOutlet HLVariantsMapView * resultMapView;
@property (nonatomic, weak) IBOutlet UIButton * locateMeButton;

- (IBAction)locateMeAction;

@end


@implementation HLMapVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	_resultMapView.mapViewDelegate = self;
	
#warning azaz
//	_groupCallout = LOAD_VIEW_FROM_NIB_NAMED(@"HLGroupCalloutView");
	_groupCallout.delegate = self;
	[_groupCalloutBackground addSubview:_groupCallout];
	
	[self updateLocationControls];
	
	self.resultMapView.delegate = self;
    
//    NSArray * variants = [self createFakeVariants];
//    [self.resultMapView setupWithFilteredVariants:variants];
    NSArray * variants = [[HLVariantsManager new] loadSavedVariants];
    [self.resultMapView setupWithFilteredVariants:variants];
}

- (NSArray *) createFakeVariants
{
    NSMutableArray * result = [NSMutableArray new];
    
    [result addObject:[self variantWithLatitude:55.0 longitude:73.0 name:@"hotel 1" price:@10000]];
    [result addObject:[self variantWithLatitude:55.0 longitude:73.1 name:@"hotel 2" price:@999999999]];
    
    return result;
}

- (HLResultVariant *) variantWithLatitude:(CGFloat)latitude
                                longitude:(CGFloat)longitude
                                     name:(NSString *)name
                                    price:(NSNumber *)price
{
    HLResultVariant * variant = [HLResultVariant new];
    HLHotel * hotel = [HLHotel new];
    hotel.latitude = latitude;
    hotel.longitude = longitude;
    hotel.name = name;
    variant.hotel = hotel;
    
    HLRoom * room = [HLRoom new];
    room.price = price;
    variant.rooms = [@[room] mutableCopy];

    return variant;
}

- (void)setSearchInfo:(HLSearchInfo *)searchInfo
{
	_searchInfo = searchInfo;
	[self updateLocationControls];
}

- (void)setupWithMinPrice:(CGFloat)minPrice maxPrice:(CGFloat)maxPrice zoom:(CGFloat)zoom variants:(NSArray *)variants
{
	self.initialMapZoom = zoom;
	[self.resultMapView setupWithFilteredVariants:variants];
}

- (void) showUserLocation
{
	[self.resultMapView setRegionForUserLocation];
	self.locateMeButton.selected = YES;

}

- (void) showCity
{
	[self.resultMapView showCity:self.searchInfo.city];
}

- (HLResultVariant *) variantWithHotel:(HLHotel *)hotel inVariants:(NSArray *)variants
{
	for (HLResultVariant * variant in variants) {
		if ([variant.hotel isEqual:hotel]) {
			return variant;
		}
	}
    
	return nil;
}

#pragma mark -
#pragma mark Public

- (void) showVisibleVariants:(NSArray *)variants
{
	[self.resultMapView setRegionForVariants:variants];
}

- (void) variantsManagerStarted
{
}

#pragma mark -
#pragma mark Locate Me Methods

- (IBAction)locateMeAction
{
	[self.resultMapView setRegionForUserLocation];
	self.locateMeButton.selected = YES;
}


- (void) updateLocationControls
{
    BOOL locationAvailable = YES;
	self.locateMeButton.hidden = !locationAvailable;
	self.resultMapView.showsUserLocation = locationAvailable;
}

#pragma mark -
#pragma mark HLHotelCalloutProtocol

- (void) showFullHotelInfo:(HLResultVariant *)variant
{
	[self mapAnnotationSelectedWithVariant:variant];
}

- (void) mapAnnotationSelectedWithVariant:(HLResultVariant *)variant
{
#warning Not implemented
//	[_resultsControllerDelegate showDetailsForVariant:variant scrollPhotoToIndex:0];
}

#pragma mark -
#pragma mark HLResultsVCDelegate methods

- (void)variantsFiltered:(NSArray *)variants allVariants:(NSArray *)allVariants
{	
	self.variants = variants;
	
    [self.resultMapView setupWithFilteredVariants:variants];

    if (variants.count == 0) {
        [self showCity];
    }
	
	[self.groupCallout setVariants:self.groupCallout.variants];
}

#pragma mark -
#pragma mark MKMapViewDelegate
- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
	if ([view.annotation isKindOfClass:[ADClusterAnnotation class]]) {
		ADClusterAnnotation * cluster = (ADClusterAnnotation *)view.annotation;
		NSArray * annotations = cluster.originalAnnotations;
		if(annotations.count > 1){
			NSMutableArray * variants = [NSMutableArray new];
			for(HLMapAnnotation * annotation in annotations){
				[variants addObject:annotation.variant];
			}
			[self.resultMapView setRegionForVariants:variants];
		}
		else {
			HLMapAnnotation * annotation = annotations[0];
			HLResultVariant * variant = annotation.variant;
			HLSingleAnnotationView * annView = (HLSingleAnnotationView *)view;
			[self.resultMapView centerOnVariant:variant];
			[annView expandAnimated:YES];
			self.selectedAnnotationView = annView;
		}
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	if(annotation == mapView.userLocation){
		MKAnnotationView * pin = [[MKAnnotationView alloc] init];
		pin.image = [UIImage imageNamed:@"userLocationPin.png"];
		return pin;
	}
	
	MKAnnotationView * pinView = [self singlePinViewForMapView:mapView annotation:annotation];
	return pinView;
}

- (MKAnnotationView *)mapView:(ADClusterMapView *)mapView viewForClusterAnnotation:(id<MKAnnotation>)annotation
{
	MKAnnotationView * pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:HL_MAP_GROUP_ANNOTATION_REUSE_IDENTIFIER];
	if (!pinView) {
		pinView =[[HLGroupAnnotationView alloc] initWithAnnotation:annotation
												   reuseIdentifier:HL_MAP_GROUP_ANNOTATION_REUSE_IDENTIFIER];
	}
	pinView.annotation = annotation;
	return pinView;
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	self.locateMeButton.selected = NO;
	[self.selectedAnnotationView collapseAnimated:YES];
	self.selectedAnnotationView = nil;
}

#pragma mark -
#pragma mark ADClusterMapViewDelegate

- (void)mapViewDidFinishClustering:(ADClusterMapView *)mapView
{
	NSLog(@"Annotations clusterizing done");
}

#pragma mark -
#pragma mark Private

- (MKAnnotationView *) singlePinViewForMapView:(MKMapView *)mapView annotation:(id<MKAnnotation>)annotation
{
	MKAnnotationView * pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:HL_MAP_ANNOTATION_REUSE_IDENTIFIER];
	if (!pinView) {
		pinView =[[HLSingleAnnotationView alloc] initWithAnnotation:annotation
													reuseIdentifier:HL_MAP_ANNOTATION_REUSE_IDENTIFIER];
		pinView.canShowCallout = NO;
	}
	pinView.annotation = annotation;
	return pinView;
}

@end