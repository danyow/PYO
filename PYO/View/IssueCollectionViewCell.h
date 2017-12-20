//
//  IssueCollectionViewCell.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IssueModel, IssueCollectionViewCell;

@protocol IssueCollectionViewCellDelegate<NSObject>

@optional
- (void)commentButtonClick:(IssueCollectionViewCell *)cell;

@end


@interface IssueCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IssueModel *issue;

@property (nonatomic, weak) id<IssueCollectionViewCellDelegate> delegate;

@end
