//
//  DHBusMediator.h
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/6.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DHBusConnectProtocal;

@interface DHBusMediator : NSObject

#pragma mark - 向总控制中心注册挂接点

//connector自load过程中，注册自己
+(void)registerConnector:(nonnull id<DHBusConnectProtocal>)connector;

#pragma mark - 页面跳转接口

//判断某个URL能否导航
+(BOOL)canRouteURL:(nonnull NSURL *)URL;

//通过URL直接完成页面跳转
+(BOOL)routeURL:(nonnull NSURL *)URL;

+(BOOL)routeURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params;

//通过URL获取viewController实例
+(nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL;
+(nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params;


#pragma mark - 服务调用接口

//根据protocol获取服务实例
+(nullable id)serviceForProtocol:(nonnull Protocol *)protocol;

@end
