//
//  SiteViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "SiteViewController.h"
//场馆位置
#import "SiteAddressListViewController.h"
//场馆详情
#import "SiteAddressDetailViewController.h"
//关于我们
#import "AboutUsListViewController.h"

#import "SiteAddressListModel.h"

@interface SiteViewController ()

@property(nonatomic,retain)UIButton * siteAddressButton;//场馆位置
@property(nonatomic,retain)UIButton * aboutUsButton;//关于我们

@property(nonatomic,retain)SiteAddressListViewController * svc;

@property(nonatomic,retain)AboutUsListViewController * avc;

@end

@implementation SiteViewController

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
    
    //设置场馆位置按钮
    _siteAddressButton=[ZCControl createButtonWithFrame:CGRectMake(1, 1, 80-1, 30-2) Text:@"场馆位置" ImageName:nil bgImageName:nil Target:self Method:@selector(siteAddressButtonClick)];
    [switchView addSubview:_siteAddressButton];
    
    //标题的内边距
    _siteAddressButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_siteAddressButton setTitleColor:CREATECOLOR(119, 143, 28, 1) forState:UIControlStateNormal];
    _siteAddressButton.titleLabel.font=[UIFont systemFontOfSize:14];
    
    //按钮背景
    _siteAddressButton.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    UIBezierPath * siteAddressButton_maskPath = [UIBezierPath bezierPathWithRoundedRect:_siteAddressButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer * siteAddressButton_maskLayer = [[CAShapeLayer alloc] init];
    siteAddressButton_maskLayer.frame = _siteAddressButton.bounds;
    siteAddressButton_maskLayer.path = siteAddressButton_maskPath.CGPath;
    _siteAddressButton.layer.mask = siteAddressButton_maskLayer;
    
    
    //设置关于我们按钮
    _aboutUsButton=[ZCControl createButtonWithFrame:CGRectMake(80, 1, 80-1, 30-2) Text:@"关于我们" ImageName:nil bgImageName:nil Target:self Method:@selector(aboutUsButtonClick)];
    [switchView addSubview:_aboutUsButton];
    
    //标题的内边距
    _aboutUsButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [_aboutUsButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _aboutUsButton.titleLabel.font=[UIFont systemFontOfSize:14];
    
    //按钮背景
    _aboutUsButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    UIBezierPath * aboutUsButton_maskPath = [UIBezierPath bezierPathWithRoundedRect:_aboutUsButton.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer * aboutUsButton_maskLayer = [[CAShapeLayer alloc] init];
    aboutUsButton_maskLayer.frame = _aboutUsButton.bounds;
    aboutUsButton_maskLayer.path = aboutUsButton_maskPath.CGPath;
    _aboutUsButton.layer.mask = aboutUsButton_maskLayer;
    
    
}

//场馆位置 切换
-(void)siteAddressButtonClick
{
    [_siteAddressButton setTitleColor:CREATECOLOR(119, 143, 28, 1) forState:UIControlStateNormal];
    _siteAddressButton.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    
    [_aboutUsButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _aboutUsButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    [_avc.view removeFromSuperview];
    [self.view addSubview:_svc.view];
}

//关于我们 切换
-(void)aboutUsButtonClick
{
    [_siteAddressButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _siteAddressButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    [_aboutUsButton setTitleColor:CREATECOLOR(119, 143, 28, 1) forState:UIControlStateNormal];
    _aboutUsButton.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    
    [_svc.view removeFromSuperview];
    [self.view addSubview:_avc.view];
}



#pragma mark 设置页面
-(void)createView
{
    SiteViewController * vc = self;
    
    _svc=[[SiteAddressListViewController alloc]init];
    _svc.myBlock=^(SiteAddressListModel * model){
        SiteAddressDetailViewController * _nvc=[[SiteAddressDetailViewController alloc]init];
        _nvc.navTitle=model.name;
        _nvc.address=model.address;
        _nvc.content=model.descripe;
        //NSLog(@"%@",model.panoramaURL);
        _nvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:_nvc animated:YES];
    };
    
    _avc=[[AboutUsListViewController alloc]init];
//    _dvc.myBlock=^(NSString * title){
//        _nvc.navTitle=title;
//        _nvc.hidesBottomBarWhenPushed=YES;
//        [vc.navigationController pushViewController:_nvc animated:YES];
//    };
    
    [self.view addSubview:_svc.view];
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
