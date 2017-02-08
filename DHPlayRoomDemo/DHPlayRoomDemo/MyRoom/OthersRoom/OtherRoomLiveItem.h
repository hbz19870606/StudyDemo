//
//  OtherRoomLiveItem.h
//  DHPlayRoomDemo
//
//  Created by 胡大海 on 17/2/8.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OtherRoomLiverInfo.h"

@interface OtherRoomLiveItem : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) OtherRoomLiverInfo *creator;

@end
