//
//  PersonalNewsListTableViewCell.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalNewsListModel.h"
@interface PersonalNewsListTableViewCell : UITableViewCell
//标志
@property(nonatomic,retain) UIView * isReadView;
//标题
@property(nonatomic,retain) UILabel * titleLabel;
//内容
@property(nonatomic,retain) UILabel * detailLabel;
//发布时间
@property(nonatomic,retain) UILabel * postTimeLabel;
//右箭头
@property(nonatomic,retain) UIImageView * arrowImageView;

-(void)configModel:(PersonalNewsListModel*)model;
@end
