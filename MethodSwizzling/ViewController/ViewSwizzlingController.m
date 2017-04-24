//
//  frameController.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/21.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "ViewSwizzlingController.h"
#import "UIView+Swizzling.h"
#import "UIControl+Swizzling.h"
@interface ViewSwizzlingController ()

@end

@implementation ViewSwizzlingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIView * view = [[UIView alloc]init];
//        view.frame = CGRectMake(0, 100, 50, 50);
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIControl *control = [[UIControl alloc]init];
        control.backgroundColor = [UIColor redColor];
        control.frame = CGRectMake(0, 100, 50, 50);
        [self.view addSubview:control];
    });

    
}


@end
