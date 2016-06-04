//
//  FJRMediator.h
//  FJRMediator
//
//  Created by 胡大海 on 16/6/3.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJRMediator : NSObject

+ (instancetype)sharedInstance;

/**
 *  远程App调用入口
 *
 *  @param url        url
 *  @param completion 完成后的回调
 *
 *  @return id
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

/**
 *  本地组件调用入口
 *
 *  @param targetName 要调用的组件名称
 *  @param actionName 要调用的组件方法
 *  @param params     调用组件参数
 *
 *  @return id
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end
