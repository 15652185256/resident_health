//
//  MonitorListTableViewCell.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/14.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonitorListModel.h"

@interface MonitorListTableViewCell : UITableViewCell

//日期
@property(nonatomic,retain) UILabel * dateLabel;
//测量数值
@property(nonatomic,retain) UILabel * numberLabel;
//底部分割线
@property(nonatomic,retain) UIView * BottomLineView;

-(void)configModel:(MonitorListModel*)model tag:(NSInteger)tag;

@end
