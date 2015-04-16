//
//  WJBannerCell.m
//  tab
//
//  Created by 王军 on 15/4/11.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJBannerCell.h"
#import "UIImageView+WebCache.h"
#import "WJLiveM.h"


@interface WJBannerCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageV;

@end


@implementation WJBannerCell


- (void)setBannerM:(WJBannerM *)bannerM
{
    _bannerM = bannerM;
    
    NSString *urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", bannerM.imgs[0]];
    //NSLog(@"%@", urlStr);
    [self.imageV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
}

@end
