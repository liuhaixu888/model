//
//  BaseViewController.m
//  MyCountDownDay
//
//  Created by wangws1990 on 2017/1/21.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.navigationController.navigationBar.translucent = NO;
    //self.view.backgroundColor = [UIColor colorWithRGB:0xffffff];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
//    self.fd_interactivePopDisabled = NO;
//    self.fd_prefersNavigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [self setKeyBoardDismiss];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES ;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
