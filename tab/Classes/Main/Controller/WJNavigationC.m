//
//  WJNavigationC.m
//  QQDrawer
//
//  Created by 王军 on 15/4/6.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJNavigationC.h"

@implementation WJNavigationC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏背景色
    [[UINavigationBar appearance] setBarTintColor: [UIColor redColor]];
    
    //统一导航栏背景图片 必须是64高,不然状态栏20的高度没颜色
    //[self.navigationBar setBackgroundImage: [UIImage imageNamed:@"header_bg"] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header_bg"] forBarMetrics:UIBarMetricsDefault];
}

//状态栏为亮白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
