//
//  HLLocaleInspector.h
//  HotelLook
//
//  Created by Anton Chebotov on 7/22/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLocaleInspector : NSObject

+ (HLLocaleInspector *)sharedInspector;
+ (BOOL) shouldUseMetricSystem;

- (NSLocale *) getLocaleForCurrentLanguage;

- (NSString *) getLanguageParameterWithLang:(NSString *)langCode;

- (NSString *) language;
- (BOOL) isCurrentLanguageRussian;
- (BOOL) isCurrentLanguageEnglish;
- (BOOL) isLanguageRussian:(NSString *)lang;


@end
