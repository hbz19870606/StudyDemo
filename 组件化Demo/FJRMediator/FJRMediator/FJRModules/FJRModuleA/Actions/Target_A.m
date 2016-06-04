//
//  Target_A.m
//  FJRMediator
//
//  Created by 胡大海 on 16/6/4.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "Target_A.h"
#import "FJRModuleADetailViewController.h"

typedef void (^CTUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_A

- (UIViewController *)Action_remoteFetchDetailViewController:(NSDictionary *)params {
    FJRModuleADetailViewController* viewController = [FJRModuleADetailViewController new];
    
    viewController.valueLabel.text = params[@"key"];
    
    return viewController;
}

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params {
	
    FJRModuleADetailViewController* viewController = [FJRModuleADetailViewController new];
    
    viewController.valueLabel.text = params[@"key"];
    
    return viewController;
}

- (id)Action_nativePresentImage:(NSDictionary *)params {
    FJRModuleADetailViewController *viewController = [[FJRModuleADetailViewController alloc] init];
    viewController.valueLabel.text = @"this is image";
    viewController.imageView.image = params[@"image"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    return nil;
}

- (id)Action_showAlert:(NSDictionary *)params {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CTUrlRouterCallbackBlock callback = params[@"cancelAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CTUrlRouterCallbackBlock callback = params[@"confirmAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alert from Module A" message:params[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return nil;
}

- (id)Action_nativeNoImage:(NSDictionary *)params {
    FJRModuleADetailViewController *viewController = [[FJRModuleADetailViewController alloc] init];
    viewController.valueLabel.text = @"no image";
    viewController.imageView.image = [UIImage imageNamed:@"noImage"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    return nil;
}

@end
