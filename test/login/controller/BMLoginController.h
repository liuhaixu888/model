//
//  BMLoginController.h
//  test
//
//  Created by tdem on 2021/11/29.
//  Copyright © 2021 tdem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKPhoneTextField.h"

@interface BMLoginController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *codeLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *passwordLoginBtn;
@property (weak, nonatomic) IBOutlet UIView *slideV;
@property (weak, nonatomic) IBOutlet TKPhoneTextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *passwordV;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordHeightTop;
@property (weak, nonatomic) IBOutlet UIView *verficationCodeV;
@property (weak, nonatomic) IBOutlet UITextField *verficationTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verficationHeightTop;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;



@end
