//
//  DHHttpRequest.h
//  DHNetRequestTool
//
//  Created by 胡大海 on 17/1/17.
//  Copyright © 2017年 胡大海. All rights reserved.
//


#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

#import "DHHttpResponseHandler.h"

typedef NS_ENUM(NSInteger, DHHttpRequstType){
    DHHttpRequstTypeGet,//Get
    DHHttpRequstTypePost,//Post
};

typedef NS_ENUM(NSInteger, DHHttpRequstBodyType){
    DHHttpRequstBodyTypeHttp,//Http
    DHHttpRequstBodyTypeJson,//Json
};

@interface DHHttpRequest : NSObject

/*
 * 请求的网络地址
 */
@property (nonatomic, strong) NSString* requestUrlStr;

/*
 * 请求方式为Get或者Post
 */
@property (nonatomic, assign) DHHttpRequstType requstType;

/*
 * 请求体数据格式为Http或者Json
 */
@property (nonatomic, assign) DHHttpRequstBodyType requstBodyType;

/*
 * 设置请求头单个参数
 */
- (void)setHeader:(NSString*)name value:(NSString*)value;

/*
 * 设置请求头多个参数
 */
- (void)setHeaders:(NSDictionary<NSString*, NSString*> *)headers;

/*
 * 设置一个请求体请求参数
 */
- (void)setParam:(NSString *)name value:(id)value;

/*
 * 设置多个请求体请求参数
 */
- (void)setParams:(NSDictionary<NSString *, id> *)params;

/*
 * 生成一个请求对象
 */
- (instancetype)initWithSessionManger:(AFHTTPSessionManager*)sessionManger;

/*
 * 发送网络请求（带有成功失败回调）
 */
- (void)startRequestWithSuccessBlock:(void (^)(DHHttpRequest* request))successBlock andErrorBlock:(void (^)(DHHttpRequest* request))errorBlock;

/*
 * 请求返回的数据
 */
@property (nonatomic, strong, readonly) id responseData;

/*
 * 请求返回的错误
 */
@property (nonatomic, strong, readonly) NSError* error;

/*
 * 取消网络请求
 */
- (void)cancelRequest;

@end
