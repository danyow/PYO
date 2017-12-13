//
//  UserInfoViewController.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/7.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "UserInfoViewController.h"
#import "IssueTableViewCell.h"

#define kMyIssueIdentifier @"myIssue"
@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *nameVoice;
@property (weak, nonatomic) IBOutlet UIButton *infoVoice;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *myIssueTableView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    self.title = T(@"个人中心");
}

- (void)initView
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.headButton setBackgroundImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [Tool view_cutRoundedRect:self.headButton];
    
    self.view.backgroundColor = BackgroundColor;
    self.myIssueTableView.backgroundColor = BackgroundColor;
    self.myIssueTableView.delegate = self;
    self.myIssueTableView.dataSource = self;
    self.myIssueTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.myIssueTableView registerNib:[UINib nibWithNibName:NSStringFromClass([IssueTableViewCell class]) bundle:nil] forCellReuseIdentifier:kMyIssueIdentifier];
}

#pragma mark -  TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyIssueIdentifier];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark -  TableView Delegate



@end
