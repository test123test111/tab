//
//  WJTabBar.h
//  29-彩票
//
//  Created by 王军 on 15/3/10.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJTabBar;

@protocol WJTabBarDelegate <NSObject>
@optional

- (void)tabBar:(WJTabBar *)tabBar didselectBtnFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface WJTabBar : UIView

@property (nonatomic, weak) id<WJTabBarDelegate> delegate;

/**
 *  增加一个内部按钮
 *
 *  name    普通状态的图片名字
 *  selName 选中时的图片名字
 */
- (void)addTabBtnWithName:(NSString *)name selName:(NSString *)selName title:(NSString *)title;

@end
