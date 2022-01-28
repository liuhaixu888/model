//
//  DBHMainTabbarController.h
//  TabbarItemTest
//
//  Created by DBH on 17/6/27.
//  Copyright © 2017年 邓毕华. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 数据源代理
@protocol DBHMainTabbarControllerDelegate <NSObject>

/// 返回cell个数
- (void)addCase;

@end
@interface DBHMainTabbarController : UITabBarController
@property (weak, nonatomic)id<DBHMainTabbarControllerDelegate>  delegate;
@end
