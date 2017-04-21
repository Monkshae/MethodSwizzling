//
//  frameController.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/21.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "FrameController.h"
#import "UIView+MyViewAdditions.h"

@interface FrameController ()

@end

@implementation FrameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * view = [[UIView alloc]init];
    [view my_setFrame:CGRectMake(0, 100, 50, 50)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
}


@end
