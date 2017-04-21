//
//  UIWindow+Swizzling.m
//  MethodSwizzling
//
//  Created by licong on 16/3/2.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "UIWindow+Swizzling.h"
#import "objc/runtime.h"
#import "ViewController.h"

@implementation UIWindow (Swizzling)


//- (BOOL)gm_GestureRecognizerBegan
//{
//    return [objc_getAssociatedObject(self, _cmd) boolValue];
//}
//
//- (void)setGm_GestureRecognizerBegan:(BOOL)gm_GestureRecognizerBegan
//{
//    objc_setAssociatedObject(self, @selector(gm_GestureRecognizerBegan), @(gm_GestureRecognizerBegan), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//
//- (BOOL)gm_GestureRecognizerEnd{
//    return [objc_getAssociatedObject(self, _cmd) boolValue];
//
//}
//
//- (void)setGm_GestureRecognizerEnd:(BOOL)gm_GestureRecognizerEnd{
//    objc_setAssociatedObject(self, @selector(gm_GestureRecognizerEnd), @(gm_GestureRecognizerEnd), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//}


//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        [UIWindow swizzlingOriginalSelector:@selector(_sendGesturesForEvent:) swizzledSelector:@selector(gm_sendGesturesForEvent:)];
//        
//        [UIWindow swizzlingOriginalSelector:@selector(sendAction:to:from:forEvent:) swizzledSelector:@selector(gm_sendAction:to:from:forEvent:)];
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


//这个可以拦截所有的触摸时间包括 button  gesture  和cell
- (void)gm_sendGesturesForEvent:(UIEvent *)event{
    [self gm_sendGesturesForEvent:event];
//    NSLog(@"type = %ld",(long)event.type);
//    NSLog(@"subtype = %ld",(long)event.subtype);
    NSSet *touchs = event.allTouches;
    UITouch *touch = touchs.anyObject;
    NSLog(@"gestureRecognizers.count = %lu",touch.gestureRecognizers.count);
//    NSLog(@"gestureRecognizers = %@",touch.gestureRecognizers);
//    NSLog(@"touch.view = %@",touch.view);
    
    if (touch.phase == UITouchPhaseBegan){
        if (touch.view.accessibilityIdentifier) {
            NSLog(@"手势传递的响应链");
        }
    }
    
   
    
//    if (touch.phase == UITouchPhaseBegan) {
//        if (touch.gestureRecognizers.count >= 2) {
//            //说明这时候是手势点击
////            if (![touch.view.accessibilityIdentifier isEqualToString:@"KeyView"]) {
//                NSLog(@"手势传递的响应链");
//
////            }
//            
//
//            
//        }else{
//            //button UIView等等传递的响应链,这里要过滤掉self.view的响应
//            if (![touch.view.accessibilityIdentifier isEqualToString:@"KeyView"]) {
//                NSLog(@"UIButton UIView等等传递的响应链 %@",touch.view);
//            }
//        }
//    }
    
    
    if (touch.phase == UITouchPhaseEnded) {
        
        
        
//      NSLog(@"UIWindow event.type = %ld, description = %@",(long)event.type,event.description);
    }
    
    
}

//
//- (BOOL)gm_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
//    NSString *selectorName = NSStringFromSelector(action);
//    if (/*![selectorName isEqualToString:@"_sendAction:withEvent:"] && */[sender accessibilityIdentifier]) {
//        ViewController *controller = (ViewController *)target;
//        NSLog(@"action %s occurred.\n page name : %@, businessId : %@, aid : %@", [selectorName UTF8String], controller.pageName, controller.businessId, [sender accessibilityIdentifier]);
//    }
//    return [self gm_sendAction:action to:target from:sender forEvent:event];
//}

@end
