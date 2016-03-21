//
//  MonitorListTableViewCell.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/14.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "MonitorListTableViewCell.h"

@implementation MonitorListTableViewCell

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
    
    //日期
    self.dateLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, 100, 36) Font:15 Text:nil];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.textColor=CREATECOLOR(101 ,101, 101, 1);
    

    //测量数值
    self.numberLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-150, 0, 120, 36) Font:15 Text:nil];
    [self.contentView addSubview:self.numberLabel];
    self.numberLabel.textColor=CREATECOLOR(101 ,101, 101, 1);
    
    //底部分割线
    self.BottomLineView=[ZCControl createView:CGRectMake(15, 36-0.5, WIDTH, 0.5)];
    [self.contentView addSubview:self.BottomLineView];
    self.BottomLineView.backgroundColor=CREATECOLOR(214, 214, 214, 1);
}

-(void)configModel:(MonitorListModel*)model tag:(NSInteger)tag
{    
    self.dateLabel.text=model.date;
    self.numberLabel.text=model.bodyWeight;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
