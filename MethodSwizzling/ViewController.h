//
//  ViewController.h
//  MethodSwizzling
//
//  Created by licong on 16/2/24.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString * pageName;
@property (nonatomic, strong) NSString * businessId;

@end

