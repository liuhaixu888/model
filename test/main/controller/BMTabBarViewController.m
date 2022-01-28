//
//  BMTabBarViewController.m
//  test
//
//  Created by tdem on 2021/11/30.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMTabBarViewController.h"
#import "BMTabBar.h"
@interface BMTabBarViewController ()

@end

@implementation BMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewControllers];
    
//    [self loadTabBarItems];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViewControllers {
    
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc1 = [sb1 instantiateInitialViewController];
    [self controller:vc1 Title:@"首页" tabBarItemImage:@"black_home" tabBarItemSelectedImage:@"black_home"];
    
    UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"patient" bundle:nil];
    UIViewController *vc2 = [sb2 instantiateInitialViewController];
    [self controller:vc2 Title:@"患者" tabBarItemImage:@"black_mine" tabBarItemSelectedImage:@"black_mine"];

    
    UIStoryboard *sb3 = [UIStoryboard storyboardWithName:@"case" bundle:nil];
    UIViewController *vc3 = [sb3 instantiateInitialViewController];
    [self controller:vc3 Title:@"案例" tabBarItemImage:@"black_file" tabBarItemSelectedImage:@"black_file"];

    
    UIStoryboard *sb4 = [UIStoryboard storyboardWithName:@"account" bundle:nil];
    UIViewController *vc4 = [sb4 instantiateInitialViewController];
    [self controller:vc4 Title:@"账号" tabBarItemImage:@"black_people" tabBarItemSelectedImage:@"black_people"];

    
    UIStoryboard *sb5 = [UIStoryboard storyboardWithName:@"help" bundle:nil];
    UIViewController *vc5 = [sb5 instantiateInitialViewController];
    [self controller:vc5 Title:@"帮助" tabBarItemImage:@"black_c" tabBarItemSelectedImage:@"black_c"];

    
    self.viewControllers = @[vc1, vc2, vc3, vc4, vc5];
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

- (void)loadTabBarItems {
    
    WSTabBarItem *item1 = [WSTabBarItem tabBarItemWithTitle:@"首页" itemImage:[UIImage imageNamed:@"black_home"] selectedImage:[UIImage imageNamed:@"black_home"]];
    
    WSTabBarItem *item2 = [WSTabBarItem tabBarItemWithTitle:@"患者" itemImage:[UIImage imageNamed:@"black_mine"] selectedImage:[UIImage imageNamed:@"black_mine"]];
    
    WSTabBarItem *item3 = [WSTabBarItem tabBarItemWithTitle:@"案例" itemImage:[UIImage imageNamed:@"black_file"] selectedImage:[UIImage imageNamed:@"black_file"]];
    
    WSTabBarItem *item4 = [WSTabBarItem tabBarItemWithTitle:@"账号" itemImage:[UIImage imageNamed:@"black_people"] selectedImage:[UIImage imageNamed:@"black_people"]];
    
    WSTabBarItem *item5 = [WSTabBarItem tabBarItemWithTitle:@"帮助" itemImage:[UIImage imageNamed:@"black_c"] selectedImage:[UIImage imageNamed:@"black_c"]];
    
    WSTabBar *tabBar = [WSTabBar tabBarWithItems:@[item1, item2, item3, item4, item5] itemClick:^(NSInteger index) {
        
        self.selectedIndex = index;
        
    } ];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
