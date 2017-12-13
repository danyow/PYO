//
//  IssueTableViewCell.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/13.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "IssueTableViewCell.h"

@interface IssueTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

@implementation IssueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.layer.shadowColor = ShadowColor.CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 6);
    self.shadowView.layer.shadowRadius = 6;
    self.shadowView.layer.shadowOpacity = 0.17;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
