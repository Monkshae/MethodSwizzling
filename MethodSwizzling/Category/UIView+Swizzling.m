//
//  UIView+MyViewAdditions.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/21.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "UIView+Swizzling.h"
#import "objc/runtime.h"
#import "objc/message.h"
#import "GMSwizzledUtility.h"

@implementation UIView (Swizzling)


static void (*SetFrameIMP)(id self, SEL _cmd, CGRect frame);

static void MySetFrame(id self, SEL _cmd, CGRect frame) {
    // do custom work
    NSLog(@"setFrame");
    SetFrameIMP(self, _cmd, frame);
}

- (void)my_viewSetFrame:(CGRect)frame {
    // do custom work
    [self my_viewSetFrame:frame];
//    objc_msgSend(self, @selector(my_setFrame:), frame);
}

+ (void)load {
//    [UIView swizzle:@selector(setFrame:) with:@selector(my_viewSetFrame:)];
//    [GMSwizzledUtility swizzleIMPForClass:[UIView class] originalSelector:@selector(setFrame:) swizzledIMP:(IMP)MySetFrame originalIMP:(IMP *)&SetFrameIMP];
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
