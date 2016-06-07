

//
//  DemoModuleAServiceProtocal.h
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/7.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoModuleAItemProtocal.h"


@protocol DemoModuleAServiceProtocal <NSObject>

@required
//服务接口1: 传入Message显示一个alert，并提供cancel和confirm的回调，这个例子是同步回调
//如果是异步回调，有实现这个接口的Impl自己去控制，保证多线程安全
-(void)moduleA_showAlertWithMessage:(nonnull NSString *)message
                       cancelAction:(void(^__nullable)(NSDictionary *__nonnull info))cancelAction
                      confirmAction:(void(^__nullable)(NSDictionary *__nonnull info))confirmAction;


//服务接口2: 提供外部组件一个协议化对象
-(nonnull id<DemoModuleAItemProtocal>)moduleA_getItemWithName:(nonnull NSString *)name
                                                    age:(int)age;


//服务接口3: 外部组件调用服务传入一个协议化对象
-(void)moduleA_deliveAprotocolModel:(nonnull id<DemoModuleAItemProtocal>)item;

@end
