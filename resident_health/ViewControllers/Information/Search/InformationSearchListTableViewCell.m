//
//  InformationSearchListTableViewCell.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "InformationSearchListTableViewCell.h"

@implementation InformationSearchListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self prepareUI];
    }
    return self;
}

-(void)prepareUI
{
    self.contentView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    //标题
    self.titleLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 9, WIDTH-15-10, 14) Font:14 Text:nil];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    
    //发布时间
    self.publishTimeLabel=[ZCControl createLabelWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame)+6, WIDTH-15-10, 12) Font:12 Text:nil];
    [self.contentView addSubview:self.publishTimeLabel];
    self.publishTimeLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    
    //底部分割线
    self.BottomLineView=[ZCControl createView:CGRectMake(15, CGRectGetMaxY(self.publishTimeLabel.frame)+9-0.5, WIDTH-15, 0.5)];
    [self.contentView addSubview:self.BottomLineView];
    self.BottomLineView.backgroundColor=CREATECOLOR(214, 214, 214, 1);
    
}

-(void)configModel:(InformationSearchListModel*)model
{
    //标题
    self.titleLabel.text=model.title;
    
    //发布时间
    self.publishTimeLabel.text=model.publishTime;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
