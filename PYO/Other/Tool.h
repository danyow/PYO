//
//  Tool.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/12.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;

+ (void)view_cutRoundedRect:(UIView *)view;

@end
