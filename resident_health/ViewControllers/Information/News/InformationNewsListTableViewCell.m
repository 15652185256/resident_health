//
//  InformationNewsListTableViewCell.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "InformationNewsListTableViewCell.h"

@implementation InformationNewsListTableViewCell

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
    self.titleLabel=[ZCControl createLabelWithFrame:CGRectMake(65, 0, WIDTH-65-10, 65) Font:14 Text:nil];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor=CREATECOLOR(52, 52, 52, 1);
    
    //发布时间背景
    self.bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(12, 12, 41, 41) ImageName:@"news_time_bgImage@2x"];
    [self.contentView addSubview:self.bgImageView];
    
    //发布时间 月份
    self.monthLabel=[ZCControl createLabelWithFrame:CGRectMake(10-3, 10, 16, 15) Font:15 Text:nil];
    [self.bgImageView addSubview:self.monthLabel];
    self.monthLabel.textColor=CREATECOLOR(255, 134, 8, 1);
    self.monthLabel.textAlignment=NSTextAlignmentCenter;
    
    //发布时间 分割线
    self.lineLabel=[ZCControl createLabelWithFrame:CGRectMake(10+16-3-2, 15, 10, 17) Font:17 Text:@"/"];
    [self.bgImageView addSubview:self.lineLabel];
    self.lineLabel.textColor=CREATECOLOR(255, 134, 8, 1);
    
    //发布时间 日期
    self.dayLabel=[ZCControl createLabelWithFrame:CGRectMake(10+16+2-2, 22, 15, 10) Font:10 Text:nil];
    [self.bgImageView addSubview:self.dayLabel];
    self.dayLabel.textColor=CREATECOLOR(255, 134, 8, 1);
    self.dayLabel.textAlignment=NSTextAlignmentCenter;
    
    //底部分割线
    self.BottomLineView=[ZCControl createView:CGRectMake(0, 65-0.5, WIDTH, 0.5)];
    [self.contentView addSubview:self.BottomLineView];
    self.BottomLineView.backgroundColor=CREATECOLOR(214, 214, 214, 1);
    
    
}

-(void)configModel:(InformationNewsListModel*)model
{
    //标题
    self.titleLabel.text=model.title;
    
    NSArray * strArray=[model.date componentsSeparatedByString:@"-"];
    
    //发布时间
    self.monthLabel.text=strArray[1];
    
    self.dayLabel.text=strArray[2];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
