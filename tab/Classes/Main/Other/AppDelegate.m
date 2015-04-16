//
//  AppDelegate.m
//  tab
//
//  Created by 王军 on 15/4/7.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "AppDelegate.h"
#import "WJTabBarC.h"

#import "WJWelcomeVC.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    //self.window.rootViewController = [[WJTabBarC alloc] init];
    
    self.window.rootViewController = [[WJWelcomeVC alloc] init];
    
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration: 2.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

+ (AppDelegate *)shareDelegate
{
    return [UIApplication sharedApplication].delegate;
}

@end
