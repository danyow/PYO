//
//  NavigationController.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "NavigationController.h"


@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *bar = self.navigationBar;
    [bar setBackgroundImage:[ColorConst imageFromColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsCompact];
    [bar setShadowImage:[ColorConst imageFromColor:[UIColor whiteColor]]];
}


@end
