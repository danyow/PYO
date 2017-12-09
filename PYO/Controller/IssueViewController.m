//
//  IssueViewController.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/4.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//
#import "IssueViewController.h"
#import "SendIssueViewController.h"
#import "IssueCollectionViewCell.h"
#import "LoginViewController.h"
#import "LoginUserInfo.h"
#import "UserInfoViewController.h"
#import <Masonry.h>

#define HeadIconSize 38
#define kCollectionIdentifier @"PYO"

@interface IssueViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UILabel *navTitleLabel;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation IssueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMaskView];
    if (![LoginUserInfo getInstance].logined) {
        LoginViewController *loginVc = [UIStoryboard storyboardWithName:NSStringFromClass([LoginViewController class]) bundle:nil].instantiateInitialViewController;
        [self presentViewController:loginVc animated:YES completion:^{
            [self hideMaskView];
        }];
    } else {
        [self hideMaskView];
    }
}

- (void)loadMaskView
{
    self.navigationController.navigationBarHidden = YES;
    self.maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    self.maskView.backgroundColor = RandomColor;
    [self.view addSubview:self.maskView];
}


- (void)hideMaskView
{
    if (self.maskView) {
        self.maskView.hidden = YES;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }
    [self initView];
    self.navigationController.navigationBarHidden = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)initView
{  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.headButton];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    
    [self.view setBackgroundColor:BackgroundColor];
    self.navigationItem.titleView = self.navTitleLabel;
}

#pragma mark -  UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IssueCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark -  event handle

- (void)sendButtonClick:(UIButton *)sender
{
    SendIssueViewController *vc = [UIStoryboard storyboardWithName:NSStringFromClass([SendIssueViewController class]) bundle:nil].instantiateInitialViewController;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)headButtonClick:(UIButton *)sender
{
    UserInfoViewController *userInfoVc = [UIStoryboard storyboardWithName:NSStringFromClass([UserInfoViewController class]) bundle:nil].instantiateInitialViewController;
    [self.navigationController pushViewController:userInfoVc animated:YES];
}

#pragma mark -  lazy load

- (UILabel *)navTitleLabel
{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        [_navTitleLabel setText:@"PYO"];
        [_navTitleLabel setTextColor:TextColor];
    }
    return _navTitleLabel;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] init];
        _sendButton.backgroundColor = RandomColor;
        [_sendButton setFrame:CGRectMake(0, 0, HeadIconSize, HeadIconSize)];
        _sendButton.layer.borderWidth = 1;
        [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIButton *)headButton
{
    if (!_headButton) {
        _headButton = [[UIButton alloc] init];
        _headButton.backgroundColor = RandomColor;
        [_headButton setFrame:CGRectMake(0, 0, HeadIconSize, HeadIconSize)];
        _headButton.layer.cornerRadius = HeadIconSize * 0.5;
        _headButton.layer.borderWidth = 1;
        [_headButton addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headButton;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = BackgroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([IssueCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCollectionIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, 500);
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return _flowLayout;
}


@end
