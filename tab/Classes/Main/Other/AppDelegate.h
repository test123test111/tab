//
//  AppDelegate.h
//  tab
//
//  Created by 王军 on 15/4/7.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)restoreRootViewController:(UIViewController *)rootViewController;

+ (AppDelegate *)shareDelegate;

@end

