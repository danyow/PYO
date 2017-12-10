//
//  RequestManager.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/8.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "RequestManager.h"
#import <CommonCrypto/CommonDigest.h>

#define BASE_URL_STRING @"http://1740k0d313.51mypc.cn/pycircle/"

@implementation RequestManager

+ (instancetype)sharedManager
{
    static RequestManager *instance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance_ = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_STRING] sessionConfiguration:config];
    });
    return instance_;
}

- (void)getWithAPI:(RequestAPI)api parameter:(NSDictionary *)parameter callback:(void (^)(NSDictionary *data, NSError *error))callback
{
    NSString *apiString = [self getAPIString:api];
    [self GET:apiString parameters:[self appendParameters:parameter] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject, [self analysisResponse:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil, error);
    }];
}

- (void)postWithAPI:(RequestAPI)api parameter:(NSDictionary *)parameter callback:(void (^)(NSDictionary *data, NSError *error))callback
{
    NSString *apiString = [self getAPIString:api];
    [self POST:apiString parameters:[self appendParameters:parameter] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject, [self analysisResponse:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil, error);
    }];
}

- (NSError *)analysisResponse:(id)responseObject
{
    NSError *error;
    if (!responseObject) {
        error = [NSError errorWithDomain:T(@"响应为空") code:-200 userInfo:nil];
        return error;
    }
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = responseObject;
        NSInteger code = [responseDict[@"code"] integerValue];
        NSString *msg = responseDict[@"msg"];
        if (code != 200) {
            error = [NSError errorWithDomain:msg code:-200 userInfo:nil];
            return error;
        } else {
            return nil;
        }
    }
    error = [NSError errorWithDomain:T(@"响应不是字典") code:-200 userInfo:nil];
    return error;
}

- (NSDictionary *)appendParameters:(NSDictionary *)parameters
{
    if ([LoginUserInfo getInstance].logined) {
        NSMutableDictionary *newParm = [parameters mutableCopy];
        NSString *token = [LoginUserInfo getInstance].token;
        long longTime = time(NULL);
        NSString *t = [NSString stringWithFormat:@"%ld", longTime];
        NSString *sign = [NSString stringWithFormat:@"%@%@%@", t, token, APPKEY];
        NSString *signMD5 = [RequestManager MD5:sign];
        newParm[@"token"] = token;
        newParm[@"t"] = t;
        newParm[@"sign"] = signMD5;
        return [newParm copy];
    }
    return parameters;
}


- (NSString *)getAPIString:(RequestAPI)api
{
    switch (api) {
        case RequestUserRegiest:
            return @"api/user/register";
            break;
        case RequestUserLogin:
            return @"api/user/login";
            break;
        case RequestUserUpdatePassword:
            return @"api/user/updatePassword";
            break;
        case RequestCircleAdd:
            return @"api/circle/add";
            break;
        case RequestCircleDel:
            return @"api/circle/del";
            break;
        case RequestCircleList:
            return @"api/circle/list";
            break;
        case RequestCircleAddComment:
            return @"api/circle/addComment";
            break;
        case RequestCircleDelComment:
            return @"api/circle/delComment";
            break;
        default:
            break;
    }
}

+ (NSString *)MD5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

@end
