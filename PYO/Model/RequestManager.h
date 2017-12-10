//
//  RequestManager.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/8.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <AFNetworking.h>

#define APPKEY          @"pycircle"

typedef enum : NSUInteger {
    RequestUserRegiest,
    RequestUserLogin,
    RequestUserUpdatePassword,
    RequestCircleAdd,
    RequestCircleDel,
    RequestCircleList,
    RequestCircleAddComment,
    RequestCircleDelComment
} RequestAPI;

@interface RequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)getWithAPI:(RequestAPI)api parameter:(NSDictionary *)parameter callback:(void (^)(NSDictionary *data, NSError *error))callback;
- (void)postWithAPI:(RequestAPI)api parameter:(NSDictionary *)parameter callback:(void (^)(NSDictionary *data, NSError *error))callback;
+ (NSString *)MD5:(NSString *)input;

@end
