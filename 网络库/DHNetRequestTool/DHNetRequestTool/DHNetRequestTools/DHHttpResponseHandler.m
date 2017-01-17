


//
//  DHHttpResponseHandler.m
//  DHNetRequestTool
//
//  Created by 胡大海 on 17/1/17.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "DHHttpResponseHandler.h"

@implementation DHHttpResponseHandler

- (instancetype)init
{
    if (self = [super init]) {
        self.resopnseBodyType = DHHttpResponseBodyTypeJson;
    }
    
    return self;
}

@end
