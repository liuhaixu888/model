//
//  BMHelpViewController.m
//  test
//
//  Created by tdem on 2021/11/30.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMHelpViewController.h"
#import "BMInforTableViewCell.h"


@interface BMHelpViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *table;

@end

@implementation BMHelpViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, screen_height) style:0];
    [self.table registerNib:[UINib nibWithNibName:@"BMInforTableViewCell" bundle:nil] forCellReuseIdentifier:@"BMInforTableViewCell"];

    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BMInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMInforTableViewCell"];
    cell.eeee.text = @"9999";
//    cell.eeee.backgroundColor = UIColor.redColor;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"123"];
//    }
//    cell.backgroundColor = UIColor.redColor;
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"dian ji");
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"";
//}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    return @"";
//}




@end
