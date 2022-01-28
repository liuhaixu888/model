//
//  BMCaseViewController.m
//  test
//
//  Created by tdem on 2021/11/30.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMCaseViewController.h"
#import "FFSearchView.h"
#import "BMTableViewCell.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "SUPConditionView.h"

@interface BMCaseViewController ()<UITableViewDelegate, UITableViewDataSource, HomeMenuViewDelegate>
@property (nonatomic, strong) FFSearchView *searchView;
@property (nonatomic, retain) UIView * selectV;
@property (nonatomic ,strong)MenuView   * menu;

@end

@implementation BMCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn setImage:[UIImage imageNamed:@"about_arrar.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(classifyAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self createView];
        FFSearchView *searchV = [FFSearchView showSearchView:^(NSString *text) {
            NSLog(@"点击搜索");
//            FFNewViewController *vc = [FFNewViewController viewController];
//            vc.searchStr = text;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    self.searchView = searchV;
    [self setNavigationTitleView:_searchView];
    [self.searchView addNotice];
    
//    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //[weakSelf requestData];
    }];
    self.tableV.mj_header = refreshHeader;

    [self.tableV.mj_header beginRefreshing];
    
    SUPConditionView *demo = [[[NSBundle mainBundle] loadNibNamed:@"SUPConditionView" owner:nil options:nil]firstObject];
    demo.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width * 0.2, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height);
//    SUPConditionView *demo = [[SUPConditionView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width * 0.2, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height)];
    //demo.customDelegate = self;
    
    self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:demo isShowCoverView:YES];

}
- (void)requestData
{
//    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",url_articles,@(_page)];
//    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
//        if (successed) {
//            FFActivityModel *model = [FFActivityModel objectWithKeyValues:response.payload];
//            _dataArray = [model.data mutableCopy];
//            [_tableView reloadData];
//        }
//
//        [self.tableView.mj_header endRefreshing];
//
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {
    self.selectV = [[UIView alloc]initWithFrame:CGRectMake(18, 5, SCREEN_WIDTH-40, 210)];
    _selectV.layer.cornerRadius = 5;
    _selectV.layer.borderWidth = 1;
    [[_selectV layer] setShadowOffset:CGSizeMake(0.5, 1)];
    [[_selectV layer] setShadowRadius:4];
//    [[_selectV layer] setShadowOpacity:0.8];
//    [[_selectV layer] setShadowColor:[UIColor blackColor].CGColor];
    _selectV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectV];
    UIButton *imageViewBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];
    [_selectV addSubview:imageViewBtn];
    [imageViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(_selectV).offset((SCREEN_WIDTH-200)/5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    UILabel *textL = [[UILabel alloc] init];
    textL.text = @"放弃资料";
    [_selectV addSubview:textL];
    [textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn.mas_bottom).mas_offset(5);
    }];
    UIButton *imageViewBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn1 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn1 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];
     [_selectV addSubview:imageViewBtn1];
     [imageViewBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(imageViewBtn.mas_right).offset((SCREEN_WIDTH-200)/5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    UILabel *textL1 = [[UILabel alloc] init];
    textL1.text = @"放弃资料";
    [_selectV addSubview:textL1];
    [textL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn1.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn.mas_bottom).mas_offset(5);
    }];
    
    UIButton *imageViewBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn2 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn2 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];

      [_selectV addSubview:imageViewBtn2];
      [imageViewBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(20);
         make.left.mas_equalTo(imageViewBtn1.mas_right).offset((SCREEN_WIDTH-200)/5);
         make.width.mas_equalTo(40);
         make.height.mas_equalTo(50);
     }];
    UILabel *textL2 = [[UILabel alloc] init];
    textL2.text = @"放弃资料";
    [_selectV addSubview:textL2];
    [textL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn2.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn1.mas_bottom).mas_offset(5);
    }];
    UIButton *imageViewBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn3 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn3 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];
       [_selectV addSubview:imageViewBtn3];
       [imageViewBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(20);
          make.left.mas_equalTo(imageViewBtn2.mas_right).offset((SCREEN_WIDTH-200)/5);
          make.width.mas_equalTo(40);
          make.height.mas_equalTo(50);
      }];
    UILabel *textL3 = [[UILabel alloc] init];
    textL3.text = @"放弃资料";
    [_selectV addSubview:textL3];
    [textL3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn3.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn.mas_bottom).mas_offset(5);
    }];
    
    
    UIButton *imageViewBtn4  = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn4 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn4 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];
    [_selectV addSubview:imageViewBtn4];
    [imageViewBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textL.mas_bottom).offset(10);
        make.left.mas_equalTo(_selectV).offset((SCREEN_WIDTH-200)/5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    UILabel *textL4 = [[UILabel alloc] init];
    textL4.text = @"放弃资料";
    [_selectV addSubview:textL4];
    [textL4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn4.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn4.mas_bottom).mas_offset(5);
    }];
    UIButton *imageViewBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn5 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn5 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];
    [_selectV addSubview:imageViewBtn5];
    [imageViewBtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textL1.mas_bottom).offset(10);
        make.left.mas_equalTo(imageViewBtn.mas_right).offset((SCREEN_WIDTH-200)/5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    UILabel *textL5 = [[UILabel alloc] init];
    textL5.text = @"放弃资料";
    [_selectV addSubview:textL5];
    [textL5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn5.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn5.mas_bottom).mas_offset(5);
    }];
//
    UIButton *imageViewBtn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn6 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn6 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];

    [_selectV addSubview:imageViewBtn6];
    [imageViewBtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textL2.mas_bottom).offset(10);
        make.left.mas_equalTo(imageViewBtn5.mas_right).offset((SCREEN_WIDTH-200)/5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    UILabel *textL6 = [[UILabel alloc] init];
    textL6.text = @"放弃资料";
    [_selectV addSubview:textL6];
    [textL6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn6.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn6.mas_bottom).mas_offset(5);
    }];
    UIButton *imageViewBtn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageViewBtn7 setImage:[UIImage imageNamed:@"orange_people.png"] forState:UIControlStateNormal];
    [imageViewBtn7 setImage:[UIImage imageNamed:@"w.png"] forState:UIControlStateSelected];
    [_selectV addSubview:imageViewBtn7];
    [imageViewBtn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textL3.mas_bottom).offset(10);
        make.left.mas_equalTo(imageViewBtn2.mas_right).offset((SCREEN_WIDTH-200)/5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    UILabel *textL7 = [[UILabel alloc] init];
    textL7.text = @"放弃资料";
    [_selectV addSubview:textL7];
    [textL7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewBtn7.mas_centerX);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageViewBtn7.mas_bottom).mas_offset(5);
    }];
}

-(void)classifyAction {
//    FFNewViewController *vc = [FFNewViewController viewController];
//    vc.searchStr = text;
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self.menu show];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear +++++++++");
    [super viewWillDisappear:animated];
    self.parentViewController.title = @"最新";
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.searchView removeNotice];
}


//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    return _selectV;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [((MCViewController *)self.parentViewController).navigationBar endEditing:YES];
    
//    FFPostDetailViewController *vc = [FFPostDetailViewController viewController];
//    FFNewListItemModel *model = _dataArray[indexPath.row];
//    vc.postId = model.tid;
//    
//    [self.navigationController pushViewController:vc animated:YES];
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
