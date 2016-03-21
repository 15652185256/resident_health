//
//  FristMonitorViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "FristMonitorViewController.h"
#import "SXWaveView.h"  // -----步骤1 引入自定义view头文件
#import "SXHalfWaveView.h"

#import "POP.h"//pop动画


@interface FristMonitorViewController ()

@property(nonatomic,retain)UIImageView * bgImageView;

@property(nonatomic,retain)SXWaveView * cubageAnimateView;// ------步骤2 建一个成员变量
@property(nonatomic,retain)SXWaveView * animateView2;
@property(nonatomic,retain)SXWaveView * animateView3;
@property(nonatomic,retain)SXWaveView * sbp_dbp_AnimateView;
@property(nonatomic,retain)SXWaveView * heart_rate_AnimateView;
@property(nonatomic,retain)SXWaveView * heart_data_AnimateView;
@property(nonatomic,retain)SXWaveView * body_weight_AnimateView;

@end

@implementation FristMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置页面
    [self createView];
}

#pragma mark 设置页面
-(void)createView
{
    _bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-46-64) ImageName:@"hm_bg_1@2x"];
    [self.view addSubview:_bgImageView];
    
    [self createFristSXWaveView];
    
}

//创建图标
-(void)createFristSXWaveView
{
    [self removeFristSXWaveView];
    
    //血压
    self.sbp_dbp_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(107), PAGESIZE(107))];
    [self.sbp_dbp_AnimateView setPrecent:99 description:@"血压" descText:@"185/95 mmhg" descType:2 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(254, 2, 0, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    self.sbp_dbp_AnimateView.center=CGPointMake(_bgImageView.center.x+10, HEIGHT/2-64-10);
    [_bgImageView addSubview:self.sbp_dbp_AnimateView];
    
    //加个手势
    self.sbp_dbp_AnimateView.tag=3000+4;
    self.sbp_dbp_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.sbp_dbp_AnimateView addGestureRecognizer:tap4];
    
    
    //血氧
    self.cubageAnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(90), PAGESIZE(90))];
    [self.cubageAnimateView setPrecent:99 description:@"血氧" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.cubageAnimateView];
    self.cubageAnimateView.center=CGPointMake(self.sbp_dbp_AnimateView.center.x-PAGESIZE(80), self.sbp_dbp_AnimateView.center.y-PAGESIZE(122));
    CGRect view1ToFrame=self.cubageAnimateView.frame;
    self.cubageAnimateView.center=self.sbp_dbp_AnimateView.center;
    [self showPopWithPopButton:self.cubageAnimateView showPosition:view1ToFrame];
    
    //加个手势
    self.cubageAnimateView.tag=3000+1;
    self.cubageAnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.cubageAnimateView addGestureRecognizer:tap1];
    
    
    //人体成分
    self.animateView2 = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(118), PAGESIZE(118))];
    [self.animateView2 setPrecent:99 description:@"人体成分" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.animateView2];
    self.animateView2.center=CGPointMake(self.sbp_dbp_AnimateView.center.x+PAGESIZE(65), self.sbp_dbp_AnimateView.center.y-PAGESIZE(134));
    CGRect view2ToFrame=self.animateView2.frame;
    self.animateView2.center=self.sbp_dbp_AnimateView.center;
    [self showPopWithPopButton:self.animateView2 showPosition:view2ToFrame];
    
    //加个手势
    self.animateView2.tag=3000+2;
    self.animateView2.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.animateView2 addGestureRecognizer:tap2];
    
    
    //血糖
    self.animateView3 = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.animateView3 setPrecent:99 description:@"血糖" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.animateView3];
    self.animateView3.center=CGPointMake(self.sbp_dbp_AnimateView.center.x-PAGESIZE(125), self.sbp_dbp_AnimateView.center.y+PAGESIZE(36));
    CGRect view3ToFrame=self.animateView3.frame;
    self.animateView3.center=self.sbp_dbp_AnimateView.center;
    [self showPopWithPopButton:self.animateView3 showPosition:view3ToFrame];
    
    //加个手势
    self.animateView3.tag=3000+3;
    self.animateView3.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.animateView3 addGestureRecognizer:tap3];
    
    
    //心率
    self.heart_rate_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.heart_rate_AnimateView setPrecent:99 description:@"心率" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.heart_rate_AnimateView];
    self.heart_rate_AnimateView.center=CGPointMake(self.sbp_dbp_AnimateView.center.x+PAGESIZE(107), self.sbp_dbp_AnimateView.center.y+PAGESIZE(72));
    CGRect view5ToFrame=self.heart_rate_AnimateView.frame;
    self.heart_rate_AnimateView.center=self.sbp_dbp_AnimateView.center;
    [self showPopWithPopButton:self.heart_rate_AnimateView showPosition:view5ToFrame];
    
    //加个手势
    self.heart_rate_AnimateView.tag=3000+5;
    self.heart_rate_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.heart_rate_AnimateView addGestureRecognizer:tap5];

    
    //心电
    self.heart_data_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(88), PAGESIZE(88))];
    [self.heart_data_AnimateView setPrecent:99 description:@"心电" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.heart_data_AnimateView];
    self.heart_data_AnimateView.center=CGPointMake(self.sbp_dbp_AnimateView.center.x-PAGESIZE(96), self.sbp_dbp_AnimateView.center.y+PAGESIZE(160));
    CGRect view6ToFrame=self.heart_data_AnimateView.frame;
    self.heart_data_AnimateView.center=self.sbp_dbp_AnimateView.center;
    [self showPopWithPopButton:self.heart_data_AnimateView showPosition:view6ToFrame];
    
    //加个手势
    self.heart_data_AnimateView.tag=3000+6;
    self.heart_data_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.heart_data_AnimateView addGestureRecognizer:tap6];

    
    //体重
    self.body_weight_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.body_weight_AnimateView setPrecent:99 description:@"体重" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.body_weight_AnimateView];
    self.body_weight_AnimateView.center=CGPointMake(self.sbp_dbp_AnimateView.center.x+PAGESIZE(26), self.sbp_dbp_AnimateView.center.y+PAGESIZE(170));
    CGRect view7ToFrame=self.body_weight_AnimateView.frame;
    self.body_weight_AnimateView.center=self.sbp_dbp_AnimateView.center;
    [self showPopWithPopButton:self.body_weight_AnimateView showPosition:view7ToFrame];
    
    //加个手势
    self.body_weight_AnimateView.tag=3000+7;
    self.body_weight_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.body_weight_AnimateView addGestureRecognizer:tap7];
    
    
    //设置动画
    [self animateSXWaveView];
}

//弹出动画
-(void)showPopWithPopButton:(UIView *)aButton showPosition:(CGRect)aRect
{
    POPSpringAnimation * positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    positionAnimation.fromValue = [NSValue valueWithCGRect:aButton.frame];
    positionAnimation.toValue = [NSValue valueWithCGRect:aRect];
    positionAnimation.springBounciness = 15.0f;
    positionAnimation.springSpeed = 10.0f;
    [aButton pop_addAnimation:positionAnimation forKey:@"frameAnimation"];
}

//移除
-(void)removeFristSXWaveView
{
    [self.cubageAnimateView removeFromSuperview];
    [self.animateView2 removeFromSuperview];
    [self.animateView3 removeFromSuperview];
    [self.sbp_dbp_AnimateView removeFromSuperview];
    [self.heart_rate_AnimateView removeFromSuperview];
    [self.heart_data_AnimateView removeFromSuperview];
    [self.body_weight_AnimateView removeFromSuperview];
}

//动画
-(void)animateSXWaveView
{
    [self.cubageAnimateView addAnimateWithType:0];
    [self.animateView2 addAnimateWithType:0];
    [self.animateView3 addAnimateWithType:0];
    [self.sbp_dbp_AnimateView addAnimateWithType:0];
    [self.heart_rate_AnimateView addAnimateWithType:0];
    [self.heart_data_AnimateView addAnimateWithType:0];
    [self.body_weight_AnimateView addAnimateWithType:0];
}

//进入单项监测
-(void)tapGestureAction:(UITapGestureRecognizer*)tap
{
    NSString * str;
    switch (tap.view.tag-3000) {
        case 1:
            str=@"血氧";
            break;
        case 2:
            str=@"人体成分";
            break;
        case 3:
            str=@"血糖";
            break;
        case 4:
            str=@"血压";
            break;
        case 5:
            str=@"心率";
            break;
        case 6:
            str=@"心电";
            break;
        case 7:
            str=@"体重";
            break;
        default:
            break;
    }
    
    if (self.myBlock) {
        self.myBlock(str);
    }
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
