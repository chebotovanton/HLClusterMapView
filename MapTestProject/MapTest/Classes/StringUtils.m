//
//  StringUtils.m
//  HotelLook
//
//  Created by Anton Chebotov on 7/1/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "StringUtils.h"
#import "HLCity.h"
#import "HLLocaleInspector.h"
#import "HLDistanceCalculator.h"
#import "CommonCrypto/CommonDigest.h"
#import "DateUtil.h"
#import "HLLocaleInspector.h"
#import "HLSearchInfo.h"

@implementation StringUtils

+ (NSString *) roomNameWithRoom:(HLRoom *)room
{
	if(room.roomDescription.length){
		return room.roomDescription;
	}
	if(room.type.length){
		return room.type;
	}
	return @"";
}

+ (NSString *)shortDateDescription:(NSDate *)date language:(NSString *)language
{
	NSDateFormatter * formatter = [NSDateFormatter new];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	[formatter setLocale:[NSLocale localeWithLocaleIdentifier:language]];
	
    NSString * dayDesc = nil;
    NSString * template = @"";
    
	if ([[HLLocaleInspector sharedInspector] isLanguageRussian:language]) {
        template = @"EEdMMMM";
	} else {
        template = @"EEdMMMM";
	}
    template = [NSDateFormatter dateFormatFromTemplate:template options:0 locale:[NSLocale currentLocale]];
    formatter.dateFormat = template;
    dayDesc = [formatter stringFromDate:date];
    dayDesc = [[[dayDesc substringToIndex:1] uppercaseString] stringByAppendingString:[dayDesc substringFromIndex:1]];
    return dayDesc;
}

+ (NSString *)shortDateDescription:(NSDate *)date
{
	if (date == nil) {
		return @"…";
	}
	NSString *lang = [[HLLocaleInspector sharedInspector] language];
    return [self shortDateDescription:date language:lang];
}

+ (NSString *) datesDescriptionWithCheckIn:(NSDate *)checkIn checkOut:(NSDate *)checkOut language:(NSString *)lang
{
	return [NSString stringWithFormat:@"%@ – %@", [self shortDateDescription:checkIn language:lang], [self shortDateDescription:checkOut language:lang]];
}

+ (NSString *) datesDescriptionWithCheckIn:(NSDate *)checkIn checkOut:(NSDate *)checkOut
{
	NSString * lang = [[HLLocaleInspector sharedInspector] language];
	return [self datesDescriptionWithCheckIn:checkIn checkOut:checkOut language:lang];
}

+ (NSString *) guestsDescriptionWithGuestsCount:(NSInteger)count
{
//	NSString * format = SLPluralizedString(@"HL_LOC_GUEST", count, nil);
//	NSString * text = [NSString stringWithFormat:@"%li %@", (long)count, format];
//	return text;
    return @"azazaz";
}

+ (NSString *) kidAgeTextWithAge:(NSInteger)age
{
//    if (age == 0) {
//        return LS(@"HL_KIDS_PICKER_LESS_THAN_ONE_YEAR_TITLE");
//    }
//    
//    NSString *format = SLPluralizedString(@"HL_LOC_YEAR", age, nil);
//    NSString *text = [NSString stringWithFormat:@"%li %@", (long)age, format];
//    
//    return text;
    return @"azazaz";
}

+ (NSString *) durationDescriptionWithDays:(NSInteger)days
{
//	NSString * nightString = SLPluralizedString(@"HL_LOC_NIGHT", days, @"");
//	NSString * result = [NSString stringWithFormat:@"%li %@", (long)days, nightString];
//	result = [result uppercaseString];
//	return result;
    return @"azazaz";
}

+ (NSAttributedString *) attributedDistanceString:(CGFloat)distance
{
    return @"azazaz";
//    UIFont * textFont = [UIFont appRegularFontWithSize:12.0];
//    UIFont * numberFont = [UIFont appSemiboldFontWithSize:12.0];
//    UIColor * textColor = [UIColor lightGrayTextColor];
//    UIColor * numberColor = [UIColor appGrayColor];
//    
//    NSString * valueString = [StringUtils shortDistanceStringWithKilometers:distance];
//    NSAttributedString * attrValueString = [[NSAttributedString alloc] initWithString:valueString];
//    NSString *str = [NSString stringWithFormat:@"%@ %@", LS(@"HL_LOC_FILTER_TO_STRING"), @"lowerValue"];
//    NSMutableAttributedString *range = [[NSMutableAttributedString alloc] initWithString:str];
//    [range addAttribute:NSFontAttributeName value:textFont range:NSRangeFromString(str)];
//    [range addAttribute:NSForegroundColorAttributeName value:textColor range:NSRangeFromString(str)];
//    
//    [range replaceCharactersInRange:[range.string rangeOfString:@"lowerValue"] withAttributedString:attrValueString];
//    
//    [range addAttribute:NSForegroundColorAttributeName value:numberColor range:[range.string rangeOfString:attrValueString.string]];
//    [range addAttribute:NSFontAttributeName value:numberFont range:[range.string rangeOfString:attrValueString.string]];
//    
//    return range;
}

+ (NSString *) distanceUnitAbbreviation
{
//	if([HLLocaleInspector shouldUseMetricSystem]){
//		return LS(@"HL_LOC_KILOMETERS_ABBREVIATION");
//	}
//	return LS(@"HL_LOC_MILES_ABBREVIATION");
    return @"azazaz";
}

+ (NSString *)shortDistanceStringWithKilometers:(CGFloat)distance
{
	NSString * unitAbbreviation = [self distanceUnitAbbreviation];
	
	if([HLLocaleInspector shouldUseMetricSystem] == NO){
        distance = [HLDistanceCalculator convertKilometersToMiles:distance];
	}

	NSString * result = [NSString stringWithFormat:@"%.1f %@", distance, unitAbbreviation];
	return result;
}

+ (NSString *)longDistanceStringWithHotel:(HLHotel *)hotel city:(HLCity *)city
{
    double distance = [HLDistanceCalculator getDistanceFromCity:city toHotel:hotel];
    NSString * comment = @"from center";
		
	NSString * shortDescr = [self shortDistanceStringWithKilometers:distance];
	NSString * result = [NSString stringWithFormat:@"%@ %@", shortDescr, comment];
	return result;
}


+ (NSString *) intervalDescriptionWithDate:(NSDate *)start andDate:(NSDate *)finish{
	NSDateFormatter * formatter = [NSDateFormatter new];
	NSString * lang = [[HLLocaleInspector sharedInspector] language];
	NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:lang];
	[formatter setLocale:locale];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	[formatter setDateFormat:@"dd MMM"];
	NSString * checkInDateDescription = [formatter stringFromDate:start];
	checkInDateDescription = [checkInDateDescription substringToIndex:6];
	NSString * checkOutDateDescription = [formatter stringFromDate:finish];
	checkOutDateDescription = [checkOutDateDescription substringToIndex:6];

    return [NSString stringWithFormat:@"%@ — %@", checkInDateDescription, checkOutDateDescription];
}


+ (NSString *) checkInTextWithDate:(NSDate *)checkInTime
{
	NSString * afterString = NSLocalizedString(@"HL_LOC_CHECK_IN_TITLE", @"");
	NSString * dateString = [self checkInOutTimeDescription:checkInTime];
	if(dateString.length > 0){
		return [NSString stringWithFormat:@"%@ %@", afterString, dateString];
	}
	else{
		return @"";
	}
}
+ (NSString *) checkOutTextWithDate:(NSDate *)checkOutTime
{
	NSString * beforeString = NSLocalizedString(@"HL_LOC_CHECK_OUT_TITLE", @"");
	NSString * dateString = [self checkInOutTimeDescription:checkOutTime];
	if(dateString.length > 0){
		return [NSString stringWithFormat:@"%@ %@", beforeString, dateString];
	}
	else{
		return @"";
	}
}

+ (NSString *) checkInOutTimeDescription:(NSDate *)time locale:(NSLocale *)locale
{
	NSDateFormatter * formatter = [DateUtil sharedFormatter];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	[formatter setLocale:locale];
	return [formatter stringFromDate:time];
}

+ (NSString *)checkInOutTimeDescription:(NSDate *)time
{
	return [self checkInOutTimeDescription:time locale:[[HLLocaleInspector sharedInspector] getLocaleForCurrentLanguage]];
}

+ (NSString *) cityNameDescriptionWithCity:(HLCity *)city
{
	if(city.name.length == 0 || city.country.length == 0){
		return city.fullName;
	}
	
	NSMutableString * result = [NSMutableString stringWithString:city.name];
	if(city.state.length > 0){
		[result appendFormat:@", %@", city.state];
	}
	if(city.country.length > 0){
		[result appendFormat:@", %@", city.country];
	}
	
	return result;
}

+ (NSString *)cityNameByCity:(HLCity *)city
{
    NSString *cityName = @"";
    if (city.name.length > 0) {
        cityName = city.name;
    } else {
        cityName = city.fullName;
    }
    
    return cityName;
}

+ (NSString *) countryAndStateStringForCity:(HLCity *)city
{
	if([city.state isKindOfClass:[NSString class]] && city.state.length > 0){
		return [NSString stringWithFormat:@"%@, %@", city.state, city.country];
	}
	else{
		return city.country;
	}

}

+ (NSString *) searchInfoDescription:(HLSearchInfo *)searchInfo
{
	NSString * cityDescription = [StringUtils cityNameDescriptionWithCity:searchInfo.city];
	
	NSString * datesText = [StringUtils intervalDescriptionWithDate:searchInfo.checkInDate andDate:searchInfo.checkOutDate];
	NSString * passengersText = [StringUtils guestsDescriptionWithGuestsCount:searchInfo.adultsCount + searchInfo.kidAgesArray.count];
	
	NSString * result = [NSString stringWithFormat:@"%@, %@; %@", cityDescription, datesText, passengersText];
	return result;
}

+ (NSString *) stringByStrippingHtmlFrom:(NSString *)string
{
	if(string == nil){
		return nil;
	}
	NSRange r;
	NSString *s = [string copy];
	while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
		s = [s stringByReplacingCharactersInRange:r withString:@""];
	}
	return s;
}

+ (NSAttributedString *) attributedRangeValueTextWithCurrency:(HLCurrency *)currency minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue
{
    return @"azzaz";
//    UIFont * textFont = [UIFont appRegularFontWithSize:12.0];
//    UIFont * numberFont = [UIFont appSemiboldFontWithSize:12.0];
//    UIColor * textColor = [UIColor lightGrayTextColor];
//    UIColor * numberColor = [UIColor appGrayColor];
//    
//	NSAttributedString * lowerStr = [StringUtils attributedPriceStringWithPrice:minValue currency:currency font:numberFont];
//	NSAttributedString * upperStr = [StringUtils attributedPriceStringWithPrice:maxValue currency:currency font:numberFont];
//	NSString *str = [NSString stringWithFormat:LS(@"HL_LOC_FILTER_RANGE"), @"lowerValue", @"upperValue"];
//	NSMutableAttributedString *range = [[NSMutableAttributedString alloc] initWithString:str];
//    [range addAttribute:NSFontAttributeName value:textFont range:NSRangeFromString(str)];
//    [range addAttribute:NSForegroundColorAttributeName value:textColor range:NSRangeFromString(str)];
//
//	[range replaceCharactersInRange:[range.string rangeOfString:@"lowerValue"] withAttributedString:lowerStr];
//	[range replaceCharactersInRange:[range.string rangeOfString:@"upperValue"] withAttributedString:upperStr];
//	
//	[range addAttribute:NSForegroundColorAttributeName value:numberColor range:[range.string rangeOfString:lowerStr.string]];
//	[range addAttribute:NSForegroundColorAttributeName value:numberColor range:[range.string rangeOfString:upperStr.string options:NSBackwardsSearch]];
//
//    return range;
}

+ (NSString *) priceStringWithVariant:(HLResultVariant *)variant;
{
	if(variant.rooms.count == 0){
		return @"—";
	}
	else {
		NSInteger price = variant.minimalPrice;
		return [self formattedNumberStringWithNumber:price];
	}
}

+ (NSAttributedString *)attributedNameAndDateWithReview:(HLReview *)review nameFont:(UIFont *)nameFont nameColor:(UIColor *)nameColor dateFont:(UIFont *)dateFont dateColor:(UIColor *)dateColor
{
    return @"azzaz";
//    NSString *date = [DateUtil dateToMonthNameYearString:review.createdDate];
//    NSString *name = [NSString stringWithFormat:@"%@ %@ ", review.username, review.userlastname];
//    
//    NSMutableAttributedString *nameAttrStr = [[NSMutableAttributedString alloc] initWithString:name];
//    [nameAttrStr addAttribute:NSFontAttributeName value:nameFont range:NSMakeRange(0, name.length)];
//    [nameAttrStr addAttribute:NSForegroundColorAttributeName value:nameColor range:NSMakeRange(0, name.length)];
//    
//    NSMutableAttributedString *dateAttrStr = [[NSMutableAttributedString alloc] initWithString:date];
//    [dateAttrStr addAttribute:NSFontAttributeName value:dateFont range:NSMakeRange(0, date.length)];
//    [dateAttrStr addAttribute:NSForegroundColorAttributeName value:dateColor range:NSMakeRange(0, date.length)];
//    
//    [nameAttrStr appendAttributedString:dateAttrStr];
//    
//    return nameAttrStr;
}

+ (NSAttributedString *)attributedPriceStringWithPrice:(NSInteger)price currency:(HLCurrency *)currency font:(UIFont *)font
{
	NSMutableString *priceString = [[self formattedNumberStringWithNumber:price] mutableCopy];

	if([currency.code isEqual:@"RUB"]){
		[priceString appendString:@" "];
		NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:priceString];
		[result addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, priceString.length)];
        
        UIFont * rubleFont = [UIFont fontWithName:@"OpenRuble" size:font.pointSize];
		NSString * rubleSymbol = @"e";
		NSRange range = NSMakeRange(0, 1);
		NSMutableAttributedString * rubleSign = [[NSMutableAttributedString alloc] initWithString:rubleSymbol];
		[rubleSign addAttribute:NSFontAttributeName value:rubleFont range:range];
		[result appendAttributedString:rubleSign];

		return  result;
	}
	
	if(currency){
		priceString = [[NSString stringWithFormat:currency.formatString, priceString] mutableCopy];
	}
	NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:priceString];
	[result addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, priceString.length)];
    return result;
}

+ (NSString *) formattedNumberStringWithNumber:(NSInteger)number
{
    static NSNumberFormatter *nf = nil;
    if (!nf) {
        nf = [NSNumberFormatter new];
        nf.usesGroupingSeparator = YES;
        nf.groupingSize = 3;
    }
	NSString *result = [nf stringFromNumber:[NSNumber numberWithInteger:number]];
	return result;
}

+ (NSString *) letterStringForIndex:(NSInteger)index
{
	return [NSString stringWithFormat:@"%c", (int)(65 + index)];
}


+ (NSString *) getOptionsStringWithOptions:(NSDictionary *)options
{
	int breakfast = [[options objectForKey:@"breakfast"] intValue];
	int refundable = [[options objectForKey:@"refundable"] intValue];
    
	NSString * result;
	if (breakfast == 1 && refundable == 0){
		result = NSLocalizedString(@"HL_LOC_BREAKFAST_OPTION_TITLE", @"");
	} else if (breakfast == 0 && refundable == 1) {
		result = NSLocalizedString(@"HL_LOC_REFUNDABLE_OPTION_TITLE", @"");
	} else if (breakfast == 0 && refundable == 0) {
		return @"";
	} else {
		result = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"HL_LOC_BREAKFAST_OPTION_TITLE", @""), NSLocalizedString(@"HL_LOC_AND_CONJUNCTION", @""), NSLocalizedString(@"HL_LOC_REFUNDABLE_OPTION_TITLE", @"")];
	}
	result = [result stringByReplacingCharactersInRange:NSMakeRange(0,1)
											 withString:[[result substringToIndex:1] capitalizedString]];
	return result;
}

+ (NSAttributedString *) attributedRatingString:(NSInteger)rating
{
    return @"azzaz";
//    UIFont * textFont = [UIFont appRegularFontWithSize:12.0];
//    UIFont * numberFont = [UIFont appSemiboldFontWithSize:12.0];
//    UIColor * textColor = [UIColor lightGrayTextColor];
//    UIColor * numberColor = [UIColor appGrayColor];
//    
//    NSString * valueString = [StringUtils shortRatingStringWithRating:rating];
//    NSAttributedString * attrValueString = [[NSAttributedString alloc] initWithString:valueString];
//    NSString *str = [NSString stringWithFormat:@"%@ %@", LS(@"HL_LOC_FILTER_FROM_STRING"), @"lowerValue"];
//    NSMutableAttributedString *range = [[NSMutableAttributedString alloc] initWithString:str];
//    [range addAttribute:NSFontAttributeName value:textFont range:NSRangeFromString(str)];
//    [range addAttribute:NSForegroundColorAttributeName value:textColor range:NSRangeFromString(str)];
//    
//    [range replaceCharactersInRange:[range.string rangeOfString:@"lowerValue"] withAttributedString:attrValueString];
//    
//    [range addAttribute:NSForegroundColorAttributeName value:numberColor range:[range.string rangeOfString:attrValueString.string]];
//    [range addAttribute:NSFontAttributeName value:numberFont range:[range.string rangeOfString:attrValueString.string]];
//    
//    return range;
}

+ (NSString *) shortRatingStringWithRating:(NSInteger)rating
{
	if(rating == 100){
		return [NSString stringWithFormat:@"%i", (int) rating / 10];
	}
	else{
		return [NSString stringWithFormat:@"%.1f", rating / 10.0];
	}
}

+ (NSArray *) getRatingsGradeArray
{
	return @[@50, @60, @70, @75, @80, @85, @90, @95];
}

+ (NSArray *) getRatingsDescriptionsArray
{
	return @[NSLocalizedString(@"HL_LOC_RATING_GRADE_1", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_2", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_3", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_4", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_5", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_6", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_7", @""),
			 NSLocalizedString(@"HL_LOC_RATING_GRADE_8", @""),
			 ];
}

+ (NSString *) textDescriptionWithRating:(NSInteger) rating
{
	NSArray * grades = [self getRatingsGradeArray];
	for(int i = 7; i >= 0; i--){
		if(rating > [grades[i] intValue]){
			NSArray * descriptions = [self getRatingsDescriptionsArray];
			return descriptions[i];
		}
	}
	return NSLocalizedString(@"HL_LOC_RATING_GRADE_NO_RATING", @"");
}

+ (NSString *) longRatingStringWithRating:(NSInteger)rating
{
	NSString * desc = [self textDescriptionWithRating:rating];
	NSString * shortDesc = [self shortRatingStringWithRating:rating];
	if(rating > 0){
		return [NSString stringWithFormat:@"%@ %@", desc, shortDesc];
	}
	else{
		return desc;
	}
}

+ (NSString *) hotelsCountDescriptionWithHotels:(NSInteger)count
{
	NSString * formattedCount = [StringUtils formattedNumberStringWithNumber:count];
	NSString * hotelWordString = @"azaz";
	return [NSString stringWithFormat:@"%@ %@", formattedCount, hotelWordString];
}

+ (NSString *) filteredHotelsDescriptionWithFiltered:(NSInteger)filtered total:(NSInteger)total
{
    NSString *title = nil;
    if (filtered > 0) {
        NSString *countStr = [StringUtils formattedNumberStringWithNumber:filtered];
        NSString *totalStr = [StringUtils formattedNumberStringWithNumber:total];
        title = @"azaz";
        title = [NSString stringWithFormat:title, countStr, totalStr];
    } else {
        title = NSLocalizedString(@"HL_FILTER_HOTELS_NOT_FOUND", @"");
    }
    return title;
}


+ (NSAttributedString *) formattedLogoTextWithFontSize:(CGFloat)fontSize
{
	NSString * text = @"azaz";
	UIFont * openSansFont = [UIFont fontWithName:@"OpenSansLight-Italic" size:fontSize];
	
	NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:text];
	[result addAttribute:NSFontAttributeName value:openSansFont range:NSMakeRange(0, text.length)];
	return  result;
}

+ (NSString *)rateUsSubjectStringWithStarsCount:(NSInteger)starsCount
{
    NSString *feedbackSubject = NSLocalizedString(@"HL_LOC_MAIL_FEEDBACK_SUBJECT", @"");
    NSString *starsText = @"azaz";
    return [NSString stringWithFormat:@"%@: %ld %@", feedbackSubject, (long)starsCount, starsText];
}

+ (NSDictionary *) paramsFromUrlAbsoluteString:(NSString *)urlString
{
	NSArray * params = [urlString componentsSeparatedByString:@"?"];
	urlString = [params lastObject];
	params = [urlString componentsSeparatedByString:@"://"];
	urlString = [params lastObject];
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	NSArray *pairs = [urlString componentsSeparatedByString:@"&"];
	
	for (NSString *pair in pairs) {
		NSArray *elements = [pair componentsSeparatedByString:@"="];
		if(elements.count > 1){
			NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			
			[dict setObject:val forKey:key];
		}
	}
	return dict;
}


#pragma mark-
#pragma mark Hash
+ (NSString *)aiMd5FromString:(NSString *)source
{
    const char *cStr = [source UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
	
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}


@end
