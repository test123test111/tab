//
//  WJTabBar.m
//  29-彩票
//
//  Created by 王军 on 15/3/10.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJTabBar.h"
#import "WJTabBarBtn.h"


@interface WJTabBar ()

@property (nonatomic, weak) WJTabBarBtn *selectedBtn;

@end


@implementation WJTabBar

//重写这函数,自己的frame确定后再设置子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / count;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i < count; i++) {
        WJTabBarBtn *btn = self.subviews[i];
        //设置tag
        btn.tag = i;
        //设置Frame
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

/**
 *  增加一个内部按钮
 *
 *  name    普通状态的图片名字
 *  selName 选中时的图片名字
 */
- (void)addTabBtnWithName:(NSString *)name selName:(NSString *)selName title:(NSString *)title
{
    //创建按钮
    WJTabBarBtn *btn = [WJTabBarBtn buttonWithType: UIButtonTypeCustom];
    
    //设置图片
    if (name) {
        [btn setBackgroundImage: [UIImage imageNamed: name] forState: UIControlStateNormal];
    }
    if (selName) {
        [btn setBackgroundImage: [UIImage imageNamed: selName] forState: UIControlStateSelected];
    }
    
    [btn setTitle: title forState: UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize: 12];
    
    [btn setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [btn setTitleColor: [UIColor greenColor] forState: UIControlStateSelected];

    [self addSubview: btn];
    
    //监听 手指一按下就触发的状态
    [btn addTarget: self action: @selector(btnClick:) forControlEvents: UIControlEventTouchDown];
    
    //默认选中第一个按钮,也就是调用第一个按钮的点击事件
    if (1 == self.subviews.count) {
        [self btnClick: btn];
    }
}

//监听按钮点击
- (void)btnClick:(WJTabBarBtn *)btn
{
    //NSLog(@"%u", btn.tag);
    //通知代理 切换控制器
    if ([self.delegate respondsToSelector: @selector(tabBar:didselectBtnFrom:to:)]) {
        [self.delegate tabBar: self didselectBtnFrom: self.selectedBtn.tag to: btn.tag];
    }
    
    //当前选中的按钮取消选中
    self.selectedBtn.selected = NO;
    
    //新点击的按钮为选中
    btn.selected = TRUE;
    
    //新点的按钮成为当前选中的按钮
    self.selectedBtn = btn;
}

@end
