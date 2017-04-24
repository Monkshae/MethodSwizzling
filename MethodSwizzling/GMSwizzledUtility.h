//
//  GMSwizzledUtility.h
//  MethodSwizzling
//
//  Created by licong on 2017/4/24.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef IMP *IMPPointer;

@interface GMSwizzledUtility : NSObject

+ (void)replaceIMPOfOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector onClass:(Class)class withBlock:(id)block;

+ (void)exchangeIMPForClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
+ (BOOL)swizzleIMPForClass:(Class)class originalSelector:(SEL) originalSelector swizzledIMP:(IMP)swizzledIMP originalIMP:(IMPPointer)originalIMP;
+ (SEL)swizzledSelectorForSelector:(SEL)selector;

@end
