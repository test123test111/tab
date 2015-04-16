//
//  WJBannerV.h
//  tab
//
//  Created by 王军 on 15/4/11.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJBannerV : UIView

//横幅列表模型
@property (nonatomic, strong) NSArray *bannerMAry;

//8个按钮模型
@property (nonatomic, strong) NSArray *categoryMAry;

+ (instancetype)bannerView;

@end
