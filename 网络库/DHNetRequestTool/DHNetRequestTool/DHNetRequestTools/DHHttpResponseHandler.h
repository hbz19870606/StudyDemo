//
//  DHHttpResponseHandler.h
//  DHNetRequestTool
//
//  Created by 胡大海 on 17/1/17.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DHHttpResponseBodyType){
    DHHttpResponseBodyTypeHttp,//Http
    DHHttpResponseBodyTypeJson,//Json
};

@interface DHHttpResponseHandler : NSObject

@property (nonatomic, assign) DHHttpResponseBodyType resopnseBodyType;

@property (nonatomic, strong) NSSet *acceptContentTypes; // 可以接受的mime返回类型，如text/plain、text/json、application/json

@end
