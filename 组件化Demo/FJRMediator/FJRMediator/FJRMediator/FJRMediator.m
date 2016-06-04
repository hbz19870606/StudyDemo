

//
//  FJRMediator.m
//  FJRMediator
//
//  Created by 胡大海 on 16/6/3.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "FJRMediator.h"

@implementation FJRMediator

+ (instancetype)sharedInstance {
    static FJRMediator* manger;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manger = [[self alloc] init];
    });
    
    return manger;
}

- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion {
    
    if (![url.scheme isEqualToString:@"appmediator"]) {
         // 这里就是针对远程app调用404的简单处理了，根据不同app的产品经理要求不同，可以在这里自己做需要的逻辑
        return @(NO);
    }
    
    NSMutableDictionary* requestParams = [NSMutableDictionary dictionary];
    
    NSString* urlQueryStr = [url query];
    
    for (NSString *param in [urlQueryStr componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [requestParams setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:requestParams];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    
    NSString* targetClassNameStr = [NSString stringWithFormat:@"Target_%@", targetName];
    NSString* actionNameStr = [NSString stringWithFormat:@"Action_%@:", actionName];
    
    Class targetClass = NSClassFromString(targetClassNameStr);
    id target = [[targetClass alloc] init];
    
    SEL targetSelector = NSSelectorFromString(actionNameStr);
    
    if (!target) {
        //没有可以相应的target  可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求
        return nil;
    }
    
    if ([target respondsToSelector:targetSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:targetSelector withObject:params];
#pragma clang diagnostic pop
    }else {
    
        SEL defaultAction = NSSelectorFromString(@"notFound:");
        
        if ([target respondsToSelector:defaultAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:defaultAction withObject:params];
#pragma clang diagnostic pop
        }else {
            //这里可以用上面的固定target的默认方法顶上
            return nil;
        }
    }
}

@end
