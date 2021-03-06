//
//  UIControl+Swizzling.m
//  MethodSwizzling
//
//  Created by licong on 16/3/3.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "UIControl+Swizzling.h"
#import "ButtonSwizzlingController.h"
#import "objc/runtime.h"

@implementation UIControl (Swizzling)


- (void)my_controlSetFrame:(CGRect)frame {
    // do custom work
    [self my_controlSetFrame:frame];
}

+ (void)load {
//    [UIControl swizzlingOriginalSelector:@selector(sendAction:to:forEvent:) swizzledSelector:@selector(gm_sendAction:to:forEvent:)];
//    [UIControl swizzle:@selector(setFrame:) with:@selector(my_controlSetFrame:)];
}


+ (void)swizzle:(SEL)origSelector with:(SEL)swizzledSelector{
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




- (BOOL)gm_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSString *selectorName = NSStringFromSelector(action);
    ButtonSwizzlingController *controller = (ButtonSwizzlingController *)target;
    NSLog(@"action %s occurred.\n page name : %@, businessId : %@", [selectorName UTF8String], controller.pageName, controller.businessId);
    return [self gm_sendAction:action to:target  forEvent:event];
}



@end
