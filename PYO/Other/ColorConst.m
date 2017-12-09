//
//  ColorConst.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/4.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "ColorConst.h"

@implementation ColorConst
+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random()%256/255.0
                           green:arc4random()%256/255.0
                            blue:arc4random()%256/255.0 alpha:1];
}
+ (UIColor *)hexColorWithHexValue:(NSInteger)hexValue
{
    return [UIColor colorWithRed:((hexValue & 0x00FF0000) >> 16) / 255.0
                           green:((hexValue & 0x0000FF00) >> 8) / 255.0
                            blue:((hexValue & 0x000000FF)) / 255.0 alpha:1.0];
}
+ (UIColor *)hexColorWithHexString:(NSString *)hexString
{
    if(!hexString){
        return nil;
    }
    NSScanner * scanner = [NSScanner scannerWithString:hexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    return [self hexColorWithHexValue:hexNumber.integerValue];
}

+ (UIImage *)imageFromColor:(UIColor *)color
{
    return [self imageFromColor:color imageSize:CGSizeMake(1, 1)];
}

+ (UIImage *)imageFromColor:(UIColor *)color imageSize:(CGSize)imageSize
{
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
