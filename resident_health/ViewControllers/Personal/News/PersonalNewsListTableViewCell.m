//
//  PersonalNewsListTableViewCell.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "PersonalNewsListTableViewCell.h"

@implementation PersonalNewsListTableViewCell

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
    //标记
    self.isReadView=[ZCControl createView:CGRectMake(10, (70-10)/2, 10, 10)];
    [self.contentView addSubview:self.isReadView];
    self.isReadView.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    self.isReadView.layer.cornerRadius=self.isReadView.frame.size.width/2;
    self.isReadView.layer.masksToBounds=YES;
    
    //标题
    self.titleLabel=[ZCControl createLabelWithFrame:CGRectMake(10+10+10, 10, WIDTH-15-80-10, 14) Font:14 Text:nil];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor=CREATECOLOR(52, 52, 52, 1);
    self.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    
    //发布时间
    self.postTimeLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-10-7-7-80, 10, 80, 12) Font:12 Text:nil];
    [self.contentView addSubview:self.postTimeLabel];
    self.postTimeLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    self.postTimeLabel.textAlignment=NSTextAlignmentRight;
    
    //右箭头
    self.arrowImageView=[ZCControl createImageViewWithFrame:CGRectMake(WIDTH-10-7, 10, 7, 12) ImageName:@"personal_arrow@2x"];
    [self.contentView addSubview:self.arrowImageView];
    
    //内容
    self.detailLabel=[ZCControl createLabelWithFrame:CGRectMake(10+10+10, 10+14+5, WIDTH-30, 12+8+12) Font:12 Text:nil];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    self.detailLabel.numberOfLines=0;
}

-(void)configModel:(PersonalNewsListModel*)model
{
    //标题
    self.titleLabel.text=model.title;
    
    //发布时间
    self.postTimeLabel.text=model.postTime;
    
    //内容
    NSString * labelText=model.detail;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.detailLabel.attributedText = attributedString;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
