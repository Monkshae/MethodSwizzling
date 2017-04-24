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
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];

}


- (void)tapAction:(UITapGestureRecognizer *)gesture{
    NSLog(@"tap");
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}



@end
