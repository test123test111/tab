//
//  WJBannerM.h
//  tab
//
//  Created by 王军 on 15/4/11.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import <Foundation/Foundation.h>


//横幅模型
@interface WJBannerM : NSObject

/** id */
@property (nonatomic, assign) NSInteger nID;

/** valid */
@property (nonatomic, copy) NSString *valid;

/** imgs 	字符串数组 存放图片地址*/
@property (nonatomic, strong) NSArray *imgs;

/** title */
@property (nonatomic, copy) NSString *title;

/** update_time */
@property (nonatomic, assign) NSInteger update_time;

/** order */
@property (nonatomic, assign) NSInteger order;

//imgs6	Array
//[0]	String	/public_upload/9/a/1/9a159ca46b46125fa0d604e732bf8b2f.jpg

/** model_id */
@property (nonatomic, copy) NSString *model_id;

/** create_time */
@property (nonatomic, assign) NSInteger create_time;

/** type */
@property (nonatomic, copy) NSString *type;

/** channel */
@property (nonatomic, assign) NSInteger channel;

/** url */
@property (nonatomic, copy) NSString *url;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)bannerMWithDict:(NSDictionary *)dict;

+ (NSArray *)bannerMAryWithDictAry:(NSArray *)dictAry;

@end


//-----------------------------------------------------------------------------


//8个按钮模型
@interface WJCategoryM : NSObject

/** category */
@property (nonatomic, copy) NSString *category;

/** categoryIconName */
@property (nonatomic, copy) NSString *categoryIconName;

/** categoryId */
@property (nonatomic, assign) NSInteger categoryId;

/** img */
@property (nonatomic, copy) NSString *img;

/** url */
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)categoryMWithDict:(NSDictionary *)dict;

+ (NSArray *)categoryMAryWithDictAry:(NSArray *)dictAry;

@end


//-----------------------------------------------------------------------------


//直播模型中用到的
@interface WJBuyerLev : NSObject

/** num */
@property (nonatomic, assign) NSInteger num;

/** type */
@property (nonatomic, assign) NSInteger type;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)buyerLevMWithDict:(NSDictionary *)dict;

@end


//---------------------------------------------------


//直播模型中用到
@interface WJShareTitle : NSObject

/** qzone */
@property (nonatomic, copy) NSString *qzone;

/** wechat */
@property (nonatomic, copy) NSString *wechat;

/** wechat_moments */
@property (nonatomic, copy) NSString *wechat_moments;

/** weibo */
@property (nonatomic, copy) NSString *weibo;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)shareTitleMWithDict:(NSDictionary *)dict;

@end


//------------------------------------------------------


//正在直播模型
@interface WJLiveingM : NSObject

/** is_open */
@property (nonatomic, assign) NSInteger is_open;

/** left_time */
@property (nonatomic, assign) NSInteger left_time;

/** type */
@property (nonatomic, copy) NSString *type;

/** brands_label */
@property (nonatomic, copy) NSString *brands_label;

/** city */
@property (nonatomic, copy) NSString *city;

/** buyer_country */
@property (nonatomic, copy) NSString *buyer_country;

/** id */
@property (nonatomic, assign) NSInteger nId;

/** brands 	字符串数组 存放图片地址*/
@property (nonatomic, strong) NSArray *brands;

/** country_flag */
@property (nonatomic, copy) NSString *country_flag;

/** 模型在上面 */
@property (nonatomic, strong) WJBuyerLev *buyer_level;

/** is_close */
@property (nonatomic, assign) NSInteger is_close;

/** name */
@property (nonatomic, copy) NSString *name;

/** 模型在上面 */
@property (nonatomic, strong) WJShareTitle *share_title;

/** buyer_id */
@property (nonatomic, assign) NSInteger buyer_id;

/** imgs 	字符串数组 最大的背景图*/
@property (nonatomic, strong) NSArray *imgs;

/** list_show */
@property (nonatomic, assign) NSInteger list_show;

/** buyer_name */
@property (nonatomic, copy) NSString *buyer_name;

/** intro */
@property (nonatomic, copy) NSString *intro;

/** country */
@property (nonatomic, copy) NSString *country;

/** buyer_head */
@property (nonatomic, copy) NSString *buyer_head;

/** start */
@property (nonatomic, assign) BOOL start;

/** end_time */
@property (nonatomic, assign) NSInteger end_time;

/** address */
@property (nonatomic, copy) NSString *address;

/** user_num */
@property (nonatomic, assign) NSInteger user_num;

/** start_time */
@property (nonatomic, assign) NSInteger start_time;

/** buyer_country_flag */
@property (nonatomic, copy) NSString *buyer_country_flag;

/** is_flow */
@property (nonatomic, assign) NSInteger is_flow;

/** buyer_easemob_username */
@property (nonatomic, copy) NSString *buyer_easemob_username;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)liveingMWithDict:(NSDictionary *)dict;

+ (NSArray *)liveingMAryWithDictAry:(NSArray *)dictAry;

@end


//-----------------------------------------------------------------------------


//直播预告模型
@interface WJNoticeLiveM : NSObject

/** remindered */
@property (nonatomic, assign) BOOL remindered;

/** 正在直播模型 */
@property (nonatomic, strong) WJLiveingM *liveingM;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)noticeliveMWithDict:(NSDictionary *)dict;

+ (NSArray *)noticeliveMAryWithDictAry:(NSArray *)dictAry;

@end





















