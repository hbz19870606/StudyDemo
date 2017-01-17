


//
//  DHHttpRequestManger.m
//  DHNetRequestTool
//
//  Created by 胡大海 on 17/1/17.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "DHHttpRequestManger.h"


@interface DHHttpRequestManger()

@property (nonatomic, strong) DHHttpResponseHandler* defaultResopnseHandler;

@end

@implementation DHHttpRequestManger

+ (instancetype)httpRequestManger
{
    return [self httpRequestMangerWithName:@"defaultManger"];
}

+ (instancetype)httpRequestMangerWithName:(NSString *)name
{
    static NSMutableDictionary* mangers;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!mangers) {
            mangers = [NSMutableDictionary dictionary];
        }
    });
    
    DHHttpRequestManger* manger = mangers[name];
    
    if (!manger) {
        manger = [DHHttpRequestManger new];
        mangers[name] = manger;
    }
    
    return manger;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.defaultResopnseHandler = [DHHttpResponseHandler new];
    }
    
    return self;
}

- (DHHttpRequest *)createRequest
{
    DHHttpRequest* request = [DHHttpRequest new];
    
    return request;
}

@end
