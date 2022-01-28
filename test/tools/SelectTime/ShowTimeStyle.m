//
//  ShowTimeStyle.m
//  YSWS-iOS
//
//  Created by jiarui on 2020/7/31.
//  Copyright © 2020 nacker. All rights reserved.
//

#import "ShowTimeStyle.h"
#import "AppDelegate.h"


#define StartandEndwidth ((kScreenWidth-Scale(50))-Scale(80))/3
@implementation ShowTimeStyle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.frame=ZYF_kScreenBounds;
        self.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        self.nianArr=[NSMutableArray array];
        self.yueArr=[NSMutableArray array];
        self.riArr=[NSMutableArray array];
        self.timeStyle=YYYYMMDD;
        [self showTimeStyle];
    }
    return self;
}
-(void)setTimeStyle:(TimeState)timeStyle{
    _timeStyle=timeStyle;
    self.timeStr=[self getCurrentTimes:_timeStyle];
    [self.pickerView reloadAllComponents];
}

-(void)showTimeStyle{
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
    tap.delegate=self;
    [self addGestureRecognizer:tap];
    
    self.blackView=[[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-Scale(50), Scale(245))];
    self.blackView.center=CGPointMake(kScreenWidth/2, kScreenHeight/2);
    self.blackView.backgroundColor=[UIColor whiteColor];
    self.blackView.userInteractionEnabled=YES;
    self.blackView.layer.cornerRadius=Scale(10);
    [self addSubview:self.blackView];
    
    
    //改变透明度即可实现效果
    WeakSelf(myself);
    self.blackView.alpha=0;
    [UIView animateWithDuration:0.2 animations:^{
        myself.blackView.alpha = 1.0;
        myself.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [myself layoutIfNeeded];
    }];
    
    
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-Scale(50), Scale(45))];
    view.layer.cornerRadius=Scale(10);
    view.backgroundColor=[UIColor whiteColor];
    
    UIButton * btn=[[UIButton alloc] initWithFrame:CGRectMake(0, Scale(7), Scale(60), Scale(30))];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    self.label=[[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-Scale(50))/2-Scale(50), 0, Scale(100), Scale(45))];
    self.label.text=@"选择时间";
    self.label.textColor=[UIColor blackColor];
    self.label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:self.label];
    
    
    UIButton * btnB=[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-Scale(50)-Scale(60), Scale(7), Scale(60), Scale(30))];
    [btnB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnB setTitle:@"确定" forState:UIControlStateNormal];
    [btnB addTarget:self action:@selector(qiedingAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnB];
    [view addSubview:btnB];
    
    UIView * linview=[[UIView alloc] initWithFrame:CGRectMake(Scale(10), Scale(44), kScreenWidth-Scale(70), 0.6)];
    linview.backgroundColor=[UIColor grayColor];
    [view addSubview:linview];
    [self.blackView addSubview:view];

    //pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(Scale(30), Scale(45), (kScreenWidth-Scale(50))-Scale(60), Scale(165))];
    self.pickerView.backgroundColor=[UIColor clearColor];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.blackView addSubview:self.pickerView];
    [self.pickerView reloadAllComponents];

    //年
    for (int i=-100; i<100; i++) {
        NSString * str=[self getCurrentTimes:YYYY];
        int nian = [str intValue]-i;
        NSString * timestr=[NSString stringWithFormat:@"%d",nian];
        [self.nianArr addObject:timestr];
    }
    NSString * str=[NSString string];
    if (_initialTimeStr.length>0) {
        str=[_initialTimeStr substringWithRange:NSMakeRange(0, 4)];
    }else{
        str=[self getCurrentTimes:YYYY];
    }
    NSString * nianstr=[self getCurrentTimes:YYYY];
    int cha=[str intValue]-[nianstr intValue];
    self.nian=100-cha;
    //月
    for (int i=1; i<13; i++) {
        NSString * str=[NSString stringWithFormat:@"%02d",i];
        [self.yueArr addObject:str];
    }
    // 当前   月
    NSString * currentYue=[NSString string];
    if (_initialTimeStr.length>0) {
        currentYue=[_initialTimeStr substringWithRange:NSMakeRange(5, 2)];
    }else{
        currentYue=[self getCurrentTimes:MM];
    }
    for (int i=0; i<self.yueArr.count; i++) {
        NSString * yue=[NSString stringWithFormat:@"%02d",[self.yueArr[i] intValue]];
        if ([currentYue isEqualToString:yue]) {
            self.yue=i;
        }
    }
    //日
    [self getMMDDMessage:self.nianArr[self.nian] andYue:self.yueArr[self.yue]];
    // 当前   日
    NSString * currentRi=[NSString string];
    if (_initialTimeStr.length>0) {
        currentRi=[_initialTimeStr substringWithRange:NSMakeRange(8, 2)];
    }else{
        currentRi=[self getCurrentTimes:DD];
    }
    for (int i=0; i<self.riArr.count; i++) {
        NSString * ri=[NSString stringWithFormat:@"%02d",[self.riArr[i] intValue]];
        if ([currentRi isEqualToString:ri]) {
            self.ri=i;
        }
    }

    
    //默认选中
    self.indexA=[self.nianArr count]*500+self.nian;
    self.indexB=[self.yueArr count]*500+self.yue;
    self.indexC=[self.riArr count]*500+self.ri;

    [self.pickerView selectRow:[self.nianArr count]*500+self.nian inComponent:0 animated:NO];
    [self.pickerView selectRow:[self.yueArr count]*500+self.yue inComponent:1 animated:NO];
    [self.pickerView selectRow:[self.riArr count]*500+self.ri inComponent:2 animated:NO];
    //时间初始化
    self.timeStr=[self getCurrentTimes:_timeStyle];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.window) {
        [app.window addSubview:self];
    }
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations:^{
    self.alpha = 1;
    }];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    switch (_timeStyle) {
        case YYYY:
            return 1;
        case YYYYMM:
            return 2;
        case YYYYMMDD:
            return 3;
        default:
            break;
    }
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.nianArr.count*1000;
    }else if (component==1){
        return self.yueArr.count*1000;
    }else{
        return self.riArr.count*1000;
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [NSString stringWithFormat:@"%@年",self.nianArr[row%200]];
    }else if (component==1){
        return [NSString stringWithFormat:@"%@月",self.yueArr[row%12]];
    }else{
        return [NSString stringWithFormat:@"%@日",self.riArr[row%[self.riArr count]]];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //停止滚动代理方法
    if (component==0) {
        self.indexA=row;
        self.nian=(int)row%200;
        [self getDays];
    }else if (component==1){
        self.indexB=row;
        self.yue=(int)row%12;
        [self getDays];
    }else{
        self.indexC=row;
        self.ri=(int)row%[self.riArr count];
    }
    [self.pickerView reloadAllComponents];
    //获取时间
    [self getShowTime];
}
// 选择年份 月份 后 重新 计算日期
-(void)getDays{
    [self getMMDDMessage:self.nianArr[self.nian] andYue:self.yueArr[self.yue]];// 根据年份 月份 取日 数据
    self.indexC=[self.riArr count]*500+self.ri;
    if (_timeStyle==YYYYMMDD) {
        [self.pickerView selectRow:[self.riArr count]*500+self.ri inComponent:2 animated:NO];
    }
    //重新加载  self.pickerView
    [self.pickerView reloadAllComponents];
}

//每一列组件的列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {
        return StartandEndwidth;
    }else if(component==1){
        switch (_timeStyle) {
            case YYYY:
                return 0;
            case YYYYMM:
                return StartandEndwidth;
            case YYYYMMDD:
                return StartandEndwidth;
            default:
                break;
        }
    }else{
        switch (_timeStyle) {
            case YYYY:
                return 0;
            case YYYYMM:
                return 0;
            case YYYYMMDD:
                return StartandEndwidth;
            default:
                break;
        }
    }
    return 0;
}

//每一列组件的行高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return Scale(55);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
  
    for (UIView * singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = [UIColor grayColor];
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor=[UIColor blackColor];
        pickerLabel.textAlignment=NSTextAlignmentCenter;
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }

    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];

    return pickerLabel;
}
//获取时间
-(void)getShowTime{
    switch (_timeStyle) {
        case YYYY:
            self.timeStr=[NSString stringWithFormat:@"%@",self.nianArr[_nian]];
            break;
        case YYYYMM:
            self.timeStr=[NSString stringWithFormat:@"%@-%@",self.nianArr[_nian],self.yueArr[_yue]];
            break;
        case YYYYMMDD:
            self.timeStr=[NSString stringWithFormat:@"%@-%@-%@",self.nianArr[_nian],self.yueArr[_yue],self.riArr[_ri]];
            break;
        default:
            break;
    }
}

//确定   和  取消
-(void)cancelAction:(UIButton *)sender{
    [self removeSuperview];
}
-(void)qiedingAction:(UIButton *)sedner{
    NSLog(@"asdf=====%@",self.timeStr);
    if (self.timeBlockA) {
        self.timeBlockA(self.timeStr);
    }
    [self removeSuperview];
}

-(void)removeView:(UITapGestureRecognizer *)sender{
    [self removeSuperview];
}

-(void)removeSuperview{
    WeakSelf(myself);
    [UIView animateWithDuration:0.2 animations:^{
        myself.blackView.alpha = 0;
        myself.backgroundColor=[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    } completion:^(BOOL finished) {
        [myself removeFromSuperview];
    }];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view.superview isDescendantOfView:self.blackView]) {
        return NO;
    }
    return YES;
}

// 辅助方法
-(void)getMMDDMessage:(NSString *)year andYue:(NSString *)yue{
    [self.riArr removeAllObjects];
    NSInteger sum=[year integerValue];
    if ([self daysCountOfYear:sum]) {
        int int_yue=[yue intValue];
        if (int_yue==1||int_yue==3||int_yue==5||int_yue==7||int_yue==8||int_yue==10||int_yue==12) {
            for (int j=1; j<32;j++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",j];
                [self.riArr addObject:ristr];
            }
            self.ri=30;// 防止数组越界
            return;
        }
        if (int_yue==3||int_yue==4||int_yue==6||int_yue==7||int_yue==9||int_yue==11) {
            for (int k=1; k<31;k++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",k];
                [self.riArr addObject:ristr];
            }
            self.ri=29;// 防止数组越界
            return;
        }
        if (int_yue==2) {
            for (int h=1; h<30; h++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",h];
                [self.riArr addObject:ristr];
            }
            self.ri=28;// 防止数组越界
            return;
        }
    }else{
        int int_yue=[yue intValue];
        if (int_yue==1||int_yue==3||int_yue==5||int_yue==7||int_yue==8||int_yue==10||int_yue==12) {
            for (int j=1; j<32;j++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",j];
                [self.riArr addObject:ristr];
            }
            self.ri=30;// 防止数组越界
            return;
        }
        if (int_yue==3||int_yue==4||int_yue==6||int_yue==7||int_yue==9||int_yue==11) {
            for (int k=1; k<31;k++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",k];
                [self.riArr addObject:ristr];
            }
            self.ri=29;// 防止数组越界
            return;
        }
        if (int_yue==2) {
            for (int h=1; h<29; h++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",h];
                [self.riArr addObject:ristr];
            }
            self.ri=27;// 防止数组越界
            return;
        }
    }
}
-(BOOL) daysCountOfYear:(NSInteger) year //是否是 闰年     平年2月 28天   润年2月 29天
{
    if(year%4==0 && year%100!=0)//普通年份，非100整数倍
        return YES;//29
    if(year%400 == 0)
        //世纪年份
        return YES; //29
    return NO;
}


-(NSString *)getCurrentTimes:(TimeState)state{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    if (state==YYYYMMDD) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else if(state==HHMMSS){
        [formatter setDateFormat:@"HH:mm:ss"];
    }else if(state==YYYYMMDDHHMMSS){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if(state==MMSS){
        [formatter setDateFormat:@"mm:ss"];
    }else if(state==YYYYMMDDHHMM){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if(state==HHMM){
        [formatter setDateFormat:@"HH:mm"];
    }else if(state==YYYYMM){
        [formatter setDateFormat:@"yyyy-MM"];
    }else if(state==YYYY){
        [formatter setDateFormat:@"yyyy"];
    }else if(state==MM){
        [formatter setDateFormat:@"MM"];
    }else if(state==DD){
        [formatter setDateFormat:@"dd"];
    }else{
        
    }
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    //    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}
@end
