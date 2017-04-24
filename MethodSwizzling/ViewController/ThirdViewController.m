//
//  ThirdViewController.m
//  MethodSwizzling
//
//  Created by licong on 16/3/1.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "ThirdViewController.h"
#import "objc/runtime.h"


@implementation ThirdViewController


+ (void)load{
    
    Method originalMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(lc_viewWillAppear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@" 3 viewWillAppear");
}

- (void)lc_viewWillAppear:(BOOL)animated{
    [self lc_viewWillAppear:animated];
    NSLog(@" 3 lc_viewWillAppear -- 下面将是有关埋点的统计代码");
}


@end
