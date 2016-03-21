//
//  SiteAddressListTableViewCell.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/30.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "SiteAddressListTableViewCell.h"

@implementation SiteAddressListTableViewCell

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
    
    //logo
    self.logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 80, 60)];
    [self.contentView addSubview:self.logoImageView];
    
    //名称
    self.titleLabel=[ZCControl createLabelWithFrame:CGRectMake(15+80+10, 20, WIDTH-10-(15+80+10), 15) Font:15 Text:nil];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    self.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    
    //图标
    self.iconImageView=[ZCControl createImageViewWithFrame:CGRectMake(15+80+10, 20+15+14, 11, 16) ImageName:@"site_address_blue@2x"];
    [self.contentView addSubview:self.iconImageView];
    
    //简介
    self.contentLabel=[ZCControl createLabelWithFrame:CGRectMake(15+80+10+11+6, 20+15+8, WIDTH-(15+80+10+11+6)-80-10, 40) Font:12 Text:nil];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    self.contentLabel.numberOfLines=0;
    
    //距离
    self.distanceLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-80, 58, 80, 12) Font:12 Text:@"据您1690米"];
    [self.contentView addSubview:self.distanceLabel];
    self.distanceLabel.textColor=CREATECOLOR(117, 144, 26, 1);
    
    //底部分割线
    self.BottomLineView=[ZCControl createView:CGRectMake(0, 100-0.5, WIDTH, 0.5)];
    [self.contentView addSubview:self.BottomLineView];
    self.BottomLineView.backgroundColor=CREATECOLOR(214, 214, 214, 1);
}

-(void)configModel:(SiteAddressListModel*)model
{
    //logo
    //[self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
    self.logoImageView.image=[UIImage imageNamed:model.imageURL];
    
    //名称
    self.titleLabel.text=model.name;
    
    //简介
    NSString * labelText=[NSString stringWithFormat:@"%@\n\n\n\n\n\n",model.address];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.contentLabel.attributedText = attributedString;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
