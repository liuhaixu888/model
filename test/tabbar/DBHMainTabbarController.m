//
//  DBHMainTabbarController.m
//  TabbarItemTest
//
//  Created by DBH on 17/6/27.
//  Copyright © 2017年 邓毕华. All rights reserved.
//

#import "DBHMainTabbarController.h"
#import "SUPAddCaseViewController.h"
#import "DBHTabBar.h"
#import "ViewController.h"
#import "BMLoginController.h"
/**
 *  将16进制rgb颜色转换成UIColor
 */
#define COLORFROM16(RGB, A) [UIColor colorWithRed:((float)((RGB & 0xFF0000) >> 16)) / 255.0 green:((float)((RGB & 0xFF00) >> 8)) / 255.0 blue:((float)(RGB & 0xFF)) / 255.0 alpha:A]

@interface DBHMainTabbarController ()<DBHTabBarDelegate>

@property (nonatomic, strong) NSArray *vcTitleArray;
@property (nonatomic, strong) NSArray *vcItemArray;
@property (nonatomic, strong) UINavigationController *nav1;
@end

@implementation DBHMainTabbarController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self addAllChildViewController];
    
    DBHTabBar *tabBar = [[DBHTabBar alloc] init];
    //取消tabBar的透明效果
    tabBar.translucent = NO;
    // 设置tabBar的代理
    tabBar.myDelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - Private Methods
// 初始化所有的子控制器
- (void)addAllChildViewController {
//    for (NSInteger i = 0; i < self.vcTitleArray.count; i++) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.title = self.vcTitleArray[i];
//        vc.tabBarItem.image = [[UIImage imageNamed:self.vcItemArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_color", self.vcItemArray[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLORFROM16(0x62ac93, 1)} forState:UIControlStateSelected];
//
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        nav.tabBarItem.title = self.vcTitleArray[i];
//        nav.navigationBar.translucent = NO;
//        nav.navigationBar.shadowImage = [[UIImage alloc] init];
//        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//        [nav.navigationBar setTintColor:[UIColor whiteColor]];
//        [nav.navigationBar setBarTintColor:COLORFROM16(0x62ac93, 1)];
//        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//        [self addChildViewController:nav];
//    }
    [self loadViewControllers];
}
- (void)loadViewControllers {
    
    //ViewController *vc1 = [[ViewController alloc]init];
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc1 = [sb1 instantiateInitialViewController];
    [self controller:vc1 Title:@"首页" tabBarItemImage:@"black_home" tabBarItemSelectedImage:@"black_home"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav.tabBarItem.title = self.vcTitleArray[0];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.shadowImage = [[UIImage alloc] init];
    [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [nav.navigationBar setTintColor:[UIColor whiteColor]];
    [nav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self addChildViewController:nav];
    
    UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"patient" bundle:nil];
    UIViewController *vc2 = [sb2 instantiateInitialViewController];
    [self controller:vc2 Title:@"患者" tabBarItemImage:@"black_mine" tabBarItemSelectedImage:@"black_mine"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav1.tabBarItem.title = self.vcTitleArray[0];
    nav1.navigationBar.translucent = NO;
    nav1.navigationBar.shadowImage = [[UIImage alloc] init];
    [nav1.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [nav1.navigationBar setTintColor:[UIColor whiteColor]];
    [nav1.navigationBar setBarTintColor:COLORFROM16(0x62ac93, 1)];
    [nav1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addChildViewController:nav1];

    
    UIStoryboard *sb3 = [UIStoryboard storyboardWithName:@"case" bundle:nil];
    UIViewController *vc3 = [sb3 instantiateInitialViewController];
   // BMLoginController *vc3 = [[BMLoginController alloc] init];
    [self controller:vc3 Title:@"案例" tabBarItemImage:@"black_file" tabBarItemSelectedImage:@"black_file"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav2.tabBarItem.title = self.vcTitleArray[0];
    nav2.navigationBar.translucent = NO;
    nav2.navigationBar.shadowImage = [[UIImage alloc] init];
    [nav2.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [nav2.navigationBar setTintColor:[UIColor whiteColor]];
    [nav2.navigationBar setBarTintColor:COLORFROM16(0x62ac93, 1)];
    [nav2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addChildViewController:nav2];
    
    UIStoryboard *sb4 = [UIStoryboard storyboardWithName:@"account" bundle:nil];
    UIViewController *vc4 = [sb4 instantiateInitialViewController];
    [self controller:vc4 Title:@"账号" tabBarItemImage:@"black_people" tabBarItemSelectedImage:@"black_people"];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc4];
    nav3.tabBarItem.title = self.vcTitleArray[0];
    nav3.navigationBar.translucent = NO;
    nav3.navigationBar.shadowImage = [[UIImage alloc] init];
    [nav3.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [nav3.navigationBar setTintColor:[UIColor whiteColor]];
    [nav3.navigationBar setBarTintColor:[UIColor whiteColor]];
    [nav3.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addChildViewController:nav3];
//    self.viewControllers = @[vc1, vc2, vc3, vc4];
}

- (void)controller:(UIViewController *)controller Title:(NSString *)title tabBarItemImage:(NSString *)image tabBarItemSelectedImage:(NSString *)selectedImage
{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *imageHome = [UIImage imageNamed:selectedImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setSelectedImage:imageHome];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
}


#pragma DBHTabBarDelegate
/**
 *  点击了加号按钮
 */
- (void)tabBarDidClickPlusButton:(DBHTabBar *)tabBar
{
//    UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了加号按钮" preferredStyle:UIAlertControllerStyleAlert];
//    [promptAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//    [self presentViewController:promptAlert animated:YES completion:nil];
    NSLog(@"加号");
    SUPAddCaseViewController *VC = [[SUPAddCaseViewController alloc] init];
    UINavigationController *nav2 = self.selectedViewController;

    //VC.hidesBottomBarWhenPushed = YES;
    [nav2 pushViewController:VC animated:NO];
    //[self.navigationController pushViewController:VC animated:NO];
  // [self presentViewController:VC animated:NO completion:nil];

}

#pragma mark - Getters And Setters
- (NSArray *)vcTitleArray {
    if (!_vcTitleArray) {
        _vcTitleArray = @[@"私人医生", @"有偿问诊", @"平台推荐", @"我"];
    }
    return _vcTitleArray;
}
- (NSArray *)vcItemArray {
    if (!_vcItemArray) {
        _vcItemArray = @[@"医生footer", @"问诊footer", @"推荐footer", @"我的footer"];
    }
    return _vcItemArray;
}

@end
