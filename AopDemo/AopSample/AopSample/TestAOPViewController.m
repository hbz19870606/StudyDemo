
//
//  TestAOPViewController.m
//  AopDemo
//
//  Created by 胡大海 on 16/6/6.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "TestAOPViewController.h"

@interface TestAOPViewController ()

@property (nonatomic, strong) UIButton* testBtn;

@end

@implementation TestAOPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.testBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
}

- (void)btnClicked:(UIButton*)btn
{
    NSLog(@"btn clicked....");
}

- (UIButton *)testBtn
{
    if (!_testBtn) {
        _testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 64, 100, 50)];
        [_testBtn setTitle:@"点击统计" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    }
    
    return _testBtn;
}

@end
