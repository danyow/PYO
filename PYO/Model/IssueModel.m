//
//  IssueModel.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/9.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "IssueModel.h"

@implementation IssueModel

+ (instancetype)issueWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

+ (NSArray *)issueArrayWithDictArray:(NSArray *)dictArray
{
    NSMutableArray *array = [@[] mutableCopy];
    for (NSDictionary *dict in dictArray) {
        id model = [self issueWithDict:dict];
        [array addObject:model];
    }
    return [array copy];
}

@end
