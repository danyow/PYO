//
//  IssueModel.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/9.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssueModel : NSObject

@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, copy  ) NSString *publisherId;
@property (nonatomic, copy  ) NSString *publisherName;
@property (nonatomic, copy  ) NSString *publisherPhoto;
@property (nonatomic, copy  ) NSString *topicContent;
@property (nonatomic, copy  ) NSString *topicId;
@property (nonatomic, copy  ) NSString *topicTime;
@property (nonatomic, copy  ) NSString *topicType;
@property (nonatomic, copy  ) NSString *topicUrl;


//+ (instancetype)issueWithDict:(NSDictionary *)dict;
//+ (NSArray *)issueArrayWithDictArray:(NSArray *)dictArray;

@end
