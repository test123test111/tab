//
//  WJLiveingTVCell.h
//  tab
//
//  Created by 王军 on 15/4/13.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import <UIKit/UIKit.h>


#define WJLiveingCellH 230
#define WJNoticeLiveCellH 220

//RGB颜色
#define WJColor(r, g, b) [UIColor colorWithRed: (r) green: (g) blue: (b) alpha: 1.0]

@interface WJLiveingTVCell : UITableViewCell

@property (nonatomic, assign) Class ShowM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
