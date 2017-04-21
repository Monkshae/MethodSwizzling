//
//  UIView+MyViewAdditions.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/21.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "UIView+MyViewAdditions.h"
#import "objc/runtime.h"
#import "objc/message.h"

@implementation UIView (MyViewAdditions)

- (void)my_setFrame:(CGRect)frame {
    // do custom work
    [self my_setFrame:frame];
//    objc_msgSend(self, @selector(my_setFrame:), frame);
}

+ (void)load {
    [UIView swizzle:@selector(setFrame:) with:@selector(my_setFrame:)];
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


@end
