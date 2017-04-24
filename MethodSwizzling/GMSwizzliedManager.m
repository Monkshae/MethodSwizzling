//
//  GMSwizzliedManager.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/24.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "GMSwizzliedManager.h"


@implementation GMSwizzliedManager

+ (instancetype)shareManager {
    static GMSwizzliedManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[[self class] alloc] init];
    });
    return shareManager;
}


+ (void)load{
    
}

@end

