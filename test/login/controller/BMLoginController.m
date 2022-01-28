//
//  BMLoginController.m
//  test
//
//  Created by tdem on 2021/11/29.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMLoginController.h"
#import "TKPhoneTextField.h"

@interface BMLoginController ()<UITextFieldDelegate>
{
    bool isClickCode; //是否点击获取验证码
}
@property(copy,nonatomic) NSString * accountNumber;
@property(copy,nonatomic) NSString * mmmm;
@property(copy,nonatomic) NSString * user;


@end

@implementation BMLoginController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isClickCode = false;
    [self initCreate];
}

- (void)initCreate {
    self.codeView.hidden=YES;
    self.passwordV.hidden = YES;
    self.verficationHeightTop.constant = 20;
    self.phoneText.borderStyle=UITextBorderStyleNone;
    self.phoneText.backgroundColor =[UIColor clearColor];
    self.phoneText.delegate = self;
    
    //user.text=@"13419693608";
   // self.phoneText.keyboardType=UIKeyboardTypeNumberPad;
    self.phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTF.borderStyle=UITextBorderStyleNone;
    self.codeTF.backgroundColor =[UIColor clearColor];
    self.codeTF.delegate = self;
   // self.codeTF.keyboardType=UIKeyboardTypeNumberPad;
    self.codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.borderStyle=UITextBorderStyleNone;
   // self.passwordTF.keyboardType=UIKeyboardTypeNumberPad;
    self.passwordTF.secureTextEntry=YES;
    self.verficationTF.borderStyle=UITextBorderStyleNone;
    self.verficationTF.backgroundColor =[UIColor clearColor];
    self.verficationTF.delegate = self;
   // self.verficationTF.keyboardType=UIKeyboardTypeNumberPad;
    self.verficationTF.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (IBAction)getCodeBtn:(id)sender {
    isClickCode = true;
    self.codeView.hidden= NO;
    self.verficationHeightTop.constant = 90;
}
- (IBAction)codeloginAction:(id)sender {
    NSLog(@"codeloginAction");
    if (isClickCode) {
        self.codeView.hidden = NO;
    }
    self.passwordV.hidden = YES;
    self.verficationCodeV.hidden = NO;
    self.codeBtn.hidden = NO;
    [UIView animateWithDuration:0.6 animations:^{
        self.slideV.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.slideV.centerX = self.codeLoginBtn.centerX;
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:1 animations:^{
           self.slideV.transform = CGAffineTransformMakeScale(1.1, 1.1);
//        }];
    }];
    
}
- (IBAction)passwordLoginAction:(id)sender {
    NSLog(@"passwordLoginAction");

    self.codeView.hidden = YES;
    self.passwordV.hidden = NO;
    self.verficationCodeV.hidden = YES;
    self.passwordHeightTop.constant = 20;
    self.codeBtn.hidden = YES;
    [UIView animateWithDuration:0 animations:^{
        self.slideV.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            self.slideV.centerX = self.passwordLoginBtn.centerX;
            self.slideV.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
    }];
    
}


-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.codeTF resignFirstResponder];
   [self.passwordTF resignFirstResponder];
    [self.verficationTF resignFirstResponder];
    [self.phoneText resignFirstResponder];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.codeTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.verficationTF resignFirstResponder];
    [self.phoneText resignFirstResponder];
}

//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == self.phoneText) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 13) {
            
            return NO;
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;
}
@end
