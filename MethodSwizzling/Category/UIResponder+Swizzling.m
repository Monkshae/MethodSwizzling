//
//  UIResponder+Swizzling.m
//  MethodSwizzling
//
//  Created by licong on 16/3/2.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "UIResponder+Swizzling.h"
#import "objc/runtime.h"
#import "ButtonSwizzlingController.h"
@implementation UIResponder (Swizzling)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [UIResponder swizzlingOriginalSelector:@selector(touchesEnded:withEvent:) swizzledSelector:@selector(gm_touchesEnded:withEvent:)];
        
    });
}


+ (void)swizzlingOriginalSelector:(SEL)origSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


- (void)gm_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [self gm_touchesEnded:touches withEvent:event];
    NSDate *date = [NSDate date];
    NSLog(@"time = %f",[date timeIntervalSince1970]);
    NSLog(@"UIResponder description = %@",event.description);
}


@end
