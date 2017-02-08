

//
//  OtherRoomViewController.m
//  DHPlayRoomDemo
//
//  Created by 胡大海 on 17/2/8.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "OtherRoomViewController.h"

#import <AFNetworking.h>

#import <Masonry.h>

#import <MJExtension.h>

#import "OtherRoomLiveItem.h"

#import "OtherRoomLiveTableViewCell.h"

#import "RoomPlayViewController.h"

@interface OtherRoomViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* livesArray;

@end

@implementation OtherRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"直播列表";
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 0, 0, 0));
    }];
    
    [self loadOthersRoomData];
}

- (void)loadOthersRoomData
{
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        self.livesArray = [OtherRoomLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.livesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherRoomLiveTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[OtherRoomLiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (self.livesArray.count > 0) {
        cell.liveItem = self.livesArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomPlayViewController *liveVc = [[RoomPlayViewController alloc] init];
    liveVc.liveItem = self.livesArray[indexPath.row];
    
    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (NSMutableArray *)livesArray
{
    if (!_livesArray) {
        _livesArray = [NSMutableArray array];
    }
    
    return _livesArray;
}

@end
