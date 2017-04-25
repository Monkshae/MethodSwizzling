//
//  NSObject+KVCExceptionHandler.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/24.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "NSObject+KVCExceptionHandler.h"

@implementation NSObject (KVCExceptionHandler)

- (nullable id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
