//
//  WJLiveingTVCell.m
//  tab
//
//  Created by 王军 on 15/4/13.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJLiveingTVCell.h"
#import "WJLiveM.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"


@interface WJLiveingTVCell ()

@property (nonatomic, strong) WJLiveingM *liveingM;

@property (nonatomic, strong) WJNoticeLiveM *noticeLiveM;

@property (nonatomic, assign) CGFloat screenWidth;

/** 直播主view */
@property (nonatomic, weak) UIView *liveingV;

/** imgs 最大背景图*/
@property (nonatomic, weak) UIImageView *imgsIV;

/** name 标题 */
@property (nonatomic, weak) UILabel *nameLab;

/** brands_label 子标题 */
@property (nonatomic, weak) UILabel *brandsLab;

/** buyer_head 买家头像 */
@property (nonatomic, weak) UIImageView *buyerHeadIV;

/** buyer_name 买家名字 */
@property (nonatomic, weak) UILabel *buyerNameLab;

/** buyer_level 买家等级 */
@property (nonatomic, weak) UIView *buyerLevV;
@property (nonatomic, strong) NSArray *buyerLevIVs;

/** buyer_country_flag 国旗 */
@property (nonatomic, weak) UIImageView *buyerCountryFlagIV;

/** buyer_country 国名 */
@property (nonatomic, weak) UILabel *buyerCountryLab;

/** 时间图标 */
@property (nonatomic, weak) UIImageView *timeIV;

/** left_time 倒计时 */
@property (nonatomic, weak) UILabel *leftTimeLab;

/** 最后盖上一张有圆角的 */
@property (nonatomic, weak) UIImageView *radiusIV;



/** 预告主view */
@property (nonatomic, weak) UIView *noticeMainV;

/** imgs */
@property (nonatomic, weak) UIImageView *noticeImgsIV;

/** buyer_head */
@property (nonatomic, weak) UIImageView *noticeBuyerHeadIV;

/** buyer_country_flag 国旗 */
@property (nonatomic, weak) UIImageView *noticeBuyerCountryFlagIV;

/** buyer_name 买家名字 */
@property (nonatomic, weak) UILabel *noticeBuyerNameLab;

/** name 标题 */
@property (nonatomic, weak) UILabel *noticeNameLab;

/** left_time 倒计时 */
@property (nonatomic, weak) UILabel *noticeLeftTimeLab;

/** 最后盖上一张有圆角的 */
@property (nonatomic, weak) UIImageView *noticeRadiusIV;

@property (nonatomic, weak) UIButton *noticeLeftBtn;

@property (nonatomic, weak) UIButton *noticeRightBtn;

@end



@implementation WJLiveingTVCell

- (void)setShowM:(Class)ShowM
{
    if ([ShowM isKindOfClass: [WJLiveingM class]]) { //直播模型
        self.noticeMainV.hidden = YES;
        self.liveingV.hidden = NO;
        self.liveingM = (WJLiveingM *)ShowM;
    } else { //预告模型
        self.noticeMainV.hidden = NO;
        self.liveingV.hidden = YES;
        self.noticeLiveM = (WJNoticeLiveM *)ShowM;
    }
}

#pragma mark - 设置直播模型

- (void)setLiveingM:(WJLiveingM *)liveingM
{
    _liveingM = liveingM;
    
    NSString *urlStr = nil;
    // imgs 最大的背景图
    if (liveingM.imgs.count) {
        urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", liveingM.imgs[0]];
        [self.imgsIV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
    }
    
    // name
    self.nameLab.text = liveingM.name;
    
    // brands_label
    self.brandsLab.text = liveingM.brands_label;
    
    // buyer_head
    urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", liveingM.buyer_head];
    [self.buyerHeadIV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
    //告诉layer将位于它之下的都盖住
    self.buyerHeadIV.layer.masksToBounds = YES;
    //设置半径是控件宽度的一半
    self.buyerHeadIV.layer.cornerRadius = 22.5;
    
    //buyer_name
    self.buyerNameLab.text = liveingM.buyer_name;
    //尺寸自适应
    [self.buyerNameLab sizeToFit];
    
    // buyer_level
    self.buyerLevV.x = CGRectGetMaxX(self.buyerNameLab.frame);
    for (int i = 0; i < 5; i++) {
        UIImageView *iv =  (UIImageView *)self.buyerLevIVs[i];
        if (i < liveingM.buyer_level.num) {
            iv.hidden = NO;
        } else {
            iv.hidden = YES;
        }
    }
    
    // country_flag
    urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", liveingM.buyer_country_flag];
    [self.buyerCountryFlagIV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
    //告诉layer将位于它之下的都盖住
    self.buyerCountryFlagIV.layer.masksToBounds = YES;
    //设置半径是控件宽度的一半
    self.buyerCountryFlagIV.layer.cornerRadius = 6;
    
    // buyer_country_flag
    urlStr = [NSString stringWithFormat: @"%@-%ld人观看", liveingM.buyer_country, liveingM.user_num];
    self.buyerCountryLab.text = urlStr;
    
    // left_time
    NSInteger leftTime = liveingM.left_time;
    NSInteger hour = leftTime / (60 * 60);
    NSInteger temp = leftTime % (60 * 60);
    NSInteger min = temp / 60;
    temp = temp % 60;
    self.leftTimeLab.text =[NSString stringWithFormat: @"还剩%02ld:%02ld:%02ld", hour, min, temp];
}

#pragma mark - 设置预告模型

- (void)setNoticeLiveM:(WJNoticeLiveM *)noticeLiveM
{
    _noticeLiveM = noticeLiveM;
    
    WJLiveingM *liveingM = noticeLiveM.liveingM;
    
    NSString *urlStr = nil;
    // imgs 最大的背景图
    if (liveingM.imgs.count) {
        urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", liveingM.imgs[0]];
        [self.noticeImgsIV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
    }

    // buyer_head
    urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", liveingM.buyer_head];
    [self.noticeBuyerHeadIV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
    //告诉layer将位于它之下的都盖住
    self.noticeBuyerHeadIV.layer.masksToBounds = YES;
    //设置半径是控件宽度的一半
    self.noticeBuyerHeadIV.layer.cornerRadius = 22.5;
    
    // country_flag
    urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", liveingM.buyer_country_flag];
    [self.noticeBuyerCountryFlagIV sd_setImageWithURL: [NSURL URLWithString: urlStr]];
    //告诉layer将位于它之下的都盖住
    self.noticeBuyerCountryFlagIV.layer.masksToBounds = YES;
    //设置半径是控件宽度的一半
    self.noticeBuyerCountryFlagIV.layer.cornerRadius = 6;
    
    //buyer_name
    self.noticeBuyerNameLab.text = liveingM.buyer_name;
    //尺寸自适应
    [self.noticeBuyerNameLab sizeToFit];
    
    // name
    self.noticeNameLab.text = liveingM.name;
    
    // left_time
    NSInteger leftTime = liveingM.left_time;
    NSInteger hour = leftTime / (60 * 60);
    NSInteger temp = leftTime % (60 * 60);
    NSInteger min = temp / 60;
    temp = temp % 60;
    self.noticeNameLab.text =[NSString stringWithFormat: @"距离开始还有 %02ld:%02ld:%02ld", hour, min, temp];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 创建正在直播相关的view
        [self setupLiveingView];
        
        // 创建预告相关的view
        [self setupNoticeLiveView];

    }
    return self;
}

- (void)setupLiveingView
{
    //直播主view 所有控件都加到这个来.
    UIView *liveingV = [[UIView alloc] init];
    liveingV.frame = CGRectMake(0, 0, self.screenWidth, WJLiveingCellH);
    [self.contentView addSubview: liveingV];
    self.liveingV = liveingV;
    
    //imgs 最大的背景图
    UIImageView *imgsIV = [[UIImageView alloc] init];
    imgsIV.frame = CGRectMake(5, 10, self.screenWidth - 10, 175);
    [liveingV addSubview: imgsIV];
    self.imgsIV = imgsIV;
    
    //imgs 在图片上盖一张透明度的图片
    UIImageView *IV = [[UIImageView alloc] init];
    IV.frame = CGRectMake(0, 0, self.screenWidth - 10, 175);
    IV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [imgsIV addSubview: IV];
    
    // name
    UILabel *namelab = [[UILabel alloc] init];
    namelab.frame = CGRectMake(18, 20, 300, 19);
    namelab.font = [UIFont systemFontOfSize: 15];
    namelab.textColor = [UIColor whiteColor];
    [liveingV addSubview: namelab];
    self.nameLab = namelab;
    
    // brands_label
    UILabel *brandsLab = [[UILabel alloc] init];
    brandsLab.frame = CGRectMake(18, 42, 234, 11);
    brandsLab.font = [UIFont systemFontOfSize: 9];
    brandsLab.textColor = [UIColor whiteColor];
    [liveingV addSubview: brandsLab];
    self.brandsLab = brandsLab;
    
    // buyer_head
    UIImageView *buyerHeadIV = [[UIImageView alloc] init];
    buyerHeadIV.frame = CGRectMake(12, 178, 45, 45);
    [liveingV addSubview: buyerHeadIV];
    self.buyerHeadIV = buyerHeadIV;
    
    //buyer_name
    UILabel *buyerNameLab = [[UILabel alloc] init];
    buyerNameLab.frame = CGRectMake(64, 192, 48, 12);
    buyerNameLab.font = [UIFont systemFontOfSize: 12];
    buyerNameLab.textColor = [UIColor blackColor];
    [liveingV addSubview: buyerNameLab];
    self.buyerNameLab = buyerNameLab;
    
    // buyer_level
    UIView *buyerLevV = [[UIView alloc] init];
    buyerLevV.frame = CGRectMake(117, 194, 65, 10);
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIImageView *buyerLevIV = [[UIImageView alloc] init];
        buyerLevIV.frame = CGRectMake(i * 12, 0, 12, 10);
        buyerLevIV.image = [UIImage imageNamed:@"lev"];
        buyerLevIV.hidden = YES;
        [buyerLevV addSubview: buyerLevIV];
        [ary addObject:buyerLevIV];
    }
    [liveingV addSubview: buyerLevV];
    self.buyerLevIVs = ary;
    self.buyerLevV = buyerLevV;
    
    // country_flag
    UIImageView *buyerCountryFlagIV = [[UIImageView alloc] init];
    buyerCountryFlagIV.frame = CGRectMake(64, 210, 12, 12);
    [liveingV addSubview: buyerCountryFlagIV];
    self.buyerCountryFlagIV = buyerCountryFlagIV;
    
    // country
    UILabel *buyerCountryLab = [[UILabel alloc] init];
    buyerCountryLab.frame = CGRectMake(80, 211, 100, 11);
    buyerCountryLab.font = [UIFont systemFontOfSize: 9];
    buyerCountryLab.textColor = WJColor(0.6, 0.6, 0.6);
    [liveingV addSubview: buyerCountryLab];
    self.buyerCountryLab = buyerCountryLab;
    
    // 时间图标
    UIImageView *timeIV = [[UIImageView alloc] init];
    timeIV.frame = CGRectMake(214, 211, 10, 10);
    timeIV.image = [UIImage imageNamed:@"clock"];
    [liveingV addSubview: timeIV];
    self.timeIV = timeIV;
    
    // left_time
    UILabel *leftTimeLab = [[UILabel alloc] init];
    leftTimeLab.frame = CGRectMake(227, 210, 75, 12);
    leftTimeLab.font = [UIFont systemFontOfSize: 11];
    leftTimeLab.textColor = WJColor(1, 0.35, 0.3);
    [liveingV addSubview: leftTimeLab];
    self.leftTimeLab = leftTimeLab;
    
    // 最后盖上一张有圆角的
    UIImageView *radiusIV = [[UIImageView alloc] init];
    radiusIV.frame = CGRectMake(5, 10, 310, 220);
    // 设置圆角
    radiusIV.layer.masksToBounds = YES;
    radiusIV.layer.cornerRadius = 4;
    radiusIV.layer.borderWidth = 1;
    radiusIV.layer.borderColor = [UIColor redColor].CGColor;
    [liveingV addSubview: radiusIV];
    self.radiusIV = radiusIV;
}

- (void)setupNoticeLiveView
{
    //直播主view 所有控件都加到这个来.
    UIView *noticeMainV = [[UIView alloc] init];
    noticeMainV.frame = CGRectMake(0, 0, self.screenWidth, WJNoticeLiveCellH);
    [self.contentView addSubview: noticeMainV];
    self.noticeMainV = noticeMainV;
    
    //imgs 最大的背景图
    UIImageView *noticeImgsIV = [[UIImageView alloc] init];
    noticeImgsIV.frame = CGRectMake(5, 10, self.screenWidth - 10, 170);
    [noticeMainV addSubview: noticeImgsIV];
    self.noticeImgsIV = noticeImgsIV;
    
    //imgs 在图片上盖一张透明度的图片
    UIImageView *IV = [[UIImageView alloc] init];
    IV.frame = CGRectMake(0, 0, self.screenWidth - 10, 170);
    IV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [noticeImgsIV addSubview: IV];
    
    // buyer_head
    UIImageView *noticeBuyerHeadIV = [[UIImageView alloc] init];
    noticeBuyerHeadIV.frame = CGRectMake(137.5, 17.5, 45, 45);
    [noticeMainV addSubview: noticeBuyerHeadIV];
    self.noticeBuyerHeadIV = noticeBuyerHeadIV;
    
    // buyer_country_flag 国旗
    UIImageView *noticeBuyerCountryFlagIV = [[UIImageView alloc] init];
    noticeBuyerCountryFlagIV.frame = CGRectMake(97, 71, 12, 12);
    [noticeMainV addSubview: noticeBuyerCountryFlagIV];
    self.noticeBuyerCountryFlagIV = noticeBuyerCountryFlagIV;
    
    // buyer_name 买家名字
    UILabel *noticeBuyerNameLab = [[UILabel alloc] init];
    noticeBuyerNameLab.frame = CGRectMake(111, 70, 160, 12);
    noticeBuyerNameLab.font = [UIFont systemFontOfSize: 12];
    noticeBuyerNameLab.textColor = [UIColor whiteColor];
    [noticeMainV addSubview: noticeBuyerNameLab];
    self.noticeBuyerNameLab = noticeBuyerNameLab;
    
    // name 标题
    UILabel *noticeNameLab = [[UILabel alloc] init];
    noticeNameLab.frame = CGRectMake(10, 102.5, 290, 18);
    noticeNameLab.font = [UIFont systemFontOfSize: 15];
    noticeNameLab.textColor = [UIColor whiteColor];
    noticeNameLab.textAlignment = NSTextAlignmentCenter;
    [noticeMainV addSubview: noticeNameLab];
    self.noticeNameLab = noticeNameLab;
    
    // left_time 倒计时
    UILabel *noticeLeftTimeLab = [[UILabel alloc] init];
    noticeLeftTimeLab.frame = CGRectMake(70, 127, 180, 22);
    noticeLeftTimeLab.font = [UIFont systemFontOfSize: 14];
    noticeLeftTimeLab.textColor = [UIColor whiteColor];
    [noticeMainV addSubview: noticeLeftTimeLab];
    self.noticeLeftTimeLab = noticeLeftTimeLab;
    
    // 最后盖上一张有圆角的
    UIImageView *noticeRadiusIV = [[UIImageView alloc] init];
    noticeRadiusIV.frame = CGRectMake(5, 10, 310, 210);
    // 设置圆角
    noticeRadiusIV.layer.masksToBounds = YES;
    noticeRadiusIV.layer.cornerRadius = 4;
    noticeRadiusIV.layer.borderWidth = 1;
    noticeRadiusIV.layer.borderColor = [UIColor blueColor].CGColor;
    [noticeMainV addSubview: noticeRadiusIV];
    self.noticeRadiusIV = noticeRadiusIV;
    
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(30, 185, 100, 30);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize: 14];
    [leftBtn setTitle: @"设置提醒" forState: UIControlStateNormal];
    [leftBtn setTitleColor: [UIColor grayColor] forState: UIControlStateNormal];
    [noticeMainV addSubview: leftBtn];
    
    UIButton *reghtBtn = [[UIButton alloc] init];
    reghtBtn.frame = CGRectMake(190, 185, 100, 30);
    reghtBtn.titleLabel.font = [UIFont systemFontOfSize: 14];
    [reghtBtn setTitle: @"分享" forState: UIControlStateNormal];
    [reghtBtn setTitleColor: [UIColor grayColor] forState: UIControlStateNormal];
    [noticeMainV addSubview: reghtBtn];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LiveingTVCell";
    WJLiveingTVCell *cell = [tableView dequeueReusableCellWithIdentifier: ID];
    if (!cell) {
        cell = [[WJLiveingTVCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: ID];
    }
    return cell;
}

@end
