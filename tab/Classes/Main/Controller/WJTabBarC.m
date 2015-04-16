//
//  WJTabBarC.m
//  QQDrawer
//
//  Created by 王军 on 15/4/6.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJTabBarC.h"
#import "WJTestTVC.h"
#import "WJLiveTVC.h"
#import "WJNavigationC.h"
#import "WJTabBar.h"
#import "WJNavigationController.h"
#import "WJTest3VC.h"


@interface WJTabBarC () <WJTabBarDelegate>

@property (nonatomic, strong) WJNavigationC *mainTVC;
@property (nonatomic, strong) WJNavigationC *test1TVC;
@property (nonatomic, strong) WJNavigationC *test2TVC;
//@property (nonatomic, strong) WJNavigationC *test3TVC;
//@property (nonatomic, strong) WJNavigationC *test4TVC;

@end


@implementation WJTabBarC


- (WJNavigationC *)mainTVC
{
    if (!_mainTVC) {
        _mainTVC = [[WJNavigationC alloc] initWithRootViewController: [[WJMainTVC alloc] init]];
    }
    return _mainTVC;
}

- (WJNavigationC *)test1TVC
{
    if (!_test1TVC) {
        _test1TVC = [[WJNavigationC alloc] initWithRootViewController: [[WJTestTVC alloc] init]];
    }
    return _test1TVC;
}

- (WJNavigationC *)test2TVC
{
    if (!_test2TVC) {
        _test2TVC = [[WJNavigationC alloc] initWithRootViewController: [[WJTestTVC alloc] init]];
    }
    return _test2TVC;
}

//- (WJNavigationC *)test3TVC
//{
//    if (!_test3TVC) {
//        _test3TVC = [[WJNavigationC alloc] initWithRootViewController: [[WJTestTVC alloc] init]];
//    }
//    return _test3TVC;
//}
//
//- (WJNavigationC *)test4TVC
//{
//    if (!_test4TVC) {
//        _test4TVC = [[WJNavigationC alloc] initWithRootViewController: [[WJTestTVC alloc] init]];
//    }
//    return _test4TVC;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建自定义tabBar
    WJTabBar *myBar = [[WJTabBar alloc] init];
    myBar.frame = self.tabBar.frame;
    myBar.backgroundColor = [UIColor grayColor];
    myBar.delegate = self;
    //把系统的tabBar移走
    [self.tabBar removeFromSuperview];
    [self.view addSubview: myBar];
    //有几个控制器就添加几个按钮
    [myBar addTabBtnWithName: nil selName: nil  title: @"直播"];
    [myBar addTabBtnWithName: nil selName: nil  title: @"买手"];
    [myBar addTabBtnWithName: nil selName: nil  title: @"消息"];
    [myBar addTabBtnWithName: nil selName: nil  title: @"购物车"];
    [myBar addTabBtnWithName: nil selName: nil  title: @"我的"];
    
    [self addChildViewController: self.mainTVC];
    [self addChildViewController: self.test1TVC];
    [self addChildViewController: self.test2TVC];
    //[self addChildViewController: self.test3TVC];
    //[self addChildViewController: self.test4TVC];
    
    
//    WJMainTVC *mainTVC = [[WJMainTVC alloc] init];
//    [self addChildVC: mainTVC title: @"直播" image: nil selImage: nil];
//    
//    WJTestTVC *test1TVC = [[WJTestTVC alloc] init];
//    [self addChildVC: test1TVC title: @"买手" image: nil selImage: nil];
//    
//    WJTestTVC *test2TVC = [[WJTestTVC alloc] init];
//    [self addChildVC: test2TVC title: @"消息" image: nil selImage: nil];
//    
//    WJTestTVC *test3TVC = [[WJTestTVC alloc] init];
//    [self addChildVC: test3TVC title: @"购物车" image: nil selImage: nil];
//    
//    WJTestTVC *test4TVC = [[WJTestTVC alloc] init];
//    [self addChildVC: test4TVC title: @"我的" image: nil selImage: nil];
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
    //设置tabbar与navigationBar的标题文字
    childVC.title = title;
    
    childVC.tabBarItem.image = [UIImage imageNamed: image];
    //按照原来样子显示出来,不要自动渲染(默认会渲染成蓝色)
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed: selImage] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    textAttrs[NSForegroundColorAttributeName] = WJColor(109, 109, 109);
    [childVC.tabBarItem setTitleTextAttributes: textAttrs forState: UIControlStateNormal];
    textAttrs[NSForegroundColorAttributeName] = WJColor(255, 255, 255);
    [childVC.tabBarItem setTitleTextAttributes: textAttrs forState: UIControlStateSelected];
    WJNavigationC *nav = [[WJNavigationC alloc] initWithRootViewController: childVC];

    [self addChildViewController: nav];
}

- (void)tabBar:(WJTabBar *)tabBar didselectBtnFrom:(NSInteger)from to:(NSInteger)to
{
    switch (to) {
        case 0:
        {
            self.selectedIndex = to;
            break;
        }
            
        case 1:
        {
            self.selectedIndex = to;
            break;
        }
        case 2:
        {

            self.selectedIndex = to;
            break;
        }
            
        case 3:
        {
            WJTest3VC *test3VC = [[WJTest3VC alloc] init];
            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController: test3VC];
            [self presentViewController: nav animated: YES completion: nil];
            //self.selectedIndex = to;
            break;
        }
            
        case 4:
        {
            WJTest3VC *test4VC = [[WJTest3VC alloc] init];
            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController: test4VC];
            [self presentViewController: nav animated: YES completion: nil];
            //self.selectedIndex = to;
            break;
        }
        default:
            break;
    }
}


@end
