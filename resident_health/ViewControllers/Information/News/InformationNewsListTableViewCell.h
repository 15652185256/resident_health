//
//  InformationNewsListTableViewCell.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationNewsListModel.h"
@interface InformationNewsListTableViewCell : UITableViewCell
//新闻标题
@property(nonatomic,retain) UILabel * titleLabel;
//时间背景
@property(nonatomic,retain) UIImageView * bgImageView;
//发布时间 月份
@property(nonatomic,retain) UILabel * monthLabel;
//发布时间 分割线
@property(nonatomic,retain) UILabel * lineLabel;
//发布时间 日期
@property(nonatomic,retain) UILabel * dayLabel;
//底部分割线
@property(nonatomic,retain) UIView * BottomLineView;

-(void)configModel:(InformationNewsListModel*)model;
@end
