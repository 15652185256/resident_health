//
//  PersonalDataTableViewCell.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "PersonalDataTableViewCell.h"

@implementation PersonalDataTableViewCell

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
    //标题
    self.detailLabel=[ZCControl createLabelWithFrame:CGRectMake(80, 0, WIDTH-10-7-10-80, 40) Font:14 Text:nil];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    self.detailLabel.textAlignment=NSTextAlignmentRight;
}

-(void)configModel:(NSString*)title
{
    self.detailLabel.text=title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
