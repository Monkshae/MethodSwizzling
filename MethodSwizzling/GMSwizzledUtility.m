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
    return NSSelectorFromString([NSString stringWithFormat:@"swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}


@end
