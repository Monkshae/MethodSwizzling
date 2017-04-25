//
//  GMSwizzliedManager.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/24.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "GMSwizzliedManager.h"

@implementation GMSwizzliedManager

+ (instancetype)shareManager {
    static GMSwizzliedManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[[self class] alloc] init];
    });
    return shareManager;
}


+ (void)load{
    
}


//获取当前屏幕显示的viewcontroller
- ( UIViewController *)getCurrentController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentControllerFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentControllerFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    
    if([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentControllerFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentControllerFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


@end

