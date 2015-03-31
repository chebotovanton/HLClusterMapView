//
//  HLLocaleInspector.m
//  HotelLook
//
//  Created by Anton Chebotov on 7/22/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import "HLLocaleInspector.h"


@interface HLLocaleInspector ()
{
	NSArray * validLocales;
}

@end


@implementation HLLocaleInspector

+ (HLLocaleInspector *)sharedInspector
{
	static HLLocaleInspector * sharedInspector;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInspector = [[HLLocaleInspector alloc] init];
    });
    
	return sharedInspector;
}

+ (BOOL) shouldUseMetricSystem
{
	NSLocale * locale = [NSLocale currentLocale];
	BOOL result = [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];
	return result;
}

- (BOOL) isCurrentLanguageRussian
{
	NSString * lang = [self language];
	return [self isLanguageRussian:lang];
}

- (BOOL) isCurrentLanguageEnglish
{
	NSString * lang = [self language];
	return [self isLanguageEnglish:lang];
}

- (BOOL) isLanguageRussian:(NSString *)lang
{
	return ([lang isEqualToString:@"ru"]);
}

- (BOOL) isLanguageEnglish:(NSString *)lang
{
	return ([lang isEqualToString:@"en"]);
}


- (NSArray *) loadValidLocales
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HLValidLocales" ofType:@"plist"];
	NSArray *locales = [NSArray arrayWithContentsOfFile:filePath];
	return locales;
}

- (NSString *)getLanguageParameterWithLang:(NSString *)langCode localeIdentifier:(NSString *)localeIdentifier
{
	if(validLocales == nil){
		validLocales = [self loadValidLocales];
	}
	
	NSString * localeLang = [localeIdentifier substringToIndex:2];
	if([localeLang isEqualToString:langCode]){
		if([validLocales containsObject:localeIdentifier]){
			return localeIdentifier;
		}
	}
	return langCode;
}

- (NSString *)getLanguageParameterWithLang:(NSString *)langCode
{
	NSString * locale = [[NSLocale currentLocale] localeIdentifier];
	NSString * param = [self getLanguageParameterWithLang:langCode localeIdentifier:locale];
	return param;
}

- (NSString *) language
{
	NSString * localeLang = [[[NSLocale preferredLanguages] objectAtIndex:0] substringToIndex:2];
	return localeLang;
}

- (NSLocale *) getLocaleForCurrentLanguage
{
	NSString * lang = [[NSLocale preferredLanguages] objectAtIndex:0];
	return [NSLocale localeWithLocaleIdentifier:lang];
}

@end
