//
//  LoginViewController.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/6.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "LoginViewController.h"
#import "IssueViewController.h"
#import "RegisterViewController.h"

#import "i18nTool.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *loginStrField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *loginStrIcon;
@property (weak, nonatomic) IBOutlet UIImageView *passwordIcon;
@property (weak, nonatomic) IBOutlet UIImageView *loginStrLine;
@property (weak, nonatomic) IBOutlet UIImageView *passwordLine;

/** 文字显示 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

#pragma mark -  private method

- (void)initView
{
    [self.loginStrIcon setBackgroundColor:RandomColor];
    [self.passwordIcon setBackgroundColor:RandomColor];
    [self.loginStrLine setBackgroundColor:LineColor];
    [self.passwordLine setBackgroundColor:LineColor];
    
    LoginUserInfo *userInfo = [LoginUserInfo getInstance];
    if (userInfo.logined) {
        self.loginStrField.text = userInfo.userLoginStr;
        self.passwordField.text = userInfo.userPassword;
    }
    
    self.registerButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [self initPreferredLanguage];
}

- (void)initPreferredLanguage
{
    self.titleLabel.text = T(@"登录");
    [self.registerButton setTitle:T(@"注册") forState:UIControlStateNormal];
    [self.loginStrField setPlaceholder:T(@"账户")];
    [self.passwordField setPlaceholder:T(@"密码")];
}

#pragma mark -  event handle

- (IBAction)registerButtonClick:(UIButton *)sender
{
    if (![self determineIfTheInputIsLegal]) {
        return;
    }
    
    [SVProgressHUD showWithStatus:T(@"注册中")];
    NSString *username = self.loginStrField.text;
    NSString *password = self.passwordField.text;
    
    NSString *appendPassword = [NSString stringWithFormat:@"%@%@%@", username, password, APPKEY];
    NSString *encodePassword = [RequestManager MD5:appendPassword];
    NSDictionary *parm = @{@"username" : username,
                           @"password" : encodePassword,
                           @"appKey"   : APPKEY};
    
    [[RequestManager sharedManager] postWithAPI:RequestUserRegiest parameter:parm callback:^(NSDictionary *data, NSError *error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:data[@"msg"]];
            // 注册成功之后 再走一遍登录逻辑
            [self loginButtonClick:self.loginButton];
        } else {
            NSLog(@"%@", error);
            [SVProgressHUD showErrorWithStatus:error.domain];
        }
    }];
}

- (IBAction)loginButtonClick:(UIButton *)sender
{
    
    if (![self determineIfTheInputIsLegal]) {
        return;
    }
    
    [SVProgressHUD showWithStatus:T(@"登录中")];
    NSString *username = self.loginStrField.text;
    NSString *password = self.passwordField.text;

    [LoginViewController loginWithLoginStr:username password:password callback:^(NSDictionary *data, NSError *error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:data[@"msg"]];
            NSLog(@"%@", data);
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            NSLog(@"%@", error);
            
        }
    }];
}

+ (void)loginWithLoginStr:(NSString *)loginStr password:(NSString *)password callback:(void (^)(NSDictionary *data, NSError *error))callback
{
    NSString *appendPassword = [NSString stringWithFormat:@"%@%@%@", loginStr, password, APPKEY];
    NSString *encodePassword = [RequestManager MD5:appendPassword];
    NSDictionary *parm = @{@"username" : loginStr,
                           @"password" : encodePassword,
                           @"appKey"   : APPKEY};
    [[RequestManager sharedManager] postWithAPI:RequestUserLogin parameter:parm callback:^(NSDictionary *data, NSError *error) {
        if (!error) {
            [[LoginUserInfo getInstance] saveWithUserLoginStr:loginStr userPassword:password token:data[@"token"]];
        }
        callback(data, error);
    }];
}

- (BOOL)determineIfTheInputIsLegal
{
    // 判断是否为空
    NSString *username = self.loginStrField.text;
    NSString *password = self.passwordField.text;
    
    if (username.length == 0) {
        [SVProgressHUD showErrorWithStatus:T(@"账号不能为空")];
        return false;
    }
    
    if (password.length == 0) {
        [SVProgressHUD showErrorWithStatus:T(@"密码不能为空")];
        return false;
    }
    
    NSString *pattern = @"[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,15}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL usernameIsLegal = [test evaluateWithObject:username];
    
    if (!usernameIsLegal) {
        [SVProgressHUD showErrorWithStatus:T(@"账号输入不合法")];
        return false;
    }
    BOOL passwordIsLegal = [test evaluateWithObject:password];
    if (!passwordIsLegal) {
        [SVProgressHUD showErrorWithStatus:T(@"密码输入不合法")];
        return false;
    }

    return true;
}

@end
