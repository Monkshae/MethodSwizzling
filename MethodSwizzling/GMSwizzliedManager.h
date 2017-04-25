//
//  GMSwizzliedManager.h
//  MethodSwizzling
//
//  Created by licong on 2017/4/24.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMSwizzliedManager : NSObject

+ (instancetype)shareManager;

- (UIViewController *)getCurrentController;

@end
