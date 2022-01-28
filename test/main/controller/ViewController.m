//
//  ViewController.m
//  test
//
//  Created by tdem on 2021/11/29.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "ViewController.h"
#import "GKCycleScrollView.h"
#import "GKPageControl.h"
#include "WMZPageController.h"
#import "DBHMainTabbarController.h"
#import "DFSegmentView.h"
#import "SUPSearchCaseViewController.h"
#import "SUPSegmentHeadView.h"
#import "BMTableViewCell.h"
#import "SUPInfoDetailViewController.h"
@interface ViewController ()<GKCycleScrollViewDataSource, GKCycleScrollViewDelegate,WMZPageMunuDelegate,UITableViewDelegate,UITableViewDataSource,SUPSegmentHeadViewDelegate>{
    BOOL click;
}

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) WMZPageMenuView *menuView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) GKCycleScrollView *cycleScrollView3;
@property (nonatomic, strong) SUPSearchCaseViewController *baseVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [self getTitleView];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"l.png"] style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    
    self.navigationItem.rightBarButtonItem= button;
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
    
    self.dataArr = @[@{@"title": @"GKCycleScrollView是一个轻量级可自定义轮播器", @"img_url": @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604640925739&di=cd001f10dfe79dffdc3ab56d70a8f2c9&imgtype=0&src=http%3A%2F%2Fp0.qhmsg.com%2Ft0133662f4be7939166.jpg"},
                     @{@"title": @"支持cell自定义，pageControl自定义", @"img_url": @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1603365312,3218205429&fm=26&gp=0.jpg"},
                     @{@"title": @"支持设置左右间距，上下间距（缩放）", @"img_url": @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3549859657,668339084&fm=26&gp=0.jpg"},
                     @{@"title": @"支持自动轮播，无限轮播", @"img_url": @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2941782042,3120113709&fm=26&gp=0.jpg"},
                     @{@"title": @"支持cell之间透明度渐变", @"img_url": @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1443270937,1017525655&fm=26&gp=0.jpg"}];

    
    GKCycleScrollView *cycleScrollView3 = [[GKCycleScrollView alloc] init];
    cycleScrollView3.dataSource = self;
    cycleScrollView3.delegate = self;
    cycleScrollView3.minimumCellAlpha = 0.0;
    cycleScrollView3.leftRightMargin = 20.0f;
    cycleScrollView3.topBottomMargin = 20.0f;
    //    cycleScrollView3.isAutoScroll = NO;
    [self.cycleView addSubview:cycleScrollView3];
    self.cycleScrollView3 = cycleScrollView3;
    
    GKPageControl *pageControl3 = [[GKPageControl alloc] init];
    pageControl3.style = GKPageControlStyleCycle;
    pageControl3.pageIndicatorTintColor = UIColor.redColor;
    pageControl3.currentPageIndicatorTintColor = UIColor.blueColor;
    cycleScrollView3.pageControl = pageControl3;
    [cycleScrollView3 addSubview:pageControl3];
    [cycleScrollView3 reloadData];
    
    [cycleScrollView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(130.0f);
    }];
    
    [pageControl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cycleScrollView3).offset(-15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(15.0f);
        make.centerX.mas_equalTo(cycleScrollView3);
    }];
    
    
    self.tableVIewCaseV.delegate = self;
    self.tableVIewCaseV.dataSource =self;
    
   // [self setupView];
    
//    DFSegmentView *segment = [DFSegmentView new];
//
//    segment.backgroundColor = [UIColor whiteColor];
//
//    [self.tableV addSubview:segment];
//
//    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableV).offset(0);
//        make.left.right.bottom.equalTo(self.tableV);
//    }];
//
//    segment.delegate = self;
//
//    segment.reloadTitleArr = @[@"aaa",@"qqq"];
//    [segment reloadData];
    
    
}


//- (UIViewController *)superViewController {
//    
//    return self;
//}
//
//- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
//    NSLog(@"------------------- %d",  index);
//    /*
//     如果有特殊的控制器 可以在这里判断操作
//     
//     如果这样操作了,获取的时候 就要注意了
//     
//     if (index == 2) {
//     
//     SpecificVC *specificVC = [SpecificVC new];
//     
//     return specificVC;
//     }
//     */
//    
////    if (_baseVC == NULL) {
//        self.baseVC = [SUPSearchCaseViewController new];
////    }
//    
//    _baseVC.index = index;
//    return self.baseVC;
//}
//
//#pragma dfsetment
//- (void)headTitleSelectWithIndex:(NSInteger)index {
//    
//    //  在这里可以获取到当前的baseViewController
//    //  对VC里面进行赋值 调方法进行网络请求或者一些逻辑操作
//    //  可以在当前控制器增加属性 currentIndex = index 在当前控制器 随时都可以用currentIndex获取到baseViewController
//    
//    NSLog(@"---%ld",index);
//}


#pragma mark - GKCycleScrollViewDataSource
- (NSInteger)numberOfCellsInCycleScrollView:(GKCycleScrollView *)cycleScrollView {
    return self.dataArr.count;
}

- (GKCycleScrollViewCell *)cycleScrollView:(GKCycleScrollView *)cycleScrollView cellForViewAtIndex:(NSInteger)index {
    GKCycleScrollViewCell *cell = [cycleScrollView dequeueReusableCell];
    if (!cell) {
        cell = [GKCycleScrollViewCell new];
//        if (cycleScrollView == self.cycleScrollView3) {
//            cell.layer.cornerRadius = 5.0f;
//            cell.layer.masksToBounds = YES;
//        }else if (cycleScrollView == self.cycleScrollView4) {
//            cell = [GKDemoTitleImageCell new];
//        }else if (cycleScrollView == self.cycleScrollView5) {
//            cell = [GKDemoTitleCell new];
//        }
    }
    
    // 设置数据
    NSDictionary *dict = self.dataArr[index];

//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"img_url"]]];
    cell.imageView.image = [UIImage imageNamed:@"h.png"];

    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    cell.imageView.backgroundColor = [UIColor yellowColor];

//    if ([cell isKindOfClass:[GKDemoTitleImageCell class]]) {
//        GKDemoTitleImageCell *titleImageCell = (GKDemoTitleImageCell *)cell;
//        titleImageCell.titleLabel.text = dict[@"title"];
//    }
//
//    if ([cell isKindOfClass:[GKDemoTitleCell class]]) {
//        GKDemoTitleCell *titleCell = (GKDemoTitleCell *)cell;
//        titleCell.titleLabel.text = dict[@"title"];
//    }
    
    return cell;
}

#pragma mark - GKCycleScrollViewDelegate
- (CGSize)sizeForCellInCycleScrollView:(GKCycleScrollView *)cycleScrollView {
    if (cycleScrollView == self.cycleScrollView3) {
        return CGSizeMake(self.view.frame.size.width, 130);
    } else {
        return CGSizeMake(self.view.frame.size.width, 130);
    }
}

- (void)cycleScrollView:(GKCycleScrollView *)cycleScrollView didScrollCellToIndex:(NSInteger)index {
//    if (cycleScrollView == self.cycleScrollView4) {
//        self.pageControl4.currentPage = index;
//
//        GKDemoTitleImageCell *cell = (GKDemoTitleImageCell *)cycleScrollView.currentCell;
//        NSLog(@"%@", cell.titleLabel.text);
//    }
}

- (void)cycleScrollView:(GKCycleScrollView *)cycleScrollView didSelectCellAtIndex:(NSInteger)index {
    NSLog(@"cell点击，index=%zd", index);
}

- (void)cycleScrollView:(GKCycleScrollView *)cycleScrollView scrollingFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex ratio:(CGFloat)ratio {
    if (cycleScrollView != self.cycleScrollView3) return;
    
    NSLog(@"fromIndex:%zd,toIndex:%zd,ratio:%f", fromIndex, toIndex, ratio);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.size.height = 60;
//    frame.origin.y = self.view.frame.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
//    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
    //此处需要设置barStyle，否则颜色会分成上下两层
}

- (UIView *) getTitleView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 35)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 35)];
    imageV.contentMode = UIViewContentModeScaleToFill;
    imageV.image = [UIImage imageNamed:@"logo.png"];
    [view addSubview:imageV];
    return view;
}

- (void)click {
    NSLog(@"通知");
    
}

#pragma tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 140;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SUPSegmentHeadView *segment = [[SUPSegmentHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    segment.delegate = self;
    segment.backgroundColor = [UIColor redColor];
    
    
//    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableV).offset(0);
//        make.left.right.bottom.equalTo(self.tableV);
//    }];
//   // segment.delegate = self;
//    
//    segment.reloadTitleArr = @[@"aaa",@"qqq"];
//    [segment reloadData];
//    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
//
//    view.backgroundColor = UIColor.purpleColor;
    return segment;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"BMTableViewCell";
    BMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //    FFNewListItemModel *model = _dataArray[indexPath.row];
    //    [cell updateCell:model];
    
    return cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUPInfoDetailViewController *vc = [[SUPInfoDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f ++++++++++++++++++", scrollView.contentOffset.y);
//    CGFloat sectionHeaderHeight = 40;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
}

#pragma arguments
- (void)selectWithIndex:(NSInteger)index {
    NSLog(@"selectWithIndexindex %d", index);
    
    
}


@end
