//
//  UIControl+Swizzling.h
//  MethodSwizzling
//
//  Created by licong on 16/3/3.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Swizzling)
- (BOOL)gm_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
@end
