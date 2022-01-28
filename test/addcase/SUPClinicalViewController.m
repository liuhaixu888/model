//
//  SUPClinicalViewController.m
//  test
//
//  Created by tdem on 2022/1/21.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPClinicalViewController.h"
#import "CBGroupAndStreamView.h"
#import "ZZCheckBox.h"

@interface SUPClinicalViewController ()<CBGroupAndStreamDelegate,ZZCheckBoxDelegate, ZZCheckBoxDataSource>
{
    ZZCheckBox *_singleCheckBox;
    ZZCheckBox *_allbodyCheckBox;
    ZZCheckBox *_allergyCheckBox;
    ZZCheckBox *_traumaCheckBox;
    ZZCheckBox *_inheritanceCheckBox;
    ZZCheckBox *_treatmentCheckBox;
}
@property (strong, nonatomic) CBGroupAndStreamView * menueView;

@end

@implementation SUPClinicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"GroupAndStream";
    
//    UIButton * leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBut setTitle:@"重置" forState:UIControlStateNormal];
//    [leftBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [leftBut setFrame:CGRectMake(0, 0, 40, 40)];
//    leftBut.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
//    [leftBut addTarget:self action:@selector(resetSelt) forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton * rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBut setTitle:@"确定" forState:UIControlStateNormal];
//    [rightBut setFrame:CGRectMake(0, 0, 40, 40)];
//    [rightBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    rightBut.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
//    [rightBut addTarget:self action:@selector(confirmSelt) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSArray * titleArr = @[@"关系"];
    NSArray *contentArr = @[@[@"牙刷拥挤",@"牙列间隙",@"前突",@"牙刷拥挤",@"牙列间隙",@"前突",@"牙刷拥挤",@"牙列间隙",@"前突"]];
    
    CBGroupAndStreamView * silde = [[CBGroupAndStreamView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 135)];
    silde.delegate = self;
    silde.isDefaultSel = YES;
    silde.isSingle = YES;
    silde.radius = 10;
    silde.font = [UIFont systemFontOfSize:12];
    silde.titleTextFont = [UIFont systemFontOfSize:18];
    silde.singleFlagArr = @[@0];
    silde.defaultSelectIndex = 0;
    silde.defaultSelectIndexArr = @[@0];
    silde.selColor = [UIColor orangeColor];
    [silde setContentView:contentArr titleArr:titleArr];
    [_featuresV addSubview:silde];
    _menueView = silde;
    silde.cb_confirmReturnValueBlock = ^(NSArray *valueArr, NSArray *groupIdArr) {
        NSLog(@"valueArr = %@ \ngroupIdArr = %@",valueArr,groupIdArr);
    };
    silde.cb_selectCurrentValueBlock = ^(NSString *value, NSInteger index, NSInteger groupId) {
        NSLog(@"value = %@----index = %ld------groupId = %ld",value,index,groupId);
    };
    
    
    _singleCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _singleCheckBox.tag = 1;
    _singleCheckBox.delegate = self;
    _singleCheckBox.dataSource = self;
    
    _allbodyCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _allbodyCheckBox.tag = 2;
    _allbodyCheckBox.delegate = self;
    _allbodyCheckBox.dataSource = self;
    
    _allergyCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _allergyCheckBox.tag = 3;
    _allergyCheckBox.delegate = self;
    _allergyCheckBox.dataSource = self;
    
    _traumaCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _traumaCheckBox.tag = 4;
    _traumaCheckBox.delegate = self;
    _traumaCheckBox.dataSource = self;
    
    _inheritanceCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _inheritanceCheckBox.tag = 5;
    _inheritanceCheckBox.delegate = self;
    _inheritanceCheckBox.dataSource = self;
    
    _treatmentCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _treatmentCheckBox.tag = 6;
    _treatmentCheckBox.delegate = self;
    _treatmentCheckBox.dataSource = self;
    NSArray * titleArr1 = @[@""];

    NSArray *contentArr1 = @[@[@"牙刷拥挤",@"牙列间隙",@"前突",@"牙刷拥挤",@"牙列间隙",@"前突"]];
    
    CBGroupAndStreamView * silde1 = [[CBGroupAndStreamView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    silde1.delegate = self;
    silde1.isDefaultSel = YES;
    silde1.isSingle = YES;
    silde1.radius = 10;
    silde1.font = [UIFont systemFontOfSize:12];
    silde1.titleTextFont = [UIFont systemFontOfSize:18];
    silde1.singleFlagArr = @[@0];
    silde1.defaultSelectIndex = 0;
    silde1.defaultSelectIndexArr = @[@0];
    silde1.selColor = [UIColor orangeColor];
    [silde1 setContentView:contentArr1 titleArr:titleArr1];
    [_jointV addSubview:silde1];
    _menueView = silde1;
    silde1.cb_confirmReturnValueBlock = ^(NSArray *valueArr, NSArray *groupIdArr) {
        NSLog(@"valueArr = %@ \ngroupIdArr = %@",valueArr,groupIdArr);
    };
    silde1.cb_selectCurrentValueBlock = ^(NSString *value, NSInteger index, NSInteger groupId) {
        NSLog(@"value = %@----index = %ld------groupId = %ld",value,index,groupId);
    };
    NSArray * titleArr2 = @[@""];
    NSArray *contentArr2 = @[@[@"牙刷拥挤",@"牙列间隙",@"前突",@"牙刷拥挤",@"牙列间隙",@"前突"]];
    
    CBGroupAndStreamView * silde2 = [[CBGroupAndStreamView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    silde2.delegate = self;
    silde2.isDefaultSel = YES;
    silde2.isSingle = YES;
    silde2.radius = 10;
    silde2.font = [UIFont systemFontOfSize:12];
    silde2.titleTextFont = [UIFont systemFontOfSize:18];
    silde2.singleFlagArr = @[@0];
    silde2.defaultSelectIndex = 0;
    silde2.defaultSelectIndexArr = @[@0];
    silde2.selColor = [UIColor orangeColor];
    [silde2 setContentView:contentArr2 titleArr:titleArr2];
    [_oralV addSubview:silde2];
    _menueView = silde2;
    silde2.cb_confirmReturnValueBlock = ^(NSArray *valueArr, NSArray *groupIdArr) {
        NSLog(@"valueArr = %@ \ngroupIdArr = %@",valueArr,groupIdArr);
    };
    silde2.cb_selectCurrentValueBlock = ^(NSString *value, NSInteger index, NSInteger groupId) {
        NSLog(@"value = %@----index = %ld------groupId = %ld",value,index,groupId);
    };
    
}

- (void)resetSelt{
    [_menueView reset];
}

- (void)confirmSelt{
    [_menueView confirm];
}


#pragma mark---delegate
- (void)cb_confirmReturnValue:(NSArray *)valueArr groupId:(NSArray *)groupIdArr{
    NSLog(@"valueArr = %@ \ngroupIdArr = %@",valueArr,groupIdArr);
}

- (void)cb_selectCurrentValueWith:(NSString *)value index:(NSInteger)index groupId:(NSInteger)groupId{
    NSLog(@"value = %@----index = %ld------groupId = %ld",value,index,groupId);
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
    if (checkBox.tag == 1) {
        return self.correntV;
    } else if (checkBox.tag == 2){
        return self.allbodyV;
    }
    else if (checkBox.tag == 3){
        return self.allergyV;
    }
    else if (checkBox.tag == 4){
        return self.traumaCheckV;
    } else if (checkBox.tag == 5){
        return self.inheritanceCheckV;
    } else if (checkBox.tag == 6){
        return self.treatmentV;
    }
    return self.correntV;
}

-(CGRect)checkBox:(ZZCheckBox *)checkBox frameAtIndex:(NSInteger)index {

        if (index == 0) {
            return CGRectMake(20, 0, 100, 30);
        } else {
            return CGRectMake(130, 0, 100, 30);
        }
}

-(NSString *)checkBox:(ZZCheckBox *)checkBox titleForCheckBoxAtIndex:(NSInteger)index {
    if (checkBox.tag == 5) {
        if (index == 0) {
            return @"无类似畸形";
        } else {
            return @"有类似畸形";
        }
    } else {
        if (index == 0) {
            return @"无";
        } else {
            return @"有";
        }
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
            _CorrentHeight.constant = 49;
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 49 %ld Button", index);
            _correntTF.hidden = YES;
        } else {
            _CorrentHeight.constant = 90;
            _correntTF.hidden = NO;

            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 90 %ld Button", index);

        }
        [self.correntView setNeedsLayout];
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    } else if (checkBox.tag == 4) {
        if (index == 0) {
            _traumaH.constant = 49;
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 49 %ld Button", index);
            _traumaTF.hidden = YES;
        } else {
            _traumaH.constant = 90;
            _traumaTF.hidden = NO;
            
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 90 %ld Button", index);
            
        }
        [self.traumaV setNeedsLayout];
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    }else if (checkBox.tag == 5) {
        if (index == 0) {
            _inheritanceH.constant = 49;
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 49 %ld Button", index);
            _inhertanceTF.hidden = YES;
        } else {
            _inheritanceH.constant = 90;
            _inhertanceTF.hidden = NO;
            
            NSLog(@"ZZSingleCheckBox didSelectedAtIndex 90 %ld Button", index);
            
        }
        [self.inheritanceV setNeedsLayout];
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    }
    else {
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
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
