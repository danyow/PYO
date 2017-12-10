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
#define USER_TOKEN          @"token"

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
            //80492982-334f-49b2-b012-1df6a89601b2
            [self setValuesForKeysWithDictionary:userInfo];
        } else {
        }
    }
    return self;
}

- (BOOL)logined
{
    return self.token != nil;
}

- (void)saveWithUserLoginStr:(NSString *)userLoginStr userPassword:(NSString *)userPassword token:(NSString *)token
{
    self.userLoginStr = userLoginStr;
    self.userPassword = userPassword;
    self.token = token;
    NSDictionary *userDict = @{USER_LOGINSTR : userLoginStr,
                               USER_PASSWORD : userPassword,
                               USER_TOKEN    : token};
    [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:USER_INFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
