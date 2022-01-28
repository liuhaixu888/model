//
//  SUPClinicalViewController.h
//  test
//
//  Created by tdem on 2022/1/21.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "BMBaseViewController.h"
/// 数据源代理
@protocol SUPClinicalViewControllerDelegate <NSObject>

/// 返回cell个数
- (void)clickCase:(int)index;

@end

@interface SUPClinicalViewController : BMBaseViewController
@property (weak, nonatomic)id<SUPClinicalViewControllerDelegate>  delegate;
// 特征
@property (weak, nonatomic) IBOutlet UIView *featuresV;
@property (weak, nonatomic) IBOutlet UIView *correntV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CorrentHeight;
@property (weak, nonatomic) IBOutlet UIView *correntView;
@property (weak, nonatomic) IBOutlet UITextField *correntTF;
@property (weak, nonatomic) IBOutlet UIView *allbodyV;
@property (weak, nonatomic) IBOutlet UIView *allergyV;
@property (weak, nonatomic) IBOutlet UIView *traumaV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *traumaH;
@property (weak, nonatomic) IBOutlet UIView *traumaCheckV;
@property (weak, nonatomic) IBOutlet UITextField *traumaTF;
@property (weak, nonatomic) IBOutlet UIView *inheritanceV;
@property (weak, nonatomic) IBOutlet UIView *inheritanceCheckV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inheritanceH;
@property (weak, nonatomic) IBOutlet UITextField *inhertanceTF;
@property (weak, nonatomic) IBOutlet UIView *jointV;  // 关节检查
@property (weak, nonatomic) IBOutlet UIView *oralV;   // 口腔不良
@property (weak, nonatomic) IBOutlet UIView *treatmentV; // 治疗动机

@end
