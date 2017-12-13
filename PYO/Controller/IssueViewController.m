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
#import "UserInfoViewController.h"

#import "IssueModel.h"

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

@property (nonatomic, strong) NSMutableArray *issueArray;

@end

@implementation IssueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self baseSetting];
    [self loadMaskView];
    LoginUserInfo *userInfo = [LoginUserInfo getInstance];
    if (userInfo.logined) {
        [self showLoginViewController];
    } else {
        // 取消注册
//        [LoginViewController loginWithLoginStr:userInfo.userLoginStr password:userInfo.userPassword callback:^(NSDictionary *data, NSError *error) {
//            if (error) {
//                [self showLoginViewController];
//            } else {
//                [self hideMaskView];
//            }
//        }];
        [self hideMaskView];
    }
}

#pragma mark -  private method

- (void)showLoginViewController
{
    LoginViewController *loginVc = [UIStoryboard storyboardWithName:NSStringFromClass([LoginViewController class]) bundle:nil].instantiateInitialViewController;
    [self presentViewController:loginVc animated:YES completion:^{
        [self hideMaskView];
    }];
}

- (void)loadMaskView
{
    self.navigationController.navigationBarHidden = YES;
    self.maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    self.maskView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.maskView];
}

- (void)baseSetting
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    NSString *preferredLanguage = [i18nTool getPreferredLanguage];
    [i18nTool addMoName:preferredLanguage];
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
    [self getData];
    [self registerNotification];
}

- (void)initView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.headButton];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    
    self.navigationItem.rightBarButtonItem.width = HeadIconSize;
    self.navigationItem.leftBarButtonItem.width = HeadIconSize;
    
    [self.view setBackgroundColor:BackgroundColor];
    self.navigationItem.titleView = self.navTitleLabel;
}

- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateIssue) name:UPDATE_ISSUE_NOTIFICATION object:nil];
}

- (void)updateIssue
{
    [self getData];
}

#pragma mark -  networking

- (void)getData
{
    NSDictionary *parm = @{@"page" : @"0",
                           @"size" : @"10",};
    [[RequestManager sharedManager] getWithAPI:RequestCircleList parameter:parm callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", data[@"data"]);
            self.issueArray = [[NSArray yy_modelArrayWithClass:[IssueModel class] json:data[@"data"]] copy];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark -  UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.issueArray.count + 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IssueCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionIdentifier forIndexPath:indexPath];
//    cell.issue = self.issueArray[indexPath.item];
    return cell;
}

#pragma mark -  event handle

- (void)sendButtonClick:(UIButton *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *tackPhotoAction = [UIAlertAction actionWithTitle:T(@"拍摄")
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                [self showIssueSendViewController];
                                                            }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:T(@"相册")
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [self showIssueSendViewController];
                                                        }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:T(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:tackPhotoAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showIssueSendViewController
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
        [_sendButton setFrame:CGRectMake(0, 0, HeadIconSize, HeadIconSize)];
        [_sendButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIButton *)headButton
{
    if (!_headButton) {
        _headButton = [[UIButton alloc] init];
        [_headButton setFrame:CGRectMake(0, 0, HeadIconSize, HeadIconSize)];
        [_headButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_headButton setBackgroundImage:[Tool image:[UIImage imageNamed:@"head"] scaleToSize:CGSizeMake(HeadIconSize, HeadIconSize)] forState:UIControlStateNormal];
        [Tool view_cutRoundedRect:_headButton];
        _headButton.backgroundColor = RandomColor;
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
        _flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, 330);
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return _flowLayout;
}

- (NSMutableArray *)issueArray
{
    if (!_issueArray) {
        _issueArray = [[NSMutableArray alloc] init];
    }
    return _issueArray;
}

@end
