//
//  ViewController.m
//  MethodSwizzling
//
//  Created by licong on 16/2/24.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "ViewController.h"
#import "objc/runtime.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
//#import "UIApplication+Swizzling.h"
//#import "UIWindow+Swizzling.h"
//#import "UIGestureRecognizer+Swizzling.h"

@interface ViewController ()

@end

@implementation ViewController


//+ (void)load{
//    
//    Method originalMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
//    Method swizzledMethod = class_getInstanceMethod([self class], @selector(lc_viewWillAppear:));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//    
//    
////    Method methodA = class_getInstanceMethod([self class], @selector(printA));
////    Method methodB = class_getInstanceMethod([self class], @selector(printB));
////    method_exchangeImplementations(methodA, methodB);
//
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.view.accessibilityIdentifier = @"KeyView";
    self.businessId = @"ViewControllerId";
    self.pageName = NSStringFromClass([ViewController class]);
    // Do any additional setup after loading the view, typically from a nib.
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self printA];
//    });
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"push" forState:UIControlStateNormal];
    button.accessibilityIdentifier = @"push";
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(120, 200, 100, 40);
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    UILabel *label = [[UILabel alloc]init];;
    label.text = @"哈哈";
    label.userInteractionEnabled  = YES;
    label.accessibilityIdentifier = @"haha";
    label.backgroundColor = [UIColor greenColor];
    label.frame = CGRectMake(120, 400, 100, 40);
    [self.view addSubview:label];
    
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
 
    
}

//- (void)printA{
//    NSLog(@"AAAAAAAAAAAAAAAAAAAA");
//}
//
//- (void)printB{
//    NSLog(@"BBBBBBBBBBBBBBBBBBBB");
//}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//}
//
//- (void)lc_viewWillAppear:(BOOL)animated{
//    [self lc_viewWillAppear:animated];
//    NSLog(@"lc_viewWillAppear");
//}

- (void)buttonClicked:(UIButton *)button{
    
    FourViewController *controler = [[FourViewController alloc]init];
    [self.navigationController pushViewController:controler animated:YES];
    
}


- (void)tapAction:(UITapGestureRecognizer *)gesture{
    
    NSLog(@"tap");
//    [self phobosDataWithPageName:@"大大" pageId:@"2131" referer:@"aasda"];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end
