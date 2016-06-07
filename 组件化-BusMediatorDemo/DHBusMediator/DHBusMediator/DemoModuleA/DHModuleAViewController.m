



//
//  DHModuleAViewController.m
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/7.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "DHModuleAViewController.h"

@interface DHModuleAViewController ()

@property (nonatomic, strong, readwrite) UILabel *valueLabel;
@property (nonatomic, strong, readwrite) UIImageView *imageView;

@property (nonatomic, strong) UIButton *returnButton;

@end

@implementation DHModuleAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.returnButton];
}

#pragma mark - event response
- (void)didTappedReturnButton:(UIButton *)button
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - getters and setters
- (UILabel *)valueLabel
{
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 50)];
        _valueLabel.font = [UIFont systemFontOfSize:30];
        _valueLabel.textColor = [UIColor blackColor];
    }
    return _valueLabel;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 100, 50)];
        _imageView.image = [UIImage imageNamed:@"image"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)returnButton
{
    if (_returnButton == nil) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _returnButton.frame = CGRectMake(50, 300, 100, 50);
        [_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_returnButton setTitle:@"return" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _returnButton;
}

@end
