


//
//  RoomPlayViewController.m
//  DHPlayRoomDemo
//
//  Created by 胡大海 on 17/2/8.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "RoomPlayViewController.h"

#import <IJKMediaFramework/IJKMediaFramework.h>

#import <UIImageView+WebCache.h>

#import <Masonry.h>

@interface RoomPlayViewController ()

@property (nonatomic, strong) UIImageView* imageView;

@property (nonatomic, strong) IJKFFMoviePlayerController* player;

@property (nonatomic, strong) UIButton* backBtn;

@end

@implementation RoomPlayViewController

- (void)backClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [self.view addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置直播占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_liveItem.creator.portrait]];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 拉流地址
    NSURL *url = [NSURL URLWithString:_liveItem.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，反正被销毁
    _player = playerVc;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    playerVc.view.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y + 20, screenRect.size.width, screenRect.size.height - 20);
    
    [self.view insertSubview:playerVc.view atIndex:1];
    
    self.backBtn.frame = CGRectMake(10, 20, 80, 40);
    [self.view addSubview:self.backBtn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:nil];
    }
    
    return _imageView;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"<<返回" forState:UIControlStateNormal];
        
        [_backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

@end
