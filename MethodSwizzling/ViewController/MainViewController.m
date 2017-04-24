//
//  MainViewController.m
//  MethodSwizzling
//
//  Created by licong on 2017/4/21.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

#import "MainViewController.h"
#import "TableSwizzlingController.h"
#import "FrameController.h"
#import "GestureRecognizerController.h"
#import "ButtonSwizzlingController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray * dataArray;
@end

@implementation MainViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]init];
    tableView.rowHeight = 44;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:tableView];
    
    _dataArray = @[@"TableSwizzling",@"ButtonSwizzling",@"ViewSwizzling",@"gestureRecognizerSwizzling"];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelected");
    UIViewController * controler = nil;
    switch (indexPath.row) {
        case 0:
            controler = [[TableSwizzlingController alloc]init];
            break;
        case 1:
            controler = [[ButtonSwizzlingController alloc]init];
            break;
        case 2:
            controler = [[FrameController alloc]init];
            break;
        case 3:
            controler = [[GestureRecognizerController alloc]init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:controler animated:YES];
}


@end
