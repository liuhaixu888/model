//
//  SUPAddCaseViewController.m
//  test
//
//  Created by tdem on 2022/1/21.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPAddCaseViewController.h"
#import "CKSlideMenu.h"
#import "SUPInfoUserViewController.h"
#import "SUPClinicalViewController.h"
#import "SUPUploadPicViewController.h"
#import "SUPUploadXViewController.h"
#import "SUPOralScanViewController.h"
#import "SUPDiagnosisViewController.h"

@interface SUPAddCaseViewController ()
@property(nonatomic, retain) CKSlideMenu *slideMenu;
@end

@implementation SUPAddCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

    self.title = @"患者信息";
    
//        UIButton * leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        [leftBut setTitle:@"重置" forState:UIControlStateNormal];
//        [leftBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [leftBut setFrame:CGRectMake(0, 0, 40, 40)];
//        leftBut.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
//        [leftBut addTarget:self action:@selector(resetSelt) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pub_nav_white_back.png"] style:UIBarButtonSystemItemCancel target:self action:@selector(backAction)];
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
//        UIButton * rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightBut setTitle:@"确定" forState:UIControlStateNormal];
//        [rightBut setFrame:CGRectMake(0, 0, 40, 40)];
//        [rightBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        rightBut.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
//        [rightBut addTarget:self action:@selector(confirmSelt) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    NSArray *titles = @[@"今日",@"阿萨德",@"爱迪生",@"今日",@"阿萨德",@"爱迪生",@"爱迪生"];
    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i <titles.count ; i++) {
//        [arr addObject:[SUPInfoUserViewController new]];
//    }
    SUPInfoUserViewController * addcase = [SUPInfoUserViewController new];
    addcase.delegate = self;
    [arr addObject:addcase];
    SUPClinicalViewController * clinicase = [SUPClinicalViewController new];
    [arr addObject:clinicase];
    SUPUploadPicViewController * clinicase1 = [SUPUploadPicViewController new];
    [arr addObject:clinicase1];
    SUPUploadXViewController * clinicase2 = [SUPUploadXViewController new];
    [arr addObject:clinicase2];
    SUPOralScanViewController * clinicase3 = [SUPOralScanViewController new];
    [arr addObject:clinicase3];
    SUPDiagnosisViewController * clinicase4 = [SUPDiagnosisViewController new];
    [arr addObject:clinicase4];
    SUPClinicalViewController * clinicase5 = [SUPClinicalViewController new];
    [arr addObject:clinicase5];
    self.slideMenu = [[CKSlideMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) titles:titles controllers:arr];
    _slideMenu.bodyFrame = CGRectMake(0,  50, self.view.frame.size.width, self.view.frame.size.height - 50);
    _slideMenu.bodySuperView = self.view;
    _slideMenu.indicatorOffsety = 2;
    _slideMenu.indicatorWidth = 25;
    _slideMenu.titleStyle = SlideMenuTitleStyleGradient;
    _slideMenu.selectedColor = [UIColor orangeColor];
    _slideMenu.unselectedColor = [UIColor grayColor];
    [self.view addSubview:_slideMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickCase:(int)index {
    NSLog(@"调转");
    [_slideMenu scrollToIndex:1];
}
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:NO];
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
