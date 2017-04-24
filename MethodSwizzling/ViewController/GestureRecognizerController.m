//
//  SecondViewController.m
//  MethodSwizzling
//
//  Created by licong on 16/2/24.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "GestureRecognizerController.h"
#import "objc/runtime.h"

@implementation GestureRecognizerController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"2 viewWillAppear");
}

//- (void)lc_viewWillAppear:(BOOL)animated{
//    [self lc_viewWillAppear:animated];
//    NSLog(@"2 lc_viewWillAppear -- 下面将是有关埋点的统计代码");
//}



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}



@end
