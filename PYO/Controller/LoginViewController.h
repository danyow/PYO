//
//  LoginViewController.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

+ (void)loginWithLoginStr:(NSString *)loginStr password:(NSString *)password callback:(void (^)(NSDictionary *data, NSError *error))callback;

@end
