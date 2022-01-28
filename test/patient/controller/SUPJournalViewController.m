//
//  SUPJournalViewController.m
//  test
//
//  Created by tdem on 2022/1/26.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPJournalViewController.h"
#import "SUPJournalTableViewCell.h"


@interface SUPJournalViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SUPJournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden =YES;

    self.title = @"患者日志";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"SUPJournalTableViewCell";
    SUPJournalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    FFNewListItemModel *model = _dataArray[indexPath.row];
    //    [cell updateCell:model];
    [cell.numBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
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
