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

#import "RequestManager.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *loginStrField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];  
}
- (IBAction)registerButtonClick:(UIButton *)sender
{
//    RegisterViewController *registerVc = [UIStoryboard storyboardWithName:NSStringFromClass([RegisterViewController class]) bundle:nil].instantiateInitialViewController;
//    [self.navigationController pushViewController:registerVc animated:YES];
    
    [[RequestManager sharedManager] regiestWithUserLoginStr:@"HAODEBOBO" userPassword:@"qweqwe"];
    
}

- (IBAction)loginButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)dealloc
{
    NSLog(@"我死了");
}



@end
