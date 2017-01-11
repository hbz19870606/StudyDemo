

//
//  Person.m
//  RunTimeDemo
//
//  Created by 胡大海 on 17/1/11.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"name:%@ age:%@ title: %@ something:%@", self.name, self.age, self.title, self.something];
}

@end
