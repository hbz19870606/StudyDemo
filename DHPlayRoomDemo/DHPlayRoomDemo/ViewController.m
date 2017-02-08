//
//  ViewController.m
//  DHPlayRoomDemo
//
//  Created by 胡大海 on 17/2/7.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking.h>

#import <Masonry.h>

#import "OtherRoomViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton* captureBtn;

@property (nonatomic, strong) UIButton* playBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播Demo";
   
    [self.view addSubview:self.captureBtn];
    [self.view addSubview:self.playBtn];
    
    [self.captureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.mas_equalTo(@100);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.captureBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.mas_equalTo(self.captureBtn.mas_bottom).mas_offset(@20);
    }];
}

- (void)myPlayRoom
{
    
}

- (void)othersPlayRoom
{
    OtherRoomViewController* otherRoomsVC = [OtherRoomViewController new];
    
    [self.navigationController pushViewController:otherRoomsVC animated:YES];
}

- (UIButton *)captureBtn
{
    if (!_captureBtn) {
        _captureBtn = [UIButton new];
        
        _captureBtn.backgroundColor = [UIColor greenColor];
        [_captureBtn setTitle:@"我要开播" forState:UIControlStateNormal];
        
        [_captureBtn addTarget:self action:@selector(myPlayRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _captureBtn;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton new];
        
        _playBtn.backgroundColor = [UIColor redColor];
        [_playBtn setTitle:@"主播列表" forState:UIControlStateNormal];
        
        [_playBtn addTarget:self action:@selector(othersPlayRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playBtn;
}

@end
