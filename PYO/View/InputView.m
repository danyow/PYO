//
//  InputView.m
//  PYO
//
//  Created by Danyow.Ed on 2017/12/14.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import "InputView.h"

@interface InputView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (nonatomic, copy) void (^returnButtonClick)(NSString *);

@end

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
        self.inputField.delegate = self;
    }
    return self;
}

#pragma mark -  publick method

- (void)showInputViewReturnButtonClick:(void (^)(NSString *inputString))callback
{
    [self.inputField becomeFirstResponder];
    self.returnButtonClick = callback;
}

#pragma mark -  UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.returnButtonClick) {
        self.returnButtonClick(textField.text);
    }
    return YES;
}



@end
