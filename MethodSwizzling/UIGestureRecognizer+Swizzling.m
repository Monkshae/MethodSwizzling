//
//  UIGestureRecognizer+Swizzling.m
//  MethodSwizzling
//
//  Created by licong on 16/3/2.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "UIGestureRecognizer+Swizzling.h"
#import "objc/runtime.h"
#import "objc/message.h"
#import "ViewController.h"

@implementation UIGestureRecognizer (Swizzling)


//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        [UIGestureRecognizer swizzlingOriginalSelector:@selector(setDelegate:) swizzledSelector:@selector(gm_setDelegate:)];
//        
//    });
//}


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


- (void)gm_setDelegate:(id<UIGestureRecognizerDelegate>)delegate{
    [self gm_setDelegate:delegate];
    if ([[self class] isSubclassOfClass:[UITapGestureRecognizer class]]) {
        
    
        Class class = [delegate class];
        SEL  origSelector = @selector(gestureRecognizerShouldBegin:);

        

        
        BOOL didAddMethod = class_addMethod(class, NSSelectorFromString(@"gm_gestureRecognizerShouldBegin"), (IMP)gm_gestureRecognizerShouldBegin, method_getTypeEncoding(class_getInstanceMethod(class, origSelector)));
        
        Method originalMethod = class_getInstanceMethod(class, origSelector);
        Method swizzledMethod = class_getInstanceMethod(class, NSSelectorFromString(@"gm_gestureRecognizerShouldBegin"));
        if (didAddMethod) {

           
            method_exchangeImplementations(originalMethod, swizzledMethod);

        }else{
            
        }
        
    }
}

BOOL gm_gestureRecognizerShouldBegin(id self  ,SEL _cmd ,id gesture) {
   
    SEL selector = NSSelectorFromString(@"gm_gestureRecognizerShouldBegin");
    ((void (*)(id,SEL,id))objc_msgSend)(self,selector,gesture);
    NSLog(@"gm_tap");
    BOOL (* func)(id,SEL) = (BOOL (*)(id,SEL)) [self methodForSelector:selector];
    return (BOOL)(func)(self, selector);
}


@end
