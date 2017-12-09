//
//  RequestManager.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/8.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <AFNetworking.h>

@interface RequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;
- (void)regiestWithUserLoginStr:(NSString *)username userPassword:(NSString *)password;

@end
