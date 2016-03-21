//
//  InformationViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "InformationViewController.h"


#import "InformationSearchListViewController.h"//搜索

#import "InformationNewsListViewController.h"//新闻列表

#import "InformationHealthViewController.h"//健康课堂

#import "InformationDiseaseViewController.h"//疾病百科

#import "InformationNewsDetailViewController.h"//文章详情

@interface InformationViewController ()

@property(nonatomic,retain)UIButton * healthButton;//健康课堂
@property(nonatomic,retain)UIButton * diseaseButton;//疾病百科

@property(nonatomic,retain)InformationHealthViewController * hvc;

@property(nonatomic,retain)InformationDiseaseViewController * dvc;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
    //设置导航的切换按钮 背景
    UIView * switchView=[ZCControl createView:CGRectMake(0, 0, 160, 30)];
    switchView.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    switchView.layer.cornerRadius= 15;
    switchView.layer.masksToBounds= YES;
    self.navigationItem.titleView=switchView;
    
    //设置健康课堂按钮
    _healthButton=[ZCControl createButtonWithFrame:CGRectMake(1, 1, 80-1, 30-2) Text:@"健康课堂" ImageName:nil bgImageName:nil Target:self Method:@selector(healthButtonClick)];
    [switchView addSubview:_healthButton];
    
    //标题的内边距
    _healthButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_healthButton setTitleColor:CREATECOLOR(119, 143, 28, 1) forState:UIControlStateNormal];
    _healthButton.titleLabel.font=[UIFont systemFontOfSize:14];
    
    //按钮背景
    _healthButton.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    UIBezierPath * healthButton_maskPath = [UIBezierPath bezierPathWithRoundedRect:_healthButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer * healthButton_maskLayer = [[CAShapeLayer alloc] init];
    healthButton_maskLayer.frame = _healthButton.bounds;
    healthButton_maskLayer.path = healthButton_maskPath.CGPath;
    _healthButton.layer.mask = healthButton_maskLayer;
    
    
    //设置疾病百科按钮
    _diseaseButton=[ZCControl createButtonWithFrame:CGRectMake(80, 1, 80-1, 30-2) Text:@"疾病百科" ImageName:nil bgImageName:nil Target:self Method:@selector(diseaseButtonClick)];
    [switchView addSubview:_diseaseButton];
    
    //标题的内边距
    _diseaseButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [_diseaseButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _diseaseButton.titleLabel.font=[UIFont systemFontOfSize:14];
    
    //按钮背景
    _diseaseButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    UIBezierPath * diseaseButton_maskPath = [UIBezierPath bezierPathWithRoundedRect:_diseaseButton.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer * diseaseButton_maskLayer = [[CAShapeLayer alloc] init];
    diseaseButton_maskLayer.frame = _diseaseButton.bounds;
    diseaseButton_maskLayer.path = diseaseButton_maskPath.CGPath;
    _diseaseButton.layer.mask = diseaseButton_maskLayer;
    
    
    //设置搜索按钮
    UIButton * searchButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 36, 36) Text:nil ImageName:@"nav_search@2x.png" bgImageName:nil Target:self Method:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchButton];
    
}

//健康课堂 切换
-(void)healthButtonClick
{
    [_healthButton setTitleColor:CREATECOLOR(119, 143, 28, 1) forState:UIControlStateNormal];
    _healthButton.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    
    [_diseaseButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _diseaseButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    [_dvc.view removeFromSuperview];
    [self.view addSubview:_hvc.view];
}

//疾病百科 切换
-(void)diseaseButtonClick
{
    [_healthButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _healthButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    [_diseaseButton setTitleColor:CREATECOLOR(119, 143, 28, 1) forState:UIControlStateNormal];
    _diseaseButton.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    
    [_hvc.view removeFromSuperview];
    [self.view addSubview:_dvc.view];
}

//搜索
-(void)searchButtonClick
{
    InformationSearchListViewController * svc=[[InformationSearchListViewController alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}


#pragma mark 设置页面
-(void)createView
{
    InformationViewController * vc = self;
    
    _hvc=[[InformationHealthViewController alloc]init];
    _hvc.myBlock=^(NSString * title){
        InformationNewsListViewController * newsListvc=[[InformationNewsListViewController alloc]init];
        newsListvc.navTitle=title;
        newsListvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:newsListvc animated:YES];
    };
    _hvc.newBlock=^(NSString * title){
        InformationNewsDetailViewController * newsDetailvc=[[InformationNewsDetailViewController alloc]init];
        newsDetailvc.navTitle=@"疾病预防";
        newsDetailvc.newsTitle=title;
        newsDetailvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:newsDetailvc animated:YES];
    };
    
    
    
    
    _dvc=[[InformationDiseaseViewController alloc]init];
    _dvc.myBlock=^(NSString * title){
        InformationNewsListViewController * newsListvc=[[InformationNewsListViewController alloc]init];
        newsListvc.navTitle=title;
        newsListvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:newsListvc animated:YES];
    };
    _dvc.newBlock=^(NSString * title){
        InformationNewsDetailViewController * newsDetailvc=[[InformationNewsDetailViewController alloc]init];
        newsDetailvc.navTitle=@"疾病预防";
        newsDetailvc.newsTitle=title;
        newsDetailvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:newsDetailvc animated:YES];
    };
    
    [self.view addSubview:_hvc.view];
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
