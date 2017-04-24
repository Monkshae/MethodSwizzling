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
#import "GMSwizzledUtility.h"

static void MySetDelegateIMP(id self, SEL _cmd, id delegate);
static void (*SetDelegateIMP)(id self, SEL _cmd, id delegate);

static void MyGMDIdSelectRowAtIndexPath(id self  ,SEL _cmd ,id tableView, id indexPath);
static void (*GMDidSelectRowAtIndexPath)(id self  ,SEL _cmd ,id tableView, id indexPath);


@implementation UITableView (Swizzling)



+ (void)load {
    
//    [UITableView swizzlingOriginalSelector:@selector(setDelegate:) swizzledSelector:@selector(gm_setDelegate:)];
    [GMSwizzledUtility swizzleIMPForClass:[self class] originalSelector:@selector(setDelegate:) swizzledIMP:(IMP)MySetDelegateIMP store:(IMP *)&SetDelegateIMP];


}


static void MySetDelegateIMP(id self, SEL _cmd, id delegate) {
    // do custom work
    SetDelegateIMP(self, _cmd, delegate);
    [GMSwizzledUtility swizzleIMPForClass:[delegate class] originalSelector:@selector(tableView:didSelectRowAtIndexPath:) swizzledIMP:(IMP)MyGMDIdSelectRowAtIndexPath store:(IMP *)&GMDidSelectRowAtIndexPath];
}


static void MyGMDIdSelectRowAtIndexPath(id self  ,SEL _cmd ,id tableView, id indexPath) {
    GMDidSelectRowAtIndexPath(self,_cmd,tableView,indexPath);
    NSLog(@"gm_didselected");
}



/**************************************标准的置换形式***********************************/

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


- (void)gm_setDelegate:(id<UITableViewDelegate>)delegate{
    [self gm_setDelegate:delegate];
    if ([[self class] isSubclassOfClass:[UITableView class]]) {
        
        Class class = [delegate class];
        SEL origSelector = @selector(tableView:didSelectRowAtIndexPath:);
    
    
        if([delegate conformsToProtocol:@protocol(UITableViewDelegate)]
           &&  [delegate respondsToSelector:origSelector]) {
            NSLog(@"conformProtocol");
        }
    
        SEL swizzlSelector = NSSelectorFromString(@"gm_didSelectRowAtIndexPath");
        /// 避免因为继承问题导致的替换方法错误引起的崩溃.如果被置换的方法在在当前类有实现就返回YES，表示动态添加了一个方法，如果返回NO表示添加失败(b比如已经存在添加过，该方法已经存在)
        BOOL didAddMethod = class_addMethod(class, swizzlSelector, (IMP)gm_didSelectRowAtIndexPath, method_getTypeEncoding(class_getInstanceMethod(class, origSelector)));
        Method originalMethod = class_getInstanceMethod(class, origSelector);
        Method swizzledMethod = class_getInstanceMethod(class, NSSelectorFromString(@"gm_didSelectRowAtIndexPath"));
        
        if (didAddMethod) {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }else{
            class_replaceMethod(class, swizzlSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
    }
}


void gm_didSelectRowAtIndexPath(id self  ,SEL _cmd ,id tableView, id indexPath) {
    
    SEL selector = NSSelectorFromString(@"gm_didSelectRowAtIndexPath");
    ((void (*)(id,SEL,id,id))objc_msgSend)(self,selector,tableView,indexPath);
    NSLog(@"gm_didselected");
    
}




@end
