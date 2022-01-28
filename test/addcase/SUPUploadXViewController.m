//
//  SUPUploadXViewController.m
//  test
//
//  Created by tdem on 2022/1/22.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPUploadXViewController.h"
#import "ZZCheckBox.h"

@interface SUPUploadXViewController ()<ZZCheckBoxDelegate, ZZCheckBoxDataSource>
{
    ZZCheckBox *_singleCheckBox;
}

@end

@implementation SUPUploadXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _singleCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _singleCheckBox.tag = 1;
    _singleCheckBox.delegate = self;
    _singleCheckBox.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZZCheckBoxDataSource
-(NSInteger)numberOfRowsInCheckBox:(ZZCheckBox *)checkBox {
    return 2;
}

-(UIView *)checkBox:(ZZCheckBox *)checkBox supperViewAtIndex:(NSInteger)index {
    return self.sumbitV;
}

-(CGRect)checkBox:(ZZCheckBox *)checkBox frameAtIndex:(NSInteger)index {
    
    if (index == 0) {
        return CGRectMake(20, 0, 100, 30);
    } else {
        return CGRectMake(130, 0, 100, 30);
    }
}

-(NSString *)checkBox:(ZZCheckBox *)checkBox titleForCheckBoxAtIndex:(NSInteger)index {
    
        if (index == 0) {
            return @"是";
        } else {
            return @"否";
        }
    return nil;
}

-(UIFont *)checkBox:(ZZCheckBox *)checkBox titleFontForCheckBoxAtIndex:(NSInteger)index {
    return [UIFont systemFontOfSize:15];
}

-(UIColor *)checkBox:(ZZCheckBox *)checkBox titleColorForCheckBoxAtIndex:(NSInteger)index {
    return [UIColor blackColor];
}

-(UIImage *)checkBox:(ZZCheckBox *)checkBox imageForCheckBoxAtIndex:(NSInteger)index forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        UIImage *image = [UIImage imageNamed:@""];
        return image;
    } else if (state == UIControlStateSelected) {
        UIImage *image = [UIImage imageNamed:@""];
        return image;
    }
    return nil;
}

#pragma mark - ZZCheckBoxDelegate
-(NSArray<NSNumber *> *)defaultSelectedIndexInCheckBox:(ZZCheckBox *)checkBox {
    return @[@1];
}

-(void)checkBox:(ZZCheckBox *)checkBox didDeselectedAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        NSLog(@"ZZSingleCheckBox Deselected %ld Button", index);
    } else {
        NSLog(@"ZZMutableCheckBox Deselected %ld Button", index);
    }
    
}

-(BOOL)canCancleCheckSingleCheckBox:(ZZCheckBox *)checkBox {
    if (checkBox.tag == 1) {
        return YES;
    }
    return NO;
}

-(void)checkBox:(ZZCheckBox *)checkBox didSelectedAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        if (index == 0) {
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 49 %ld Button", index);
        } else {
            
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 90 %ld Button", index);
            
        }
        
    }
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
