

//
//  DHBusMediator.m
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/6.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "DHBusMediator.h"

#import "DHBusConnectProtocal.h"

//保存各个模块的connector实例
static NSMutableDictionary<NSString *, id<DHBusConnectProtocal>> *g_connectorMap = nil;

@implementation DHBusMediator

#pragma mark - 向总控制中心注册挂接点

+(void)registerConnector:(nonnull id<DHBusConnectProtocal>)connector {
    if (![connector conformsToProtocol:@protocol(DHBusConnectProtocal)]) {
        return;
    }
    
    @synchronized (g_connectorMap) {
        if (!g_connectorMap) {
            g_connectorMap = [[NSMutableDictionary alloc] initWithCapacity:5];
        }
        
        NSString* connectClsStr = NSStringFromClass([connector class]);
        
        if (![g_connectorMap objectForKey:connectClsStr] && connectClsStr.length) {
            [g_connectorMap setObject:connector forKey:connectClsStr];
        }
    }
}

#pragma mark - 页面跳转接口

//判断某个URL能否导航
+(BOOL)canRouteURL:(nonnull NSURL *)URL {
    if (!g_connectorMap || g_connectorMap.count <= 0) {
        return NO;
    }
    
    __block BOOL bCanRoute = NO;
    
    //遍历总线上的VC 看是否有响应URL的VC 不能并发--NSEnumerationReverse
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<DHBusConnectProtocal>  _Nonnull connectObj, BOOL * _Nonnull stop) {
        if ([connectObj respondsToSelector:@selector(canOpenSchemeURL:)]) {
            if ([connectObj canOpenSchemeURL:URL]) {
                bCanRoute = YES;
                *stop = YES;
            }
        }
    }];
    
    return bCanRoute;
}

+(BOOL)routeURL:(nonnull NSURL *)URL {
    return [self routeURL:URL withParameters:nil];
}

+(BOOL)routeURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params {
    
    if (!g_connectorMap || g_connectorMap.count <= 0) {
        return NO;
    }
    
    __block BOOL success = NO;
    __block NSInteger queryCount = 0;
    NSDictionary *userParams = [self userParametersWithURL:URL andParameters:params];
    NSLog(@"%@", userParams);
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<DHBusConnectProtocal>  _Nonnull connectObj, BOOL * _Nonnull stop) {
        queryCount++;
        if ([connectObj respondsToSelector:@selector(connectToOpenURL:params:)]) {
            id returnObj = [connectObj connectToOpenURL:URL params:userParams];
            
            if (returnObj && [returnObj isKindOfClass:[UIViewController class]]) {
                
                success = YES;
                
                *stop = YES;
            }
        }
    }];
    
    
    return success;
}

+(nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params {
    return nil;
}

+(nullable id)serviceForProtocol:(nonnull Protocol *)protocol {
    if(!g_connectorMap || g_connectorMap.count <= 0) return nil;
    
    __block id returnServiceImp = nil;
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<DHBusConnectProtocal>  _Nonnull connector, BOOL * _Nonnull stop) {
        if([connector respondsToSelector:@selector(connectToHandleProtocol:)]){
            returnServiceImp = [connector connectToHandleProtocol:protocol];
            if(returnServiceImp){
                *stop = YES;
            }
        }
    }];
    
    return returnServiceImp;
}


+(nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL {
    return nil;
}

/**
 * 从url获取query参数放入到参数列表中
 */
+(NSDictionary *)userParametersWithURL:(nonnull NSURL *)URL andParameters:(nullable NSDictionary *)params{
    NSArray *pairs = [URL.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *userParams = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *key = [kv objectAtIndex:0];
            NSString *value = [self URLDecodedString:[kv objectAtIndex:1]];
            [userParams setObject:value forKey:key];
        }
    }
    [userParams addEntriesFromDictionary:params];
    return [NSDictionary dictionaryWithDictionary:userParams];
}


/**
 * 对url的value部分进行urlDecoding
 */
+(nonnull NSString *)URLDecodedString:(nonnull NSString *)urlString
{
    NSString *result = urlString;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                   (__bridge CFStringRef)urlString,
                                                                                                   CFSTR(""),
                                                                                                   kCFStringEncodingUTF8);
#else
    result = [urlString stringByRemovingPercentEncoding];
#endif
    return result;
}

@end
