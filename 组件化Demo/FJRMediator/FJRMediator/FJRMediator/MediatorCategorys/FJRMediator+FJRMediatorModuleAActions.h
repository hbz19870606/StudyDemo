//
//  FJRMediator+FJRMediatorModuleAActions.h
//  FJRMediator
//
//  Created by 胡大海 on 16/6/4.
//  Copyright © 2016年 胡大海. All rights reserved.
//

#import "FJRMediator.h"
#import <UIKit/UIKit.h>

@interface FJRMediator (FJRMediatorModuleAActions)

- (UIViewController*)FJRMediator_RemoteViewControllerForDetailByURL:(NSURL*)url;

- (UIViewController*)FJRMediator_viewControllerForDetail;

- (void)FJRMediator_presentImage:(UIImage*)image;

- (void)FJRMediator_showAlertWithMessage:(NSString*)message cancelAction:(void(^)(NSDictionary* info))cancelAction confirmAction:(void(^)(NSDictionary* info))confirmAction;

@end
