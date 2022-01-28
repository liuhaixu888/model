//
//  BMAccountViewController.m
//  test
//
//  Created by tdem on 2021/11/30.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMAccountViewController.h"
#import "SUPInformationViewController.h"
#import "BMLoginController.h"
@interface BMAccountViewController ()

@end

@implementation BMAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self creatView];
    [self setShadow:_infoView];
    [self setShadow:_downlodV];
    [self setShadow:_tableV];
    [self setShadow:_adjustV];
    [self createHeadView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfoAction)];
    [_infoView addGestureRecognizer:tap];
    
}

- (UIView *)createHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIView *upBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    upBgView.backgroundColor = HexColor(0xaa2d1b);
    [self.view addSubview:upBgView];
    
    if (_loginUser) {
        
        
    } else {
       // upBgView.height = 224;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 15)];
        label.text = @"登录3D社群，体验更多功能";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [upBgView addSubview:label];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"注册/登录" forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        loginButton.layer.masksToBounds = YES;
        loginButton.layer.cornerRadius = 5;
        loginButton.layer.borderWidth = 1;
        loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        loginButton.frame = CGRectMake((SCREEN_WIDTH - 102)/2.0, CGRectGetMaxY(label.frame) + 24, 102, 38);
        [loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
        [upBgView addSubview:loginButton];
        
        //        UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        downButton.frame = CGRectMake(0, CGRectGetMaxY(upBgView.frame) + 11, SCREEN_WIDTH, 44);
        //        downButton.backgroundColor = [UIColor whiteColor];
        //        [headView addSubview:downButton];
        //
        //        UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 0, 200, 44)];
        //        downLabel.text = @"联系代理商";
        //        downLabel.textColor = HexColor(0x5f5f5f);
        //        downLabel.font = [UIFont systemFontOfSize:13];
        //        [downButton addSubview:downLabel];
    }
    
    return headView;
    
}

- (void)clickLogin:(UIButton *)button
{
    BOOL isPost = NO;;
    if (button.tag == 1000) isPost = YES;
    BMLoginController *vc = [[BMLoginController alloc]initWithNibName:@"BMLoginController" bundle:nil];
    //vc.isPost = isPost;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapInfoAction {
    SUPInformationViewController *vc = [[SUPInformationViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)creatView {
    
}

- (void)setShadow:(UIView *)shadowView {
    
    shadowView.layer.cornerRadius = 5;
    shadowView.layer.borderWidth = 0;
    [[shadowView layer] setShadowOffset:CGSizeMake(0.5, 1)];
    [[shadowView layer] setShadowRadius:4];
    [[shadowView layer] setShadowOpacity:0.8];
    [[shadowView layer] setShadowColor:[UIColor blackColor].CGColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
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
