

//
//  DHHttpRequest.m
//  DHNetRequestTool
//
//  Created by 胡大海 on 17/1/17.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "DHHttpRequest.h"

@interface DHHttpRequest()

//请求头参数字典
@property (nonatomic, strong) NSMutableDictionary<NSString*, id> *mutableHeadersDict;

//请求参数字典
@property (nonatomic, strong) NSMutableDictionary<NSString*, id> *mutableParamsDict;

@property (nonatomic, strong) AFHTTPSessionManager* sessionManager;

@property (nonatomic, strong) NSURLSessionTask *task;

@property (nonatomic, strong) void (^successBlock)(DHHttpRequest* request);

@property (nonatomic, strong) void (^errorBlock)(DHHttpRequest* request);

@property (nonatomic, strong) DHHttpResponseHandler* responseHandler;

@end

@implementation DHHttpRequest

- (instancetype)initWithSessionManger:(AFHTTPSessionManager *)sessionManger
{
    if (self = [super init]) {
        
        self.sessionManager = sessionManger;
        self.responseHandler = [DHHttpResponseHandler new];
        self.requstType = DHHttpRequstTypeGet;
        self.requstBodyType = DHHttpRequstBodyTypeJson;
        self.mutableHeadersDict = [NSMutableDictionary dictionary];
        self.mutableParamsDict = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)setHeader:(NSString *)name value:(NSString *)value
{
    if (value) {
        self.mutableHeadersDict[name] = value;
    }
}

- (void)setHeaders:(NSDictionary<NSString *,NSString *> *)headers
{
    [headers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if (nil == obj) {
            *stop = YES;
            return;
        }
    }];
    
    self.mutableHeadersDict = [headers mutableCopy];
}

- (void)setParam:(NSString *)name value:(id)value
{
    if (value) {
        self.mutableParamsDict[name] = value;
    }
}

- (void)setParams:(NSDictionary<NSString *,id> *)params
{
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if (nil == obj) {
            *stop = YES;
            return;
        }
    }];
    
    self.mutableParamsDict = [params mutableCopy];
}

- (void)startRequestWithSuccessBlock:(void (^)(DHHttpRequest *))successBlock andErrorBlock:(void (^)(DHHttpRequest *))errorBlock
{
    if (!self.task) {
        
        self.successBlock = successBlock;
        self.errorBlock = errorBlock;
        
        AFHTTPRequestSerializer* requestSerializer;
        
        if (DHHttpRequstBodyTypeHttp == self.requstBodyType) {
            requestSerializer = [AFHTTPRequestSerializer serializer];
        }else{
            requestSerializer = [AFJSONRequestSerializer serializer];
        }
        
        AFHTTPResponseSerializer* responseSerializer;
        
        if (DHHttpResponseBodyTypeHttp == self.responseHandler.resopnseBodyType) {
            responseSerializer = [AFHTTPResponseSerializer serializer];
        }else{
            responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        [self.mutableHeadersDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull headerKey, id  _Nonnull headerValue, BOOL * _Nonnull stop) {
            [requestSerializer setValue:headerValue forHTTPHeaderField:headerKey];
        }];
        
        if (self.responseHandler.acceptContentTypes) {
            responseSerializer.acceptableContentTypes = self.responseHandler.acceptContentTypes;
        }
        
        self.sessionManager.requestSerializer = requestSerializer;
        self.sessionManager.responseSerializer = responseSerializer;
        
        self.task = [self generateTask];
    }
}

- (NSURLSessionDataTask *)generateTask
{
    NSURLSessionDataTask* task;
    
    void (^responseHandlerBlock)(id result, NSURLSessionDataTask* task) = [self createResponseHandlerBlock];
    
    if (DHHttpRequstTypeGet == self.requstType) {
        task = [self.sessionManager GET:self.requestUrlStr parameters:self.mutableParamsDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            responseHandlerBlock(responseObject, task);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             responseHandlerBlock(error, task);
        }];
    }else if (DHHttpRequstTypePost == self.requstType){
        task = [self.sessionManager POST:self.requestUrlStr parameters:self.mutableParamsDict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             responseHandlerBlock(responseObject, task);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             responseHandlerBlock(error, task);
        }];
    }
    
    return task;
}

- (void (^)(id result, NSURLSessionDataTask* task))createResponseHandlerBlock
{
    // 保证request销毁后，回调(网路异步请求返回)还能正常调用
    void (^successBlock)(DHHttpRequest *) = [self.successBlock copy];
    void (^errorBlock)(DHHttpRequest *) = [self.errorBlock copy];
    
    void(^responseHanderBlock)(id result, NSURLSessionDataTask* task) = ^(id result, NSURLSessionDataTask* task) {
        
        //处理网络请求返回的数据
        if (![result isKindOfClass:[NSError class]] && self.responseHandler) {
            //解析数据--架构待实现
            if (successBlock) {
                //self.responseData
                successBlock(self);
            }
        }
        
        if ([result isKindOfClass:[NSError class]]) {
            //错误处理--架构待实现
            if (errorBlock) {
                //self.error
                errorBlock(self);
            }
        }
    };
    
    return responseHanderBlock;
}

- (void)cancelRequest
{
    [self.task cancel];
}

@end
