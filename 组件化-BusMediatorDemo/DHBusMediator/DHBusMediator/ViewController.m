//
//  ViewController.m
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/6.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "ViewController.h"

#import "DHBusMediator.h"
#import "DemoModuleAServiceProtocal.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, copy) NSArray* dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BusMediatorTestVC";
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            {
                [DHBusMediator routeURL:[NSURL URLWithString:@"appBusMediator://ADetail"] withParameters:@{@"key":@"label content"}];
            }
            break;
        case 4:
            {
                [[DHBusMediator serviceForProtocol:@protocol(DemoModuleAServiceProtocal)] moduleA_showAlertWithMessage:@"brooke" cancelAction:nil confirmAction:^(NSDictionary * _Nonnull info) {
                    NSLog(@"%@", info);
                }];
            }
            break;
        case 5:
            {
                id <DemoModuleAItemProtocal> item = [[DHBusMediator serviceForProtocol:@protocol(DemoModuleAServiceProtocal)] moduleA_getItemWithName:@"brooke" age:29];
                
                [[DHBusMediator serviceForProtocol:@protocol(DemoModuleAServiceProtocal)] moduleA_showAlertWithMessage:[item description] cancelAction:nil confirmAction:nil];
            }
            break;
            
        default:
            break;
    }
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"present detail view controller", @"push detail view controller", @"present image", @"present image when error", @"service: show alert", @"service:get protcol model", @"service: set protocol model", @"get url controller", @"route url with hook", @"route url not found"];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

@end
