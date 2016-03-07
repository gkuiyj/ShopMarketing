//
//  DataRecordViewController.m
//  ShopMarketing
//
//  Created by kaiser on 16/3/4.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import "DataRecordViewController.h"
#import "ShiXiang_HYSegmentedControl.h"
#import "ShopDBManager.h"
#import "PrizeInfoListCell.h"

//#define AppHeight (CurrentDeviceISiPad ? UIScreenWidth : UIScreenHeight)
//#define UIScreenWidth ([UIScreen mainScreen].bounds.size.width)
//#define UIScreenHeight ([UIScreen mainScreen].bounds.size.height)
//#define AppWidth (UIScreenWidth)

@interface DataRecordViewController ()<HYSegmentedControlDelegate>{
    NSMutableArray *_dataArray;
}

@end

@implementation DataRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"抽奖记录";
    
    _dataArray = [[NSMutableArray alloc] init];
    //顶部选项卡
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, AppWidth, 50)];
    selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectView];
    
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"已领奖",@"未领奖", nil];
    ShiXiang_HYSegmentedControl *segment = [[ShiXiang_HYSegmentedControl alloc] initWithOriginY:0 Titles:titleArray delegate:self Flag:NO];
    segment.delegate = self;
    [selectView addSubview:segment];
    
    [self getAlreadyPrizeInfoList];
}

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index{
    if (index == 0) {
        [self getAlreadyPrizeInfoList];
    }else{
        [self getAbandonPrizeInfoList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
}


- (void)getAlreadyPrizeInfoList{
    _dataArray = [ShopDBManager getAlreadyPrizeInfoList];
    [self.tableView reloadData];
}

- (void)getAbandonPrizeInfoList{
    _dataArray = [ShopDBManager getAbandonPrizeInfoList];
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegete/UITableViewDataSource --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"prizeInfoListCell";
    PrizeInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        //cell =[[PrizeInfoListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PrizeInfoListCell" owner:self options:nil];
        cell = nibs.lastObject;
    }
    PrizeInfoModel *m = [_dataArray objectAtIndex:indexPath.row];
    cell.phoneLb.text = m.phone;
    cell.levelLb.text = m.level;
    cell.prizeLb.text = m.prize;
    cell.timeLb.text = m.createTime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
