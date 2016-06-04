//
//  ViewController.m
//  FJRMediator
//
//  Created by 胡大海 on 16/6/4.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "ViewController.h"

#import "FJRMediator+FJRMediatorModuleAActions.h"

NSString * const kCellIdentifier = @"kCellIdentifier";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        UIViewController *viewController = [[FJRMediator sharedInstance] FJRMediator_viewControllerForDetail];
        
        // 获得view controller之后，在这种场景下，到底push还是present，其实是要由使用者决定的，mediator只要给出view controller的实例就好了
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
    if (indexPath.row == 1) {
        UIViewController *viewController = [[FJRMediator sharedInstance] FJRMediator_viewControllerForDetail];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (indexPath.row == 2) {
        // 这种场景下，很明显是需要被present的，所以不必返回实例，mediator直接present了
        [[FJRMediator sharedInstance] FJRMediator_presentImage:[UIImage imageNamed:@"image"]];
    }
    
    if (indexPath.row == 3) {
        // 这种场景下，参数有问题，因此需要在流程中做好处理
        [[FJRMediator sharedInstance] FJRMediator_presentImage:nil];
    }
    
    if (indexPath.row == 4) {
        [[FJRMediator sharedInstance] FJRMediator_showAlertWithMessage:@"brooke" cancelAction:nil confirmAction:^(NSDictionary *info) {
            // 做你想做的事
            NSLog(@"%@", info);
        }];
    }
    
    if (5 == indexPath.row) {
        UIViewController *viewController = [[FJRMediator sharedInstance] FJRMediator_RemoteViewControllerForDetailByURL:[NSURL URLWithString:@"appmediator://A/remoteFetchDetailViewController?key=valueInInfo"]];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[@"native present detail view controller", @"native push detail view controller", @"native present image", @"native present image when error", @"native show alert", @"remote open cmd"];
    }
    return _dataSource;
}

@end
