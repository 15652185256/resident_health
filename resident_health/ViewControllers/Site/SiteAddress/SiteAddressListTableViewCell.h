//
//  SiteAddressListTableViewCell.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/30.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteAddressListModel.h"
@interface SiteAddressListTableViewCell : UITableViewCell

//logo
@property(nonatomic,retain) UIImageView * logoImageView;
//名称
@property(nonatomic,retain) UILabel * titleLabel;
//图标
@property(nonatomic,retain) UIImageView * iconImageView;
//简介
@property(nonatomic,retain) UILabel * contentLabel;
//距离
@property(nonatomic,retain) UILabel * distanceLabel;
//底部分割线
@property(nonatomic,retain) UIView * BottomLineView;

-(void)configModel:(SiteAddressListModel*)model;
@end
