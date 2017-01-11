//
//  ViewController.m
//  RunTimeDemo
//
//  Created by 胡大海 on 17/1/11.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "ViewController.h"

#import "NSObject+DHDictToModel.h"

#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 创建一个字典 */
    NSDictionary *dict = @{
                           @"name":@"小明",
                           @"age":@18,
                           @"title":@"master",
                           @"height":@1.7,
                           @"something":@"nothing"
                           };
    
    Person* person = [Person dh_ModelWithDict:dict];
    
    NSLog(@"%@", person.debugDescription);
}


@end
