


//
//  DemoModuleAItem.m
//  DHBusMediator
//
//  Created by 胡大海 on 16/6/7.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "DemoModuleAItem.h"

@implementation DemoModuleAItem

@synthesize itemName = _itemName;
@synthesize itemAge = _itemAge;

-(nonnull instancetype)initWithItemName:(nonnull NSString *)itemName
                                itemAge:(int)itemAge{
    self = [self init];
    if (self) {
        self.itemName = itemName;
        self.itemAge = itemAge;
    }
    return self;
}


-(nonnull NSString *)description{
    NSString *description = [NSString stringWithFormat:@"MduleA:itemName==%@,itemAge==%d", self.itemName, self.itemAge];
    return description;
}

@end
