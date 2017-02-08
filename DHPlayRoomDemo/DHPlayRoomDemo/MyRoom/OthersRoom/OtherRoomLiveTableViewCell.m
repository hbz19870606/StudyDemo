


//
//  OtherRoomLiveTableViewCell.m
//  DHPlayRoomDemo
//
//  Created by 胡大海 on 17/2/8.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "OtherRoomLiveTableViewCell.h"

#import <Masonry.h>

#import <UIImageView+WebCache.h>

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface OtherRoomLiveTableViewCell()

@property (nonatomic, strong) UIView* infoBgView;

@property (nonatomic, strong) UILabel* addressLabel;
@property (strong, nonatomic) UILabel *liveLabel;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel     *nameLabel;
@property (strong, nonatomic) UILabel     *chaoyangLabel;
@property (strong, nonatomic) UIImageView *bigPicView;

@end

@implementation OtherRoomLiveTableViewCell

- (void)setLiveItem:(OtherRoomLiveItem *)liveItem
{
    _liveItem = liveItem;
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",liveItem.creator.portrait]];
    
    [self.headImageView sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    if (liveItem.city.length == 0) {
        _addressLabel.text = @"难道在火星?";
    }else{
        _addressLabel.text = liveItem.city;
    }
    
    self.nameLabel.text = liveItem.creator.nick;
    
    [self.bigPicView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", liveItem.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", liveItem.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.chaoyangLabel.attributedText = attr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = Color(216, 216, 216);
        
        [self.contentView addSubview:self.infoBgView];
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.chaoyangLabel];
        
        [self.contentView addSubview:self.bigPicView];
        [self.contentView addSubview:self.liveLabel];
        
        [self makeViewsConstraints];
    }
    
    return self;
}

- (void)makeViewsConstraints
{
    [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(@0);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom).mas_offset(@10);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@5);
        make.left.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(@10);
        make.top.mas_equalTo(@5);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
    }];
    
    [self.chaoyangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@-10);
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
    }];
    
    [self.bigPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).mas_offset(@10);
        make.left.right.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-20);
    }];
    
    [self.liveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bigPicView.mas_top).mas_offset(@20);
        make.right.mas_equalTo(@-10);
    }];
}

- (UIView *)infoBgView
{
    if (!_infoBgView) {
        _infoBgView = [UIView new];
        _infoBgView.backgroundColor = [UIColor whiteColor];
    }
    
    return _infoBgView;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:nil];
        
        _headImageView.layer.cornerRadius = 5;
        _headImageView.layer.masksToBounds = YES;
    }
    
    return _headImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor grayColor];
    }
    
    return _nameLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor grayColor];
    }
    
    return _addressLabel;
}

- (UILabel *)chaoyangLabel
{
    if (!_chaoyangLabel) {
        _chaoyangLabel = [UILabel new];
        
        _chaoyangLabel.font = [UIFont systemFontOfSize:14];
        _chaoyangLabel.textColor = [UIColor darkGrayColor];
    }
    
    return _chaoyangLabel;
}

- (UIImageView *)bigPicView
{
    if (!_bigPicView) {
        _bigPicView = [[UIImageView alloc] initWithImage:nil];
    }
    
    return _bigPicView;
}

- (UILabel *)liveLabel
{
    if (!_liveLabel) {
        _liveLabel = [UILabel new];
        _liveLabel.layer.cornerRadius = 5;
        _liveLabel.layer.masksToBounds = YES;
        
        _liveLabel.font = [UIFont systemFontOfSize:14];
        _liveLabel.backgroundColor = [UIColor lightGrayColor];
        _liveLabel.textColor = [UIColor whiteColor];
        _liveLabel.text = @"直播";
    }
    
    return _liveLabel;
}

@end
