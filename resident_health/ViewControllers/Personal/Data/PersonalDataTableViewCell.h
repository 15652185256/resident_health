//
//  PersonalDataTableViewCell.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalDataTableViewCell : UITableViewCell
//内容
@property(nonatomic,retain) UILabel * detailLabel;

-(void)configModel:(NSString*)title;

@end
