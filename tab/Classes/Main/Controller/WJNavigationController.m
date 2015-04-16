//
//  WJNavigationController.m
//  29-彩票
//
//  Created by 王军 on 15/3/10.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJNavigationController.h"

@interface WJNavigationController ()

@end

@implementation WJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//系统在第一次使用这个类的时候调用(1个类只使用一次)
+ (void)initialize
{
    //设置导航栏主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置背景图片
    //[navBar setBackgroundImage: [UIImage imageNamed: @"NavBar64"] forBarMetrics: UIBarMetricsDefault];
    //设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize: 25];
    [navBar setTitleTextAttributes: attrs];
    
    //导航返回箭头的颜色
    navBar.tintColor = [UIColor whiteColor];
    
    //设置BarButtonItem主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize: 14];
    [item setTitleTextAttributes: itemAttrs forState: UIControlStateNormal];
}

//重写父类的push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //这样就能隐藏下面的tabBar栏
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController: viewController animated: animated];
}
@end
