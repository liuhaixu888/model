//
//  SUPOralScanViewController.m
//  test
//
//  Created by tdem on 2022/1/22.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPOralScanViewController.h"
#import "HXProvincialCitiesCountiesPickerview.h"
#import "HXAddressManager.h"

@interface SUPOralScanViewController ()
@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;
@end

@implementation SUPOralScanViewController
- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
            __strong typeof(wself) self = wself;
            [wself.selectAdress setTitle:[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName] forState:UIControlStateNormal];
        };
        [self.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}
- (IBAction)selectAreaAction:(id)sender {
    NSLog(@"地址！！");
    NSString *address = self.selectAdress.titleLabel.text;
    NSArray *array = [address componentsSeparatedByString:@" "];
    
    NSString *province = @"";//省
    NSString *city = @"";//市
    NSString *county = @"";//县
    if (array.count > 2) {
        province = array[0];
        city = array[1];
        county = array[2];
    } else if (array.count > 1) {
        province = array[0];
        city = array[1];
    } else if (array.count > 0) {
        province = array[0];
    }
    [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
