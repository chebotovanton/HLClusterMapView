//
//  DateUtil.h
//  aviasales
//
//  Created by Nikita Kabardin on 10/9/11.
//  Copyright (c) 2011 Cleverpumpkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+(NSDateFormatter*)sharedFormatter;
+(NSCalendar*)sharedCalendar;

+(NSString*)dayFromDate:(NSDate *)date;
+(NSString*)dayMonthStringFromDate:(NSDate*)date;
+(NSString*)dayMonthYearStringFromDate:(NSDate*)date;
+(NSString*)dayFullMonthStringFromDate:(NSDate*)date;
+(NSString*)dayFullMonthYearStringFromDate:(NSDate*)date;
+(NSString*)dateToYearString:(NSDate*)date;
+(NSString*)dateToTimeString:(NSDate*)date;
+ (NSString *)dateToMonthNameYearString:(NSDate *)date;

+(NSDate *)resetTimeForDate:(NSDate *)date;
+(NSDate *)systemTimeZoneResetTimeForDate:(NSDate *)date;
+(NSDate *)firstDayOfMonth:(NSDate *)date;
+(NSDate *)dateNumberToNSDate:(NSNumber*)dateNumber_
                     forMonth:(NSDate*)month_;

+(NSDate *)firstDayOfNextMonthForDate:(NSDate*)date;
+(NSDate *)firstDayOfPrevMonthForDate:(NSDate*)date;

+(NSDate*)nextDayForDate:(NSDate *)date;
+(NSDate*)prevDayForDate:(NSDate *)date;
+(NSDate*)nextYearDate:(NSDate *)date;
+(NSDate *)dateIn30Days:(NSDate *)date;

+(NSDate*)systemTimeZoneNextYearDate:(NSDate *)date;
+(NSDate *)gmtTimeZoneResetTimeForDate:(NSDate *)date;
+(NSInteger)dayOfMonthNumber:(NSDate *)date;
+(NSInteger)monthNumber:(NSDate*)date;
+ (BOOL) isSameMonthAndYear:(NSDate *)date1 with:(NSDate *)date2;
+ (BOOL) isSameDay:(NSDate *)date1 and:(NSDate*)date2;
+(NSDate *)today;
+(NSString*)monthName:(NSDate*)date;

+ (BOOL) isFirstDayOfMonth:(NSDate *)date;
+ (BOOL) isLastDayOfMonth:(NSDate *)date;
+ (BOOL) isWeekendDay:(NSDate *)date;
+ (BOOL) isDate:(NSDate *)firstDate beforeDate:(NSDate *)lastDate;
+ (BOOL) isDateTooFarInFuture:(NSDate *) date;
+ (NSInteger) daysBetweenDate:(NSDate *)date andOtherDate:(NSDate *)otherDate;
+ (NSDate *) timeFromString:(NSString *)timeString;
+ (NSArray *) getWeekDays;


+ (NSDate *) dayInLessThan30DaysFromDate:(NSDate *)date preferredDate:(NSDate *)preferredDate;

+ (NSString *)dayNumberFromDate:(NSDate *)date;
@end
