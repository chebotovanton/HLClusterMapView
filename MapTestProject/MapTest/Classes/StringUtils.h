//
//  StringUtils.h
//  HotelLook
//
//  Created by Anton Chebotov on 7/1/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLHotel.h"
#import "HLResultVariant.h"

@class HLCity;
@class HLCurrency;
@class HLReview;

@interface StringUtils : NSObject

+ (NSString *) roomNameWithRoom:(HLRoom *)room;

+ (NSString *) shortDateDescription:(NSDate *)date;
+ (NSString *) datesDescriptionWithCheckIn:(NSDate *)checkIn checkOut:(NSDate *)checkOut;

+ (NSString *) guestsDescriptionWithGuestsCount:(NSInteger)count;
+ (NSString *)kidAgeTextWithAge:(NSInteger)age;

+ (NSString *) durationDescriptionWithDays:(NSInteger)days;
+ (NSString *) intervalDescriptionWithDate:(NSDate *)start andDate:(NSDate *)finish;

+ (NSAttributedString *) attributedDistanceString:(CGFloat)distance;
+ (NSString *) distanceUnitAbbreviation;
+ (NSString *) shortDistanceStringWithKilometers:(CGFloat)kilometers;
+ (NSString *) longDistanceStringWithHotel:(HLHotel *)hotel city:(HLCity *)city;

+ (NSString *) checkInTextWithDate:(NSDate *)checkInTime;
+ (NSString *) checkOutTextWithDate:(NSDate *)checkOutTime;
+ (NSString *) checkInOutTimeDescription:(NSDate *)time;

+ (NSString *)cityNameByCity:(HLCity *)city;
+ (NSString *) cityNameDescriptionWithCity:(HLCity *)city;
+ (NSString *) countryAndStateStringForCity:(HLCity *)city;

+ (NSString *) searchInfoDescription:(HLSearchInfo *)searchInfo;

+ (NSString *) stringByStrippingHtmlFrom:(NSString *)string;

+ (NSAttributedString *)attributedNameAndDateWithReview:(HLReview *)review nameFont:(UIFont *)nameFont nameColor:(UIColor *)nameColor dateFont:(UIFont *)dateFont dateColor:(UIColor *)dateColor;
+ (NSAttributedString *) attributedRangeValueTextWithCurrency:(HLCurrency *)currency minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;
+ (NSAttributedString *) attributedPriceStringWithPrice:(NSInteger)price currency:(HLCurrency *)currency font:(UIFont *)font;
+ (NSString *) priceStringWithVariant:(HLResultVariant *)variant;
+ (NSString *) formattedNumberStringWithNumber:(NSInteger)number;

+ (NSString *) letterStringForIndex:(NSInteger)index;

+ (NSString *) getOptionsStringWithOptions:(NSDictionary *)options;

+ (NSAttributedString *) attributedRatingString:(NSInteger)rating;
+ (NSString *) shortRatingStringWithRating:(NSInteger)rating;
+ (NSString *) longRatingStringWithRating:(NSInteger)rating;
	
+ (NSString *) hotelsCountDescriptionWithHotels:(NSInteger)count;
+ (NSString *) filteredHotelsDescriptionWithFiltered:(NSInteger)filtered total:(NSInteger)total;

+ (NSAttributedString *) formattedLogoTextWithFontSize:(CGFloat)fontSize;

+ (NSString *)rateUsSubjectStringWithStarsCount:(NSInteger)starsCount;

+ (NSString *)aiMd5FromString:(NSString *)source;

+ (NSDictionary *) paramsFromUrlAbsoluteString:(NSString *)urlString;
@end
