//
//  GMSwizzledUtility.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/24.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "GMSwizzledUtility.h"
#import <objc/runtime.h>

@implementation GMSwizzledUtility

+ (void)replaceIMPOfOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector onClass:(Class)class withBlock:(id)block
{
    Method originalMethod  = class_getInstanceMethod(class, originalSelector);
    if (!originalMethod) {
        return;
    }
    
    IMP implementation = imp_implementationWithBlock(block);
    class_addMethod(class, swizzledSelector, implementation, method_getTypeEncoding(originalMethod));
    Method newMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, newMethod);
}

/**
 Exchange IMPs for two Methods
 
 @param class the Class
 @param originalSelector the original selector
 @param swizzledSelector the swizzled selector
 */
+ (void)exchangeIMPForClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // Note: mapping originalSelector -> IMP of swizzledMethod
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        // Note: mapping swizzledSelector -> IMP of originalMethod
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        // Note: Class have both original and swizzled selectors
    }
    else {
        // If addMethod failed, exchange IMPs of original and swizzled methods directly
        method_exchangeImplementations(originalMethod, swizzledMethod);
        // Note: Class only has original selector
    }
}


/**
  交换IMP
 http://stackoverflow.com/questions/5339276/what-are-the-dangers-of-method-swizzling-in-objective-c
 */
+ (BOOL)swizzleIMPForClass:(Class)class originalSelector:(SEL) originalSelector swizzledIMP:(IMP)swizzledIMP store:(IMPPointer)store{
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, originalSelector);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        //imp原系统方法实现的IMP
        imp = class_replaceMethod(class, originalSelector, swizzledIMP, type);
        //为NULL表示执行的是class_addMethod，不为空执行的是method_setImplementation
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    //每次置换完成，我们保存原系统方法的实现
    //typedef IMP *IMPPointer;这句话看似很多余，其实是因为imp本身是一个无返回值的指针，所以为了保存原系统的imp不能通过直接赋值，需要再嵌套一层指针
    if (imp && store) { *store = imp;}
    return (imp != NULL);
}


+ (SEL)swizzledSelectorForSelector:(SEL)selector
{
    return NSSelectorFromString([NSString stringWithFormat:@"_swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}


@end
