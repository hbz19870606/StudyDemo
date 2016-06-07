

//
//  DemoModuleAItemProtocal.h
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/7.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DemoModuleAItemProtocal <NSObject>

@required
@property(nonatomic, readwrite) NSString *__nonnull itemName;
@property(nonatomic, readwrite) int itemAge;

-(nonnull NSString *)description;


@optional
-(nonnull instancetype)initWithItemName:(nonnull NSString *)itemName
                                itemAge:(int)itemAge;

@end
