//
//  SUPInfoUserViewController.h
//  test
//
//  Created by tdem on 2022/1/21.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "BMBaseViewController.h"
/// 数据源代理
@protocol SUPInfoUserViewControllerDelegate <NSObject>

/// 返回cell个数
- (void)clickCase:(int)index;

@end

@interface SUPInfoUserViewController : BMBaseViewController
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic)id<SUPInfoUserViewControllerDelegate>  delegate;
@property (weak, nonatomic) IBOutlet UIView *dataView;

@end
