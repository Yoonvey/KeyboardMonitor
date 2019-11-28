//
//  ViewController.m
//  YVKeyboardMonitor
//
//  Created by Yoonvey on 2019/11/18.
//  Copyright © 2019 Yoonvey. All rights reserved.
//

#import "ViewController.h"

#import "KeyboardMonitor.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController () <UITextFieldDelegate, KeyboardDelegate>

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10, ScreenHeight - 174.5, ScreenWidth - 20, 44.5)];
    _textField1.borderStyle = UITextBorderStyleRoundedRect;
    _textField1.delegate = self;
    _textField1.tag = 0;
    _textField2.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:_textField1];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10, ScreenHeight - 114.5, ScreenWidth - 20, 44.5)];
    _textField2.borderStyle = UITextBorderStyleRoundedRect;
    _textField2.delegate = self;
    _textField2.tag = 1;
    _textField2.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:_textField2];
    
    _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10, ScreenHeight - 54.5, ScreenWidth - 20, 44.5)];
    _textField3.borderStyle = UITextBorderStyleRoundedRect;
    _textField3.delegate = self;
    _textField3.tag = 2;
    _textField3.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textField3];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [KeyboardMonitor sltObject].targetBounds = [textField convertRect:textField.bounds toView:window];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 0) {
        [_textField2 becomeFirstResponder];
    }
    else if (textField.tag == 1) {
        [_textField3 becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

#warning 无论使用代理方式还是block方式监听键盘事件，都需要在一下两个控制器的生命周期方法中注册/注销监听。
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [KeyboardMonitor sltObject].delegate = self;
    [self registerKeyboardMonitor];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [KeyboardMonitor sltObject].delegate = nil;
    [self resignKeyboardMonitor];
}

#pragma mark - <Block方式实现键盘监听>
- (void)registerKeyboardMonitor
{
    __weak ViewController *weakSelf = self;
    [KeyboardMonitor sltObject].keyboardChanged = ^(CGFloat deviant) {
        [UIView animateWithDuration:[KeyboardMonitor sltObject].animationTime animations:^{
            weakSelf.view.frame = CGRectMake(0, deviant, ScreenWidth, ScreenHeight);
        }];
    };
    [KeyboardMonitor sltObject].keyboardDismiss = ^{
        [UIView animateWithDuration:[KeyboardMonitor sltObject].animationTime animations:^{
            weakSelf.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        }];
    };
}

- (void)resignKeyboardMonitor
{
    [KeyboardMonitor sltObject].keyboardChanged = nil;
    [KeyboardMonitor sltObject].keyboardDismiss = nil;
}

#pragma mark - <代理方式实现键盘监听>
- (void)keyBoardWillChanged:(CGFloat)deviant
{
    [UIView animateWithDuration:[KeyboardMonitor sltObject].animationTime animations:^{
        self.view.frame = CGRectMake(0, deviant, ScreenWidth, ScreenHeight);
    }];
}

- (void)keyBoardWillDismiss
{
    [UIView animateWithDuration:[KeyboardMonitor sltObject].animationTime animations:^{
        self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
}

@end
