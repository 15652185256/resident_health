//
//  ToolsBmrDetailViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/29.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ToolsBmrDetailViewController.h"

@interface ToolsBmrDetailViewController ()

@end

@implementation ToolsBmrDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    //设置导航
    [self createNav];
    
    //设置页面
    [self createView];
}

#pragma mark 设置导航
-(void)createNav
{
    //设置导航不透明
    self.navigationController.navigationBar.translucent=NO;
    
    //设置导航的标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(255, 255, 255, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationItem.title = @"基础代谢";
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 10, 18) Text:nil ImageName:nil bgImageName:@"reg_return@2x.png" Target:self Method:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:returnButton];
}

//返回
-(void)returnButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 设置页面
-(void)createView
{
    float headerHeight=PAGESIZE(107);
    
    //头部背景
    UIImageView * bgHeaderImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, headerHeight) ImageName:@"tools_bmr_header_bg@2x"];
    [self.view addSubview:bgHeaderImageView];
    
    float bgWidth=17*2+116+120;
    
    //背景
    UIView * bgView=[ZCControl createView:CGRectMake((WIDTH-bgWidth)/2, headerHeight+PAGESIZE(25), bgWidth, 45)];
    [self.view addSubview:bgView];
    bgView.backgroundColor=CREATECOLOR(240, 116, 116, 1);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5.0;
    
    //标题
    UILabel * whrTitleLabel=[ZCControl createLabelWithFrame:CGRectMake(17, 10, 100, 25) Font:25 Text:@"基础代谢"];
    [bgView addSubview:whrTitleLabel];
    whrTitleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    
    //结果
    UILabel * whrLabel=[ZCControl createLabelWithFrame:CGRectMake(bgWidth-17-120, 10, 120, 25) Font:25 Text:self.bmr];
    [bgView addSubview:whrLabel];
    whrLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    whrLabel.textAlignment=NSTextAlignmentRight;
    
    
    //简介
    UILabel * contentLabel=[ZCControl createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(bgView.frame)+PAGESIZE(20), WIDTH-20, HEIGHT-64-headerHeight-PAGESIZE(25*2)-45-20) Font:15 Text:nil];
    [self.view addSubview:contentLabel];
    contentLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    contentLabel.numberOfLines=0;
    
    NSString * labelText=[NSString stringWithFormat:@"    您的基础代谢率是：%@。基础代谢率（Basal Metabolic Rate，MBR）是指在自然温度（18～25摄氏度）环境中，清醒、静卧、空腹、心思放松状态下，维持生命（心跳、呼吸、腺体分泌、肾脏过滤排泄、解毒等）所需要消耗的最低能量。\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",self.bmr];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    contentLabel.attributedText = attributedString;
    
    //重新计算
    UIButton * confirmButton=[ZCControl createButtonWithFrame:CGRectMake(0, HEIGHT-64-PAGESIZE(46), WIDTH, PAGESIZE(46)) Text:@"重新计算" ImageName:nil bgImageName:nil Target:self Method:@selector(confirmButtonClick)];
    [self.view addSubview:confirmButton];
    [confirmButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(20)];
    [confirmButton setBackgroundColor:CREATECOLOR(254, 154, 51, 1)];
    
}

//重新计算
-(void)confirmButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
