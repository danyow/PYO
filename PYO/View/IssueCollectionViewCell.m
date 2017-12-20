//
//  IssueCollectionViewCell.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "IssueCollectionViewCell.h"
#import "IssueModel.h"

@interface IssueCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@end

@implementation IssueCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = BackgroundColor;
    self.shadowView.layer.shadowColor = ShadowColor.CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 6);
    self.shadowView.layer.shadowRadius = 6;
    self.shadowView.layer.shadowOpacity = 0.17;
    [Tool view_cutRoundedRect:self.headButton];
}

- (void)setIssue:(IssueModel *)issue
{
    _issue = issue;
    [self.nameButton setTitle:issue.publisherName ? : @"用户名为空" forState:UIControlStateNormal];
    self.contentLabel.text = issue.topicContent;
    self.timeLabel.text = [self interceptTimeStampFromStr:issue.topicTime];
}


- (NSString *)interceptTimeStampFromStr:(NSString *)str
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([str integerValue]/ 1000)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd HH:mm";
    NSString *string = [formatter stringFromDate:date];
    return string;
}

- (IBAction)commentButtonClick:(UIButton *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(commentButtonClick:)]) {
            [self.delegate commentButtonClick:self];
        }
    }
}
@end
