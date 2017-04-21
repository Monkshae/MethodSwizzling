//
//  UITableView+Swizzling.m
//  MethodSwizzling
//
//  Created by licong on 16/3/3.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "UITableView+Swizzling.h"
#import "objc/runtime.h"
#import "objc/message.h"

@implementation UITableView (Swizzling)



+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [UITableView swizzlingOriginalSelector:@selector(setDelegate:) swizzledSelector:@selector(gm_setDelegate:)];
        
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


- (void)gm_setDelegate:(id<UIGestureRecognizerDelegate>)delegate{
    [self gm_setDelegate:delegate];
    if ([[self class] isSubclassOfClass:[UITableView class]]) {
        
        
        Class class = [delegate class];
        SEL  origSelector = @selector(tableView:didSelectRowAtIndexPath:);
        
        BOOL didAddMethod = class_addMethod(class, NSSelectorFromString(@"gm_didSelectRowAtIndexPath"), (IMP)gm_didSelectRowAtIndexPath, method_getTypeEncoding(class_getInstanceMethod(class, origSelector)));
        
        if (didAddMethod) {
            
            Method originalMethod = class_getInstanceMethod(class, origSelector);
            Method swizzledMethod = class_getInstanceMethod(class, NSSelectorFromString(@"gm_didSelectRowAtIndexPath"));
            method_exchangeImplementations(originalMethod, swizzledMethod);
            
        }else{
        }
    }
}

void gm_didSelectRowAtIndexPath(id self  ,SEL _cmd ,id tableView, id indexPath) {
    
    SEL selector = NSSelectorFromString(@"gm_didSelectRowAtIndexPath");
    ((void (*)(id,SEL,id,id))objc_msgSend)(self,selector,tableView,indexPath);
    NSLog(@"gm_didselected");
    
}




@end
