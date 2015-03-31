//
//  DateUtil.m
//  aviasales
//
//  Created by Nikita Kabardin on 10/9/11.
//  Copyright (c) 2011 Cleverpumpkin. All rights reserved.
//

#import "DateUtil.h"
//#import "HLUrlUtils.h"

@implementation DateUtil

static NSDateFormatter* formatter;

+(NSDateFormatter*)sharedFormatter
{
    if (!formatter){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			NSString * lang = @"en";//[[HLLocaleInspector sharedInspector] language];
			NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:lang];
			[formatter setLocale:locale];
			[formatter setCalendar:[self sharedCalendar]];
        });
    }
    return formatter;
}

static NSCalendar *gregorian;
+(NSCalendar*)sharedCalendar
{
    if (!gregorian) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			[gregorian setLocale:[NSLocale currentLocale]];
        });
    }
    return gregorian;
}

+(NSString*)dayMonthStringFromDate:(NSDate*)date
{
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"d"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MMM"];
    NSString * monthString = [formatter stringFromDate:date];
    if (monthString.length > 3) {
        monthString = [monthString substringWithRange:NSMakeRange(0, 3)];
    }
    NSString *stringFromDate = [NSString stringWithFormat:@"%@ %@", dateString, monthString];
    return stringFromDate;
}

+(NSString*)dayMonthYearStringFromDate:(NSDate *)date {
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"d"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MMM"];
    NSString * monthString = [formatter stringFromDate:date];
    if (monthString.length > 3) {
        monthString = [monthString substringWithRange:NSMakeRange(0, 3)];
    }
    NSString *stringFromDate = [NSString stringWithFormat:@"%@ %@ %@", dateString, monthString, [self dateToYearString:date]];
    return stringFromDate;
}

+(NSString*)dayFromDate:(NSDate *)date {
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"EEE"];
    NSString *dayCapitalized = [ [formatter stringFromDate:date] stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[ [formatter stringFromDate:date] substringToIndex:1] capitalizedString]];
    return dayCapitalized;
}

+(NSString*)dayFullMonthStringFromDate:(NSDate*)date {
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"d"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MMMM"];
    NSString * mounthString = [formatter stringFromDate:date];
    NSString *stringFromDate = [NSString stringWithFormat:@"%@ %@", dateString, mounthString];
    return stringFromDate;
}

+(NSString*)dayFullMonthYearStringFromDate:(NSDate *)date {
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"d"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MMMM"];
    NSString * mounthString = [formatter stringFromDate:date];
    NSString *stringFromDate = [NSString stringWithFormat:@"%@ %@ %@", dateString, mounthString, [self dateToYearString:date]];
    return stringFromDate;
}

+ (NSString*)dateToYearString:(NSDate*)date
{
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"yyyy"];
    NSString * stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

+ (NSString *)dateToMonthNameYearString:(NSDate *)date
{
    NSString *monthName = [DateUtil monthName:date];
    NSString *year = [DateUtil dateToYearString:date];
    
    return [NSString stringWithFormat:@"%@ %@", monthName, year];
}

+ (NSString*)dateToTimeString:(NSDate*)date {
    NSDateFormatter* formatter = [self sharedFormatter];
    [formatter setDateFormat:@"HH:mm"];
    NSString * stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

+(NSDate *)resetTimeForDate:(NSDate *)date {
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit| NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    return [gregorian dateFromComponents:components];
}

+(NSDate *)systemTimeZoneResetTimeForDate:(NSDate *)date {
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit| NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[date dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT]]];
    [components setHour:0];
    [components setMinute:0];
    return [gregorian dateFromComponents:components];
}

+(NSDate *)gmtTimeZoneResetTimeForDate:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents *components = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit| NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    return [gregorian dateFromComponents:components];
}

+(NSDate *)firstDayOfMonth:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    [components setDay:1];
    return [gregorian dateFromComponents:components];
}

+(NSInteger)dayOfMonthNumber:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSDayCalendarUnit) fromDate:date];
    return [components day];
}

+(NSInteger)monthNumber:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSMonthCalendarUnit) fromDate:date];
    return [components month];
}

+(NSDate *)dateNumberToNSDate:(NSNumber*)dateNumber_
                     forMonth:(NSDate*)month_
{
    
    NSCalendar* gregorian = [self sharedCalendar];
    
    NSDateComponents * components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:month_];
    components.day = [dateNumber_ integerValue];
    
    return [gregorian dateFromComponents:components];
}

+(NSDate*)firstDayOfNextMonthForDate:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents * components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
    components.month++;
    NSDate* res = [gregorian dateFromComponents:components];
    return res;
}

+(NSDate*)firstDayOfPrevMonthForDate:(NSDate *)date {
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents * components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
    components.month--;
    NSDate* res = [gregorian dateFromComponents:components];
    return res;
}

+(NSDate*)nextYearDate:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents * components = [gregorian components:NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    components.year ++;
    NSDate* res = [gregorian dateFromComponents:components];
    return res;
}

+(NSDate *)dateIn30Days:(NSDate *)date
{
	NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents * components = [gregorian components:NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	components.day += 30;
	NSDate* res = [gregorian dateFromComponents:components];
	return res;
}

+(NSDate*)systemTimeZoneNextYearDate:(NSDate *)date {
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents *components = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit| NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[date dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT]]];
    components.year ++;
    NSDate* res = [gregorian dateFromComponents:components];
    return res;
}

+(NSDate*)nextDayForDate:(NSDate *)date {
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents * components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    components.day++;
    NSDate *res = [gregorian dateFromComponents:components];
    return res;
}

+(NSDate*)prevDayForDate:(NSDate *)date {
    NSCalendar* gregorian = [self sharedCalendar];
    NSDateComponents * components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    components.day--;
    NSDate* res = [gregorian dateFromComponents:components];
    return res;
}


+ (BOOL) isSameMonthAndYear: (NSDate *)date1 with: (NSDate *)date2
{
    NSDateFormatter *dateComparisonFormatter = [self sharedFormatter];
    [dateComparisonFormatter setDateFormat:@"yyyy-MM"];
    return [[dateComparisonFormatter stringFromDate:date1] isEqualToString:[dateComparisonFormatter stringFromDate:date2]];
}

+ (BOOL) isSameDay:(NSDate *)date1 and:(NSDate*)date2
{
    NSDateFormatter *dateComparisonFormatter = [self sharedFormatter];
    [dateComparisonFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString * string1 = [dateComparisonFormatter stringFromDate:date1];
	NSString * string2 = [dateComparisonFormatter stringFromDate:date2];
    return [string1 isEqualToString:string2];
}

+(NSDate *)today
{
    NSDate *date = [NSDate date];
    NSDate *result = [self gmtTimeZoneResetTimeForDate:date];
    return result;
}

+ (NSInteger) daysBetweenDate:(NSDate*)date andOtherDate:(NSDate *) otherDate
{
	NSCalendar * cal = [DateUtil sharedCalendar];
	NSDate * normDate = [self resetTimeForDate:date];
	NSDate * normOtherDate = [self resetTimeForDate:otherDate];
	NSDateComponents * components = [cal components:NSDayCalendarUnit fromDate:normDate toDate:normOtherDate options:0];
	return components.day;
}

+ (NSString*) monthName:(NSDate *)date
{
	NSCalendar * gregorian = [self sharedCalendar];

    NSDateComponents * components = [gregorian components:NSMonthCalendarUnit fromDate:date];
	NSDateFormatter * dateFormatter = [self sharedFormatter];
	NSArray * months = [dateFormatter standaloneMonthSymbols];

	return months[components.month - 1];
}

+ (BOOL) isWeekendDay:(NSDate *)date
{
	NSInteger dayInt = [[[NSCalendar currentCalendar] components: NSWeekdayCalendarUnit fromDate: date] weekday];
	if(dayInt == 1  || dayInt == 7){
		return YES;
	}
	else{
		return NO;
	}
}

+ (BOOL) isDate:(NSDate *)firstDate beforeDate:(NSDate *)lastDate{
	NSTimeInterval interval = [lastDate timeIntervalSinceDate:firstDate];
	if(interval > 0){
		return YES;
	}
	return NO;
}

+ (BOOL) isDateTooFarInFuture:(NSDate *) date
{
	NSDate * today = [self resetTimeForDate:[NSDate date]];
	NSDate * dateInAYear = [self nextYearDate:today];
	NSTimeInterval interval = [date timeIntervalSinceDate:dateInAYear];
	if(interval >= 0){
		return YES;
	}
	else{
		return NO;
	}
}

+ (NSDate *) timeFromString:(NSString *)timeString
{
	NSDateFormatter * formatter = [DateUtil sharedFormatter];
	[formatter setDateFormat:@"HH:mm"];
	NSDate * date = [formatter dateFromString:timeString];
	return date;
}

+ (NSArray *) getWeekDays
{
	NSCalendar * gregorian = [DateUtil sharedCalendar];
	
    NSDateComponents * components = [gregorian components:NSWeekdayCalendarUnit | NSWeekCalendarUnit| NSYearCalendarUnit fromDate:[NSDate date]];
	NSUInteger firstWeekDay = gregorian.firstWeekday;

	NSDateFormatter * dateFormatter = [DateUtil sharedFormatter];
	[dateFormatter  setDateFormat:@"EE"];
    NSMutableArray * weekdays = [[NSMutableArray alloc] init];
	for(NSUInteger i = firstWeekDay; i < firstWeekDay + 7; i++){
		[components setWeekday:i];
		NSDate * day = [gregorian dateFromComponents:components];
		NSString * name = [[dateFormatter stringFromDate:day] capitalizedString];
		if(name.length > 1){
			name = [name substringToIndex:2];
		}
		[weekdays addObject:name];
	}
	return weekdays;
}

+ (BOOL) isFirstDayOfMonth:(NSDate *)date
{
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSDayCalendarUnit) fromDate:date];
	return components.day == 1;
	
}
+ (BOOL) isLastDayOfMonth:(NSDate *)date{
    NSCalendar* gregorian = [self sharedCalendar];
	NSDateComponents *components = [gregorian components:(NSDayCalendarUnit) fromDate:date];
	NSRange rangeOfDaysThisMonth = [[DateUtil sharedCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
	NSInteger day = components.day;
	NSInteger range = rangeOfDaysThisMonth.length;
	return day == range;
}


+ (NSDate *) dayInLessThan30DaysFromDate:(NSDate *)date preferredDate:(NSDate *)preferredDate
{
	NSDate * dateInMonth = [self dateIn30Days:date];
	
	NSTimeInterval maxInterval = [dateInMonth timeIntervalSinceDate:date];
	NSTimeInterval preferredInterval = [preferredDate timeIntervalSinceDate:date];
	
	if(maxInterval > preferredInterval){
		return preferredDate;
	}
	return dateInMonth;
}

+ (NSString *)dayNumberFromDate:(NSDate *)date
{
	[formatter setDateFormat:@"d"];
	NSString *dateString = [formatter stringFromDate:date];
	return dateString;
}


@end
