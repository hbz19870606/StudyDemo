//
//  Target_A.h
//  FJRMediator
//
//  Created by 胡大海 on 16/6/4.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_A : NSObject

- (UIViewController *)Action_remoteFetchDetailViewController:(NSDictionary *)params;

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params;

- (id)Action_nativePresentImage:(NSDictionary *)params;

- (id)Action_showAlert:(NSDictionary *)params;

// 容错
- (id)Action_nativeNoImage:(NSDictionary *)params;

@end
