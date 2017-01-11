//
//  NSObject+DHDictToModel.m
//  RunTimeDemo
//
//  Created by 胡大海 on 17/1/11.
//  Copyright © 2017年 胡大海. All rights reserved.
//

#import "NSObject+DHDictToModel.h"

#import <objc/runtime.h>

@implementation NSObject (DHDictToModel)

const char *kPropertyListKey = "DHPropertyListKey";

+ (NSArray*)dh_objcProperties
{
    //获取关联对象
    NSArray* propertyList = objc_getAssociatedObject(self, kPropertyListKey);
    
    /* 如果 ptyList 有值,直接返回 */
    if (propertyList) {
        return propertyList;
    }
    
    /* 调用运行时方法, 取得类的属性列表 */
    /* 成员变量:
     * class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 方法:
     * class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 属性:
     * class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 协议:
     * class_copyProtocolList(__unsafe_unretained Class cls, unsigned int *outCount)
     */
    
    unsigned int outCount = 0;
    
    /**
     * 参数1: 要获取的类
     * 参数2: 类属性的个数指针
     * 返回值: 所有属性的数组, C 语言中,数组的名字,就是指向第一个元素的地址
     */
    /* retain, creat, copy 需要release */
    
    objc_property_t* propertiesList = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray* tempArray = [NSMutableArray array];
    
    /* 遍历所有属性 */
    for (unsigned int i = 0; i < outCount; i++) {
         /* 从数组中取得属性 */
        objc_property_t property = propertiesList[i];
        
        /* 从 property 中获得属性名称 */
        const char* propertyName_C = property_getName(property);
        
        /* 将 C 字符串转化成 OC 字符串 */
        NSString* propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        
        [tempArray addObject:propertyName_OC];
    }
    
    /* 设置关联对象 */
    /**
     *  参数1 : 对象self
     *  参数2 : 动态添加属性的 key
     *  参数3 : 动态添加属性值
     *  参数4 : 对象的引用关系
     */
    objc_setAssociatedObject(self, kPropertyListKey, tempArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    free(propertiesList);
    
    return tempArray.copy;
}

+ (instancetype)dh_ModelWithDict:(NSDictionary *)dict
{
    /* 实例化对象 */
    id instanceObjc = [[self alloc] init];
    
    /* 使用字典,设置对象信息 */
    /* 1. 获得 self 的属性列表 */
    NSArray* propertyList = [self dh_objcProperties];
    
    /* 2. 遍历字典 */
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         /* 3. 判断key是否在propertyList中*/
        if ([propertyList containsObject:key]) {
             /* 说明属性存在,可以使用 KVC 设置数值 */
            [instanceObjc setValue:obj forKey:key];
        }
    }];
    
    return instanceObjc;
}

@end
