//
//  WJButton.m
//  WeiBo
//
//  Created by 王军 on 15/3/19.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "WJTitleBtn.h"

@implementation WJTitleBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize: 13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //[self setImage: [UIImage imageNamed: @"navigationbar_arrow_down"] forState: UIControlStateNormal];
        
        //测试用
        //self.backgroundColor = [UIColor redColor];
        //self.imageView.backgroundColor = [UIColor yellowColor];
        //self.titleLabel.backgroundColor = [UIColor blueColor];
    }
    return self;
}

//得新摆放按钮内部 图片与文字的位置 图片在文字右边
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    self.imageView.x = 32;
//    self.imageView.y = 10;
//    
//    self.titleLabel.x = 22;
//    self.titleLabel.y = 45;
//    
//    
//}
//8个按钮 图片 x 27.5  y15  w 25  h25
//文字 x 0  y50  w 80  h15

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 27.5;
    CGFloat imageY = 15;
    CGFloat W = 25;
    CGFloat H = 25;
    return CGRectMake(imageX, imageY, W, H);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleX = 0;
    CGFloat titleY = 50;
    CGFloat W = 80;
    CGFloat H = 15;
    return CGRectMake(titleX, titleY, W, H);
    
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle: title forState: state];
    //安包尺寸自适应
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage: image forState: state];
    //安包尺寸自适应
    [self sizeToFit];
}

@end




























