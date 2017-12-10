//
//  SendIssueViewController.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "SendIssueViewController.h"

@interface SendIssueViewController ()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *contentField;

@end

@implementation SendIssueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)initView
{
    self.view.backgroundColor = BackgroundColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
}

#pragma mark -  event handle

- (void)cancelButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendButtonClick:(UIButton *)sender
{
    if (self.contentField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:T(@"内容不能为空")];
        return;
    }
    NSDictionary *parm = @{@"topicContent"      : self.contentField.text,
                           @"topicUrl"          : @"",
                           @"publisherName"     : [LoginUserInfo getInstance].userLoginStr,
                           @"publisherPhoto"    : @"",
                           @"topicType"         : @"1"};
    [[RequestManager sharedManager] postWithAPI:RequestCircleAdd parameter:parm callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", data);
        }
    }];
}

#pragma mark -  lazy load

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:T(@"取消") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:TextColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] init];
        [_sendButton setTitle:T(@"发表") forState:UIControlStateNormal];
        [_sendButton setTitleColor:TextColor forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

@end
