//
//  IssueCollectionViewCell.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "IssueCollectionViewCell.h"

@interface IssueCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

@implementation IssueCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = BackgroundColor;
    self.shadowView.layer.shadowColor = ShadowColor.CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 6);
    self.shadowView.layer.shadowRadius = 6;
    self.shadowView.layer.shadowOpacity = 0.17;
}

@end
