//
//  FourViewController.m
//  MethodSwizzling
//
//  Created by licong on 16/3/1.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

#import "TableSwizzlingController.h"
#import "objc/runtime.h"
#import "GMTableView.h"
@interface TableSwizzlingController  ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TableSwizzlingController

- (void)viewDidLoad{
    [super viewDidLoad];
    UITableView *tableView = [[GMTableView alloc]init];
    tableView.rowHeight = 44;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:tableView];
    
    self.attributes = @{@"tableKey" : @"tableValue"};
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = @"测试";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"original function  didSelected!");
}

@end
