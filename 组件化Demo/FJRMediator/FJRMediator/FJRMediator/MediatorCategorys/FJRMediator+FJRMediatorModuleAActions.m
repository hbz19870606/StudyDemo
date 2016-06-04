//
//  FJRMediator+FJRMediatorModuleAActions.m
//  FJRMediator
//
//  Created by 胡大海 on 16/6/4.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "FJRMediator+FJRMediatorModuleAActions.h"

NSString * const kFJRMediatorTargetA = @"A";
NSString * const kFJRMediatorActionNativFetchDetailViewController = @"nativeFetchDetailViewController";

NSString * const kFJRMediatorActionRemoteFetchDetailViewController = @"remoteFetchDetailViewController";

NSString * const kFJRMediatorActionNativePresentImage = @"nativePresentImage";
NSString * const kFJRMediatorActionNativeNoImage = @"nativeNoImage";

NSString * const kFJRMediatorActionShowAlert = @"showAlert";

@implementation FJRMediator (FJRMediatorModuleAActions)

- (UIViewController*)FJRMediator_RemoteViewControllerForDetailByURL:(NSURL*)url{
    UIViewController* viewController = [self performActionWithUrl:url completion:^(NSDictionary *info) {
        
    }];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}


- (UIViewController*)FJRMediator_viewControllerForDetail {
	
    UIViewController* viewController = [self performTarget:kFJRMediatorTargetA action:kFJRMediatorActionNativFetchDetailViewController params:@{@"key":@"value"}];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (void)FJRMediator_presentImage:(UIImage*)image {
    if (image) {
        [self performTarget:kFJRMediatorTargetA action:kFJRMediatorActionNativePresentImage params:@{@"image":image}];
    } else {
        [self performTarget:kFJRMediatorTargetA action:kFJRMediatorActionNativeNoImage params:@{@"image":[UIImage imageNamed:@"noImage"]}];
    }
}

- (void)FJRMediator_showAlertWithMessage:(NSString*)message cancelAction:(void(^)(NSDictionary* info))cancelAction confirmAction:(void(^)(NSDictionary* info))confirmAction {
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    [self performTarget:kFJRMediatorTargetA
                 action:kFJRMediatorActionShowAlert
                 params:paramsToSend];
}

@end
