//
//  ToolsBodyWeightDetailViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/29.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ToolsBodyWeightDetailViewController.h"

@interface ToolsBodyWeightDetailViewController ()

@end

@implementation ToolsBodyWeightDetailViewController

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
    self.navigationItem.title = @"标准体重";
    
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
    UIImageView * bgHeaderImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, headerHeight) ImageName:@"tools_body_weight_header_bg@2x"];
    [self.view addSubview:bgHeaderImageView];
    
    
    float bgWidth=17*2+100+90;
    
    //背景
    UIView * bgView=[ZCControl createView:CGRectMake((WIDTH-bgWidth)/2, headerHeight+PAGESIZE(25), bgWidth, 45)];
    [self.view addSubview:bgView];
    bgView.backgroundColor=CREATECOLOR(240, 116, 116, 1);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5.0;
    
    //标题
    UILabel * whrTitleLabel=[ZCControl createLabelWithFrame:CGRectMake(17, 10, 100, 25) Font:25 Text:@"标准体重"];
    [bgView addSubview:whrTitleLabel];
    whrTitleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    
    //结果
    UILabel * whrLabel=[ZCControl createLabelWithFrame:CGRectMake(bgWidth-17-90, 10, 90, 26) Font:25 Text:self.body_weight];
    [bgView addSubview:whrLabel];
    whrLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    whrLabel.textAlignment=NSTextAlignmentRight;
    
    
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
