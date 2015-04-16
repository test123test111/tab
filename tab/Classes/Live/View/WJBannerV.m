//
//  WJBannerV.m
//  tab
//
//  Created by 王军 on 15/4/11.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJBannerV.h"
#import "WJBannerCell.h"
#import "WJTitleBtn.h"
#import "UIButton+WebCache.h"
#import "WJLiveM.h"


// 每一组最大的行数
#define WJNewsTotalRowsInSection (5000 * self.bannerMAry.count)
#define WJNewsDefaultRow (NSUInteger)(WJNewsTotalRowsInSection * 0.5)


@interface WJBannerV () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

//8个按钮数组
@property (nonatomic, strong) NSArray *btnAry;

@end

@implementation WJBannerV

+ (instancetype)bannerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WJBannerV" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor grayColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WJBannerCell" bundle:nil] forCellWithReuseIdentifier:@"BCell"];
    
    NSMutableArray *btnAry = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        WJTitleBtn *btn = [WJTitleBtn buttonWithType: UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        btn.tag = i;
        [self addSubview: btn];
        [btnAry addObject: btn];
    }
    self.btnAry = btnAry;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.btnAry.count; i++) {
        WJTitleBtn *btn = (WJTitleBtn *)self.btnAry[i];
        CGFloat btnX = i % 4 * 80;
        CGFloat btnY = 150 + i / 4 * 80;
        btn.frame = CGRectMake(btnX, btnY, 79.5, 79.5);
    }
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 3 target:self selector:@selector(nextNews) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextNews
{
    NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    NSUInteger visiableItem = visiablePath.item;
    if ((visiablePath.item % self.bannerMAry.count)  == 0) { // 第0张图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:WJNewsDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = WJNewsDefaultRow;
    }
    
    NSUInteger nextItem = visiableItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

//设置横幅模型
- (void)setBannerMAry:(NSArray *)bannerMAry
{
    _bannerMAry = bannerMAry;
    
    // 刷新数据
    [self.collectionView reloadData];
    if (bannerMAry && bannerMAry.count > 1) {
        // 总页数
        self.pageControl.numberOfPages = bannerMAry.count;
        // 默认组
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem: WJNewsDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [self addTimer];
    }
}

//设置8个按钮模型
- (void)setCategoryMAry:(NSArray *)categoryMAry
{
    _categoryMAry = categoryMAry;
    
    for (int i = 0; i < self.btnAry.count; i++) {
        
        WJCategoryM *categoryM = categoryMAry[i];
        NSString *urlStr = [NSString stringWithFormat: @"http://api.taoshij.com%@", categoryM.img];
        //NSLog(@"%@", urlStr);
        WJTitleBtn *btn = (WJTitleBtn *)self.btnAry[i];
        [btn sd_setImageWithURL: [NSURL URLWithString: urlStr] forState: UIControlStateNormal];
        [btn setTitle: categoryM.category forState: UIControlStateNormal];
    }
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"横幅广告 %lu 张.", self.bannerMAry.count);
    if (self.bannerMAry && self.bannerMAry.count > 1) {
        return WJNewsTotalRowsInSection;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"BCell";
    WJBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.bannerM = self.bannerMAry[indexPath.item % self.bannerMAry.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item % self.bannerMAry.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.bannerMAry && self.bannerMAry.count > 1) {
        [self addTimer];
    }
}


@end
