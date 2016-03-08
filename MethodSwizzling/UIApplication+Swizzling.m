//
//  UIApplication+Swizzling.m
//  MethodSwizzling
//
//  Created by licong on 16/3/1.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "UIApplication+Swizzling.h"
#import "objc/runtime.h"
#import "ViewController.h"

@implementation UIApplication (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [UIApplication swizzlingOriginalSelector:@selector(sendAction:to:from:forEvent:) swizzledSelector:@selector(gm_sendAction:to:from:forEvent:)];
//        [UIApplication swizzlingOriginalSelector:@selector(sendEvent:) swizzledSelector:@selector(gm_sendEvent:)];

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




- (BOOL)gm_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    NSString *selectorName = NSStringFromSelector(action);
    if (/*![selectorName isEqualToString:@"_sendAction:withEvent:"] && */[sender accessibilityIdentifier]) {
        ViewController *controller = (ViewController *)target;
        NSLog(@"action %s occurred.\n page name : %@, businessId : %@, aid : %@", [selectorName UTF8String], controller.pageName, controller.businessId, [sender accessibilityIdentifier]);
    }
    return [self gm_sendAction:action to:target from:sender forEvent:event];
}

//- (void)gm_sendEvent:(UIEvent *)event{
//    
//    NSSet *touchs = event.allTouches;
//    UITouch *touch = touchs.anyObject;
//    if (touch.phase == UITouchPhaseEnded) {
//        NSLog(@"UIWindow event.type = %ld, description = %@",(long)event.type,event.description);
//    }
//    
//}
@end
