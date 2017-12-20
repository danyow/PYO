//
//  LoginUserInfo.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/7.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_INFO           @"userinfo"

@interface LoginUserInfo : NSObject

@property (nonatomic, copy  ) NSString *userName;
@property (nonatomic, copy  ) NSString *userLoginStr;
@property (nonatomic, copy  ) NSString *userPassword;

@property (nonatomic, copy  ) NSString *token;
@property (nonatomic, copy  ) NSString *userId;

@property (nonatomic, assign) BOOL      logined;

+ (instancetype)getInstance;

- (void)saveWithUserLoginStr:(NSString *)userLoginStr userPassword:(NSString *)userPassword data:(NSDictionary *)data;

@end
