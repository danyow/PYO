//
//  ConstSizeButton.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/10.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "ConstSizeButton.h"

@implementation ConstSizeButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
}

@end
