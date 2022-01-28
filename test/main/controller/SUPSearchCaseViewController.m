//
//  SUPSearchCaseViewController.m
//  test
//
//  Created by tdem on 2022/1/24.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPSearchCaseViewController.h"

@interface SUPSearchCaseViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation SUPSearchCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"创建");
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

    UILabel *label = [UILabel new];
    
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 200, 100, 100);
    
    label.text = [NSString stringWithFormat:@"%ld页",_index];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FFNewListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    
//    FFNewListItemModel *model = _dataArray[indexPath.row];
//    [cell updateCell:model];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"111";
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
