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

+ (BOOL)swizzleIMPForClass:(Class)class originalSelector:(SEL) originalSelector swizzledIMP:(IMP)swizzledIMP store:(IMPPointer)store;
+ (SEL)swizzledSelectorForSelector:(SEL)selector;

@end
