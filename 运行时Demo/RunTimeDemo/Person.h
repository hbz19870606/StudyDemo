//
//  Person.h
//  RunTimeDemo
//
//  Created by 胡大海 on 17/1/11.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong)NSNumber* age;

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* something;

@end
