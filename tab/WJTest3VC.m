//
//  WJTest3VC.m
//  tab
//
//  Created by 王军 on 15/4/7.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJTest3VC.h"

@interface WJTest3VC ()

@end

@implementation WJTest3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"本窗口是下面弹出来滴";
    lab.frame = CGRectMake(50, 100, 180, 30);
    [self.view addSubview: lab];
    
    //设置左上角的关闭按钮(控制器会成为导航控制器的根控制器)
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"关闭" style: UIBarButtonItemStylePlain target: self action: @selector(close)];
}

- (void)close
{
    //退出控制器
    [self dismissViewControllerAnimated: YES completion: nil];
}

//- (void)dealloc
//{
//    NSLog(@"本测试窗口销毁嘹");
//}

@end
