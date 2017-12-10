//
//  i18nTool.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/9.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <Foundation/Foundation.h>

#define T(STRING)       [i18nTool T:(STRING)]

@interface i18nTool : NSObject

+ (NSString *)T:(NSString *)string;
+ (void)addMoName:(NSString *)moName;

+ (NSString*)getPreferredLanguage;

@end
