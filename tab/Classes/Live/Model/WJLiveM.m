//
//  WJBannerM.m
//  tab
//
//  Created by 王军 on 15/4/11.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJLiveM.h"

#pragma mark - 横幅模型

@implementation WJBannerM

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.nID = [dict[@"id"] integerValue];
        self.valid = dict[@"valid"];
        self.imgs = dict[@"imgs"];
        self.title = dict[@"title"];
        self.update_time = [dict[@"update_time"] integerValue];
        self.order = [dict[@"order"] integerValue];
        self.model_id = dict[@"model_id"];
        self.create_time = [dict[@"create_time"] integerValue];
        self.type = dict[@"type"];
        self.channel = [dict[@"channel"] integerValue];
        self.url = dict[@"url"];
    }
    return self;
}

+ (instancetype)bannerMWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

+ (NSArray *)bannerMAryWithDictAry:(NSArray *)dictAry
{
    
    NSMutableArray *mutableAry = [NSMutableArray array];
    for (NSDictionary *dict in dictAry) {
        WJBannerM *bannerM = [WJBannerM bannerMWithDict: dict];
        [mutableAry addObject: bannerM];
    }
    return mutableAry;
}

@end


//-----------------------------------------------------------------------------


#pragma mark - 8个按钮模型

@implementation WJCategoryM

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.category = dict[@"category"];
        self.categoryIconName = dict[@"categoryIconName"];
        self.categoryId = [dict[@"categoryId"] integerValue];
        self.img = dict[@"img"];
        self.url = dict[@"url"];
        
    }
    return self;
}

+ (instancetype)categoryMWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

+ (NSArray *)categoryMAryWithDictAry:(NSArray *)dictAry
{
    
    NSMutableArray *mutableAry = [NSMutableArray array];
    for (NSDictionary *dict in dictAry) {
        WJCategoryM *categoryM = [WJCategoryM categoryMWithDict: dict];
        [mutableAry addObject: categoryM];
    }
    return mutableAry;
}

@end


//-----------------------------------------------------------------------------


#pragma mark - 直播模型中用到的

@implementation WJBuyerLev

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.num = [dict[@"num"] intValue];
        self.type = [dict[@"type"] intValue];
        
    }
    return self;
}

+ (instancetype)buyerLevMWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

@end

//-----------------------------------------------------------

//直播模型中用到的
@implementation WJShareTitle

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {

        self.qzone = dict[@"qzone"];
        self.wechat = dict[@"wechat"];
        self.wechat_moments = dict[@"wechat_moments"];
        self.weibo = dict[@"weibo"];
        
    }
    return self;
}

+ (instancetype)shareTitleMWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

@end


//---------------------------------------------------------------


#pragma mark - 正在直播模型

@implementation WJLiveingM

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.is_open = [dict[@"is_open"] integerValue];
        self.left_time = [dict[@"left_time"] integerValue];
        self.type = dict[@"type"];
        self.brands_label = dict[@"brands_label"];
        self.city = dict[@"city"];
        self.buyer_country = dict[@"buyer_country"];
        self.nId = [dict[@"id"] integerValue];
        self.brands = dict[@"brands"];
        self.country_flag = dict[@"country_flag"];
        self.buyer_level = [WJBuyerLev buyerLevMWithDict: dict[@"buyer_level"]];
        self.is_close = [dict[@"is_close"] integerValue];
        self.name = dict[@"name"];
        self.share_title = [WJShareTitle shareTitleMWithDict: dict[@"share_title"]];
        self.buyer_id = [dict[@"buyer_id"] integerValue];
        self.imgs = dict[@"imgs"];
        self.list_show = [dict[@"list_show"] integerValue];
        self.buyer_name = dict[@"buyer_name"];
        self.country = dict[@"country"];
        self.buyer_head = dict[@"buyer_head"];
        self.start = [dict[@"start"] boolValue];
        self.end_time = [dict[@"end_time"] integerValue];
        self.address = dict[@"address"];
        self.user_num = [dict[@"user_num"] integerValue];
        self.start_time = [dict[@"start_time"] integerValue];
        self.buyer_country_flag = dict[@"buyer_country_flag"];
        self.is_flow = [dict[@"is_flow"] integerValue];
        self.buyer_easemob_username = dict[@"buyer_easemob_username"];
        
    }
    return self;
}

+ (instancetype)liveingMWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

+ (NSArray *)liveingMAryWithDictAry:(NSArray *)dictAry
{
    NSMutableArray *mutableAry = [NSMutableArray array];
    for (NSDictionary *dict in dictAry) {
        WJLiveingM *liveingM = [WJLiveingM liveingMWithDict: dict];
        [mutableAry addObject: liveingM];
    }
    return mutableAry;
}

@end


//-----------------------------------------------------------------------------

#pragma mark - 直播预告模型

@implementation WJNoticeLiveM

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.remindered = (BOOL)dict[@"remindered"];
        self.liveingM = [WJLiveingM liveingMWithDict: dict];
        
    }
    return self;
}

+ (instancetype)noticeliveMWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

+ (NSArray *)noticeliveMAryWithDictAry:(NSArray *)dictAry
{
    NSMutableArray *mutableAry = [NSMutableArray array];
    for (NSDictionary *dict in dictAry) {
        WJNoticeLiveM *noticeliveM = [WJNoticeLiveM noticeliveMWithDict: dict];
        [mutableAry addObject: noticeliveM];
    }
    return mutableAry;
}

@end






















