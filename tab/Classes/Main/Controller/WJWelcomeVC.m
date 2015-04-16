//
//  WJWelcomeVC.m
//  tab
//
//  Created by 王军 on 15/4/15.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJWelcomeVC.h"
#import "WJTabBarC.h"
#import "RequestData.h"
#import "AppDelegate.h"

@interface WJWelcomeVC ()

@property (nonatomic, weak) UIImageView *IV;

@property (nonatomic, weak) WJTabBarC *tabBarC;

@end

@implementation WJWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *ig = [UIImage imageNamed:@"gg"];
    UIImageView *IV = [[UIImageView alloc] initWithImage:ig];
    IV.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview: IV];
    self.IV = IV;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadLiveAllData];
}

- (void)loadLiveAllData
{
    RequestData *rd = [RequestData sharedRequestData];
    
    [rd getLiveData:^(id responseData) {
        
        //GET数据后会回调这里
        
        NSLog(@"getLiveData成功!");
        
        NSDictionary *rstDict = responseData[@"rst"];
        WJTabBarC *tabBac = [[WJTabBarC alloc] init];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ncLoadLiveAllData" object:rstDict];
        [[AppDelegate shareDelegate] restoreRootViewController: tabBac];
    }];
}

- (void)dealloc
{
    NSLog(@"WJWelcomeVC---木有了.");
}

@end





