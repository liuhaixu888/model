//
//  BMPatientViewController.m
//  test
//
//  Created by tdem on 2021/11/30.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMPatientViewController.h"
#import "CKSlideMenu.h"
#import "FFSearchView.h"
#import "BMTableViewCell.h"
#import "SUPJournalViewController.h"
@interface BMPatientViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *datalist;
@property (nonatomic, strong) NSMutableArray *searchlist;
@end

@implementation BMPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    [self setControllers];
}
-(void)setControllers{
    //表格的创建
    self.tableV.separatorStyle=UITableViewCellSelectionStyleNone;
    //UISearchController的创建
    //创建UISearchController
//    self.searchController= [[UISearchController alloc]initWithSearchResultsController:nil];
//    //设置代理
//    self.searchController.searchResultsUpdater=self;
//    //设置UISearchController的显示属性，以下3个属性默认为YES
//    //搜索时，背景变暗色
//    self.searchController.dimsBackgroundDuringPresentation=NO;
//    //搜索时，背景变模糊
//    self.searchController.obscuresBackgroundDuringPresentation=NO;
//    self.searchController.searchBar.showsCancelButton =NO;
//
//
//    //隐藏导航栏
//    self.searchController.hidesNavigationBarDuringPresentation=NO;
//    self.searchController.searchBar.frame=CGRectMake(0,0,self.searchController.searchBar.frame.size.width,44.0);
    //添加到searchBar到tableView的header
    FFSearchView *searchV = [FFSearchView showSearchView:^(NSString *text) {
        NSLog(@"点击搜索");
        NSString *searchStr = text;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchStr];
        if (self.searchlist != nil) {
            [self.searchlist removeAllObjects];
        }
        self.searchlist = [NSMutableArray arrayWithArray:[_datalist filteredArrayUsingPredicate:predicate]];
        [_tableV reloadData];
    }];
    self.tableV.tableHeaderView=searchV;
    
    self.datalist = [NSMutableArray arrayWithCapacity:100];
    for (NSInteger i =1; i < 100; i++) {
        [self.datalist addObject:[NSString stringWithFormat:@"%d",i]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchlist.count > 0) {
        return self.searchlist.count;
    }else {
        return self.datalist.count;
    }
    
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
    
    if (self.searchlist.count > 0) {
        [cell.name setText:self.searchlist[indexPath.row]];
    } else {
        [cell.name setText:self.datalist[indexPath.row]];

    }
    //    FFNewListItemModel *model = _dataArray[indexPath.row];
    //    [cell updateCell:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUPJournalViewController *vc = [[SUPJournalViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *searchStr = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchStr];
    if (self.searchlist != nil) {
        [self.searchlist removeAllObjects];
    }
    self.searchlist = [NSMutableArray arrayWithArray:[_datalist filteredArrayUsingPredicate:predicate]];
    [_tableV reloadData];
    
    
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
