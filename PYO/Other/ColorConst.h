//
//  ColorConst.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/4.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BackgroundColor [ColorConst hexColorWithHexString:@"FAFBFC"]
#define TextColor       [ColorConst hexColorWithHexString:@"272A33"]
#define ShadowColor     [ColorConst hexColorWithHexString:@"273438"]
#define RandomColor     [ColorConst randomColor]
#define LineColor       [[ColorConst hexColorWithHexString:@"4837BC"] colorWithAlphaComponent:0.2]

@interface ColorConst : NSObject

+ (UIColor *)randomColor;
+ (UIColor *)hexColorWithHexString:(NSString *)hexString;

+ (UIImage *)imageFromColor:(UIColor *)color;

@end
