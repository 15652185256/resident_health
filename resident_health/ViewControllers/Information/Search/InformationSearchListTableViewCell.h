//
//  InformationSearchListTableViewCell.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationSearchListModel.h"
@interface InformationSearchListTableViewCell : UITableViewCell
//新闻标题
@property(nonatomic,retain) UILabel * titleLabel;
//发布时间
@property(nonatomic,retain) UILabel * publishTimeLabel;
//底部分割线
@property(nonatomic,retain) UIView * BottomLineView;

-(void)configModel:(InformationSearchListModel*)model;
@end
