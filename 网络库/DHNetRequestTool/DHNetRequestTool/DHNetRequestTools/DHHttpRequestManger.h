//
//  DHHttpRequestManger.h
//  DHNetRequestTool
//
//  Created by 胡大海 on 17/1/17.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DHHttpRequest.h"
#import "DHHttpResponseHandler.h"

@interface DHHttpRequestManger : NSObject

+(instancetype)httpRequestManger;

+(instancetype)httpRequestMangerWithName:(NSString*)name;

- (DHHttpRequest*)createRequest;

@end
