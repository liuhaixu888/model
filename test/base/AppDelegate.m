//
//  AppDelegate.m
//  test
//
//  Created by tdem on 2021/11/29.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "AppDelegate.h"
#import "BMLoginController.h"
#import "BMTabBarViewController.h"
#import "DBHMainTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    DBHMainTabbarController *mainTBC = [[DBHMainTabbarController alloc] init];
    _window.rootViewController = mainTBC;
    [_window makeKeyAndVisible];
    [self initProject];
    return YES;
}
- (void)initProject {
    
//    //设置图片缓存信息
//    [SDImageCache sharedImageCache].maxCacheAge = 7 * 24 * 60 * 60; //7天
//    [SDImageCache sharedImageCache].maxCacheSize = 1024 * 1024 * 100; //100MB
//    [SDImageCache sharedImageCache].maxMemoryCost = 1024 * 1024 * 40; //40MB
    
    //设置状态栏的样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //全局导航栏样式设置
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
