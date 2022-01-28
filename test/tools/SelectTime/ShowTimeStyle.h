//
//  ShowTimeStyle.h
//  YSWS-iOS
//
//  Created by jiarui on 2020/7/31.
//  Copyright © 2020 nacker. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^Mytimeblck) (NSString * timestr);
@interface ShowTimeStyle : UIView<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIImageView * blackView;
@property (nonatomic, strong) UIPickerView   *pickerView;
@property(nonatomic,strong)UILabel * label;//标题
@property(nonatomic,copy)NSString * timeStr;//回传的时间

@property(nonatomic,assign)TimeState timeStyle;//显示风格

@property (nonatomic, strong)NSMutableArray * nianArr;// 年 数据源
@property (nonatomic, strong)NSMutableArray * yueArr;// 月 数据源
@property (nonatomic, strong)NSMutableArray * riArr;// 日 数据源

@property (nonatomic, strong)NSArray * timeArrC;// : 数据源

@property(nonatomic,assign)int nian;
@property(nonatomic,assign)int yue;
@property(nonatomic,assign)int ri;

@property(nonatomic,copy) Mytimeblck timeBlockA;

@property(nonatomic,copy)NSString * initialTimeStr;//初始时间


@property(assign,nonatomic)NSInteger indexA;
@property(assign,nonatomic)NSInteger indexB;
@property(assign,nonatomic)NSInteger indexC;

@end

NS_ASSUME_NONNULL_END
