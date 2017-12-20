//
//  InputView.h
//  PYO
//
//  Created by Danyow.Ed on 2017/12/14.
//  Copyright © 2017年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

- (void)showInputViewReturnButtonClick:(void (^)(NSString *inputString))callback;

@end
