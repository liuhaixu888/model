//
//  SUPInfoUserViewController.m
//  test
//
//  Created by tdem on 2022/1/21.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPInfoUserViewController.h"
#import "ShowTimeStyle.h"

@interface SUPInfoUserViewController ()

@end

@implementation SUPInfoUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTapGesture];
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void) nextAction{
    NSLog(@"点击");
   [self.delegate clickCase:1];
    
}

- (void)setTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDate)];
    tap.numberOfTapsRequired = 1;
    [self.dataView addGestureRecognizer:tap];
}
-(void)selectDate{
    ShowTimeStyle * timeView=[[ShowTimeStyle alloc] init];
    timeView.timeBlockA = ^(NSString * _Nonnull timestr) {
        NSLog(@"%@", timestr);
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
