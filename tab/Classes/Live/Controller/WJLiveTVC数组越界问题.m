//
//  WJMainTVC.m
//  tab
//
//  Created by 王军 on 15/4/7.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJLiveTVC.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "WJLiveM.h"
#import "RequestData.h"
#import "WJBannerV.h"
#import "WJBannerCell.h"
#import "WJLiveingTVCell.h"


typedef enum {
    WJLeftBtn,
    WJRightBtn
} WJLeftRightBtn;

#define sectionHeaderVHeight 35

@interface WJMainTVC ()

/** 屏幕宽度 */
@property (nonatomic, assign) CGFloat screenWidth;

/** tableView组头 */
@property (nonatomic, strong) UIView *sectionHeaderV;

@property (nonatomic, weak) UIButton *leftBtn;

@property (nonatomic, weak) UIButton *rightBtn;

/** 两按钮下面的红线 */
@property (nonatomic, weak) UIView *lineV;

/** 横幅view */
@property (nonatomic, weak) WJBannerV *bannnerV;

/** 横幅列表模型 */
@property (nonatomic, strong) NSArray *bannerMAry;

/** 8个按钮模型 */
@property (nonatomic, strong) NSArray *categoryMAry;

/** 正在直播模型 */
@property (nonatomic, strong) NSArray *liveingMAry;

/** 直播预告模型 */
@property (nonatomic, strong) NSArray *noticeLiveMAry;

/** 左右按钮选中标记 */
@property (nonatomic, assign) WJLeftRightBtn selectLeftRightBtn;

@property (nonatomic, strong) NSTimer *subDateTimer;

@end


@implementation WJMainTVC


#pragma mark - 添加两个按钮

- (UIView *)sectionHeaderV
{
    if (!_sectionHeaderV) {
        UIView *v = [[UIView alloc] init];
        v.frame = CGRectMake(0, 0, self.screenWidth, sectionHeaderVHeight);
        v.backgroundColor = [UIColor whiteColor];
        
        CGFloat btnW = self.screenWidth / 2;
        UIButton *leftBtn = [self headerBtnWithX:0 title: @"正在直播" tag: (NSInteger)WJLeftBtn];
        [leftBtn addTarget: self action: @selector(leftBtnClick:) forControlEvents: UIControlEventTouchUpInside];
        leftBtn.selected = YES;
        [v addSubview: leftBtn];
        self.leftBtn = leftBtn;
        
        UIButton *rightBtn = [self headerBtnWithX: btnW title: @"直播预告" tag: (NSInteger)WJRightBtn];
        [rightBtn addTarget: self action: @selector(rightBtnClick:) forControlEvents: UIControlEventTouchUpInside];
        [v addSubview: rightBtn];
        self.rightBtn = rightBtn;
        
        //按钮下面一条红色线
        UIView *lineV = [[UIView alloc] init];
        [v addSubview: lineV];
        lineV.backgroundColor = [UIColor redColor];
        lineV.frame = CGRectMake(0, sectionHeaderVHeight - 1.3, btnW, 1.3);
        [v addSubview: lineV];
        self.lineV = lineV;
        _sectionHeaderV = v;
    }
    return _sectionHeaderV;
}

- (UIButton *)headerBtnWithX:(CGFloat)x title:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(x, 0, self.screenWidth / 2, sectionHeaderVHeight);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize: 15];
    [btn setTitleColor: [UIColor grayColor] forState: UIControlStateNormal];
    [btn setTitleColor: WJColor(1, 0.35, 0.3) forState: UIControlStateSelected];
    [btn setTitle: title forState: UIControlStateNormal];
    btn.tag = tag;
    return btn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.selectLeftRightBtn = WJLeftBtn;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self setupDownRefresh];
    
    //添加横幅view到tableView头上
    [self addBannerV];
    
    [self loadLiveAllData];
}

#pragma mark - 添加横幅view

- (void)addBannerV
{
    WJBannerV *bannnerV = [WJBannerV bannerView];
    self.bannnerV = bannnerV;
    self.tableView.tableHeaderView = bannnerV;
}

//集成刷新控件 下拉刷新数据
- (void)setupDownRefresh
{
    //添加刷新控件
    UIRefreshControl *refreshC = [[UIRefreshControl alloc] init];
    //用户往下拉时,就会触发UIControlEventValueChanged事件
    [refreshC addTarget: self action: @selector(loadNewStatus:) forControlEvents: UIControlEventValueChanged];
    [self.tableView addSubview: refreshC];
    
    //马上进入刷新状态(仅仅显示刷新状态,不会触发UIControlEventValueChanged事件)
    //[refreshC beginRefreshing];
    //调用一下UIControlEventValueChanged事件
    //[self loadNewStatus: refreshC];
}

- (void)loadNewStatus:(UIRefreshControl *)refreshC
{
    NSLog(@"下拉刷新");
    
    //结束刷新状态
    [refreshC endRefreshing];
    [self.tableView reloadData];
}

- (void)leftBtnClick:(UIButton *)btn
{
    if (self.selectLeftRightBtn == (WJLeftRightBtn)btn.tag) {
        return;
    }
    
    CGRect lineVFrame = self.lineV.frame;
    [UIView animateWithDuration: 0.4 animations:^{
        self.lineV.frame = CGRectMake(0, lineVFrame.origin.y, lineVFrame.size.width, lineVFrame.size.height);
        }];

    self.selectLeftRightBtn = WJLeftBtn;
    self.rightBtn.selected = NO;
    self.leftBtn.selected = YES;
    [self.tableView reloadData];
}

- (void)rightBtnClick:(UIButton *)btn
{
    if (self.selectLeftRightBtn == (WJLeftRightBtn)btn.tag) {
        return;
    }
    
    CGRect lineVFrame = self.lineV.frame;
    [UIView animateWithDuration: 0.4 animations:^{
        self.lineV.frame = CGRectMake(lineVFrame.size.width, lineVFrame.origin.y, lineVFrame.size.width, lineVFrame.size.height);
    }];
    self.selectLeftRightBtn = WJRightBtn;
    self.leftBtn.selected = NO;
    self.rightBtn.selected = YES;
    [self.tableView reloadData];
}

#pragma mark - get 全部数据

- (void)loadLiveAllData
{
    RequestData *rd = [RequestData sharedRequestData];
    
    [rd getLiveData:^(id responseData) {
        
        //GET数据后会回调这里
    
        NSDictionary *rstDict = responseData[@"rst"];
        //横幅模型
        NSArray *ary = (NSArray *)rstDict[@"bannerList"];
        self.bannerMAry = [WJBannerM bannerMAryWithDictAry: ary];
        self.bannnerV.bannerMAry = self.bannerMAry;
        
        //8个按钮模型
        ary = (NSArray *)rstDict[@"categoryList"];
        self.categoryMAry = [WJCategoryM categoryMAryWithDictAry: ary];
        self.bannnerV.categoryMAry = self.categoryMAry;
        
        //直播模型
        ary = (NSArray *)rstDict[@"livingList"];
        self.liveingMAry = [WJLiveingM liveingMAryWithDictAry: ary];
        self.selectLeftRightBtn = WJLeftBtn;
        //[self.tableView reloadData];
        [self addSubDateTimer];

        
        //预告模型
        ary = (NSArray *)rstDict[@"noticeLiveList"];
        NSLog(@"%@", ary[0]);
        self.noticeLiveMAry = [WJNoticeLiveM noticeliveMAryWithDictAry: ary];
        
        //刷新数据到tableView
    }];
}

//定时器,每一秒刷新一次画面
- (void)addSubDateTimer
{
    self.subDateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(subDate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.subDateTimer forMode:NSRunLoopCommonModes];
}

- (void)subDate
{
    for (int i = 0; i < self.liveingMAry.count; i++) {
            WJLiveingM *liveingM = (WJLiveingM *)self.liveingMAry[i];
            liveingM.left_time--;
    }
    
    for (int i = 0; i < self.noticeLiveMAry.count; i++) {
        WJNoticeLiveM *noticeLiveM = (WJNoticeLiveM *)self.noticeLiveMAry[i];
        noticeLiveM.liveingM.left_time--;
    }
    [self.tableView reloadData];
}

#pragma mark - tableView 数据源方法

//组头部view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderV;
}

//组头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeaderVHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (WJLeftBtn == self.selectLeftRightBtn) {
        return self.liveingMAry.count;
    }
    return self.noticeLiveMAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJLiveingTVCell *cell = [WJLiveingTVCell cellWithTableView: tableView];
    
    if (WJLeftBtn == self.selectLeftRightBtn) {
        NSLog(@"liveingMAry: %@-%ld", self.liveingMAry[indexPath.row], indexPath.row);
        cell.ShowM = self.liveingMAry[indexPath.row];
    } else {
        cell.ShowM = self.noticeLiveMAry[indexPath.row];
        NSLog(@"noticeLiveMAry: %@-%ld", self.noticeLiveMAry[indexPath.row], indexPath.row);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (WJLeftBtn == self.selectLeftRightBtn) {
        return WJLiveingCellH;
    }
    return WJNoticeLiveCellH;
}

@end
