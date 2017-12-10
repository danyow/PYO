//
//  i18nTool.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/9.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "i18nTool.h"

#include "I18nUtils.h"
#include <string>
#include <iostream>

USING_NS_I18N;

@implementation i18nTool

+ (NSString *)T:(NSString *)tString
{
    const char *cTString = [tString UTF8String];
    string cString = __(cTString);
    NSString *ocString = [[NSString alloc] initWithCString:cString.c_str() encoding:NSUTF8StringEncoding];
    return ocString;
}

+ (void)addMoName:(NSString *)moName
{
    NSString *moFile = [[NSBundle mainBundle] pathForResource:moName ofType:@"mo"];
    if (moFile) {
        const char *moPath = [moFile UTF8String];
        I18nUtils::getInstance()->addMO(moPath, [](int){return 0;}, 1);
    }
}

+ (NSString*)getPreferredLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages firstObject];
    return preferredLang;
}

@end
