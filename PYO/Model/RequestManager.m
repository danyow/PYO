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
#define APPKEY          @"pycircle"
@implementation RequestManager

+ (instancetype)sharedManager
{
    static RequestManager *instance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance_ = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_STRING] sessionConfiguration:config];
        NSSet *responseSerializer = instance_.responseSerializer.acceptableContentTypes;
        instance_.responseSerializer.acceptableContentTypes = [responseSerializer setByAddingObject:@"text/html"];
        instance_.requestSerializer = [AFJSONRequestSerializer serializer];
        [instance_.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [instance_.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return instance_;
}

- (void)regiestWithUserLoginStr:(NSString *)username userPassword:(NSString *)password
{
    NSString *appendPassword = [NSString stringWithFormat:@"%@%@%@", username, password, APPKEY];
    NSString *encodePassword = [self MD5:appendPassword];
    NSDictionary *parm = @{@"username" : username,
                           @"password" : encodePassword,
                           @"appKey"   : APPKEY};
//    NSString *parm = [NSString stringWithFormat:@"username=%@&password=%@&appKey=%@", username, password, APPKEY];
    [self POST:@"api/user/register" parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSString *)MD5:(NSString *)input
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
