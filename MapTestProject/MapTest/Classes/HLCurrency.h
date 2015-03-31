//
//  HLCurrency.h
//  HotelLook
//
//  Created by Anton Chebotov on 9/27/13.
//  Copyright (c) 2013 Anton Chebotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLCurrency : NSObject <NSCoding>

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *formatString;

+ (HLCurrency *) currencyWithCode:(NSString *)code symbol:(NSString *)symbol text:(NSString *)text formatString:(NSString *)formatString;

@end
