//
//  LoginUserInfo.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/7.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "LoginUserInfo.h"
#define USER_NAME           @"userName"
#define USER_LOGINSTR       @"userLoginStr"
#define USER_PASSWORD       @"userPassword"


@implementation LoginUserInfo

+ (instancetype)getInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
        if (userInfo) {
            self.logined = YES;
            [self setValuesForKeysWithDictionary:userInfo];
        } else {
            self.logined = NO;
        }
    }
    return self;
}

@end
