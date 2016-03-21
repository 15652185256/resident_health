//
//  ThirdMonitorViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "ThirdMonitorViewController.h"
#import "SXWaveView.h"  //波浪加载
#import "SXHalfWaveView.h"

#import "POP.h"//pop动画
@interface ThirdMonitorViewController ()

@property(nonatomic,retain)UIImageView * bgImageView;

@property(nonatomic,retain)SXWaveView * triglycerin_AnimateView;
@property(nonatomic,retain)SXWaveView * ldlc_AnimateView;
@property(nonatomic,retain)SXWaveView * hdlc_AnimateView;
@property(nonatomic,retain)SXWaveView * cholesterol_AnimateView;
@property(nonatomic,retain)SXWaveView * uric_acidAnimateView;

@end

@implementation ThirdMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置页面
    [self createView];
}

#pragma mark 设置页面
-(void)createView
{
    _bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-46-64) ImageName:@"hm_bg_3@2x"];
    [self.view addSubview:_bgImageView];
}

//创建图标
-(void)createThirdSXWaveView
{
    [self removeThirdSXWaveView];
    
    //高密度脂蛋白胆固醇
    self.hdlc_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(134), PAGESIZE(134))];
    [self.hdlc_AnimateView setPrecent:99 description:nil descText:nil descType:2 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(254, 2, 0, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    self.hdlc_AnimateView.center=CGPointMake(_bgImageView.center.x+20, HEIGHT/2-64+20);
    [_bgImageView addSubview:self.hdlc_AnimateView];
    
    UILabel * animateView3Label1=[ZCControl createLabelWithFrame:CGRectMake(0, self.hdlc_AnimateView.frame.size.height/2-30, self.hdlc_AnimateView.frame.size.width, 21) Font:PAGESIZE(20) Text:@"高密度脂"];
    animateView3Label1.textColor=CREATECOLOR(51, 51, 51, 1);
    animateView3Label1.textAlignment=NSTextAlignmentCenter;
    [self.hdlc_AnimateView addSubview:animateView3Label1];
    
    UILabel * animateView3Label2=[ZCControl createLabelWithFrame:CGRectMake(0, self.hdlc_AnimateView.frame.size.height/2-5, self.hdlc_AnimateView.frame.size.width, 21) Font:PAGESIZE(20) Text:@"蛋白胆固醇"];
    animateView3Label2.textColor=CREATECOLOR(51, 51, 51, 1);
    animateView3Label2.textAlignment=NSTextAlignmentCenter;
    [self.hdlc_AnimateView addSubview:animateView3Label2];
    
    UILabel * animateView3Label3=[ZCControl createLabelWithFrame:CGRectMake(0, self.hdlc_AnimateView.frame.size.height/2+17, self.hdlc_AnimateView.frame.size.width, 21) Font:PAGESIZE(13) Text:@"180/95 mmhg"];
    animateView3Label3.textColor=CREATECOLOR(254, 2, 0, 1);
    animateView3Label3.textAlignment=NSTextAlignmentCenter;
    [self.hdlc_AnimateView addSubview:animateView3Label3];
    
    //加个手势
    self.hdlc_AnimateView.tag=3000+3;
    self.hdlc_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.hdlc_AnimateView addGestureRecognizer:tap3];
    
    
    //甘油三酯
    self.triglycerin_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(120), PAGESIZE(120))];
    [self.triglycerin_AnimateView setPrecent:99 description:@"甘油三酯" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.triglycerin_AnimateView];
    self.triglycerin_AnimateView.center=CGPointMake(self.hdlc_AnimateView.center.x-PAGESIZE(104), self.hdlc_AnimateView.center.y-PAGESIZE(112));
    CGRect view1ToFrame=self.triglycerin_AnimateView.frame;
    self.triglycerin_AnimateView.center=self.hdlc_AnimateView.center;
    [self showPopWithPopButton:self.triglycerin_AnimateView showPosition:view1ToFrame];
    
    //加个手势
    self.triglycerin_AnimateView.tag=3000+1;
    self.triglycerin_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.triglycerin_AnimateView addGestureRecognizer:tap1];
    
    
    //低密度脂蛋白胆固醇
    self.ldlc_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(118), PAGESIZE(118))];
    [self.ldlc_AnimateView setPrecent:99 description:nil descText:nil descType:2 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.ldlc_AnimateView];
    self.ldlc_AnimateView.center=CGPointMake(self.hdlc_AnimateView.center.x+PAGESIZE(80), self.hdlc_AnimateView.center.y-PAGESIZE(150));
    CGRect view2ToFrame=self.ldlc_AnimateView.frame;
    self.ldlc_AnimateView.center=self.hdlc_AnimateView.center;
    [self showPopWithPopButton:self.ldlc_AnimateView showPosition:view2ToFrame];
    
    UILabel * animateView2Label1=[ZCControl createLabelWithFrame:CGRectMake(0, self.ldlc_AnimateView.frame.size.height/2-30, self.ldlc_AnimateView.frame.size.width, 21) Font:PAGESIZE(20) Text:@"低密度脂"];
    animateView2Label1.textColor=CREATECOLOR(51, 51, 51, 1);
    animateView2Label1.textAlignment=NSTextAlignmentCenter;
    [self.ldlc_AnimateView addSubview:animateView2Label1];
    
    UILabel * animateView2Label2=[ZCControl createLabelWithFrame:CGRectMake(0, self.ldlc_AnimateView.frame.size.height/2-5, self.ldlc_AnimateView.frame.size.width, 21) Font:PAGESIZE(20) Text:@"蛋白胆固醇"];
    animateView2Label2.textColor=CREATECOLOR(51, 51, 51, 1);
    animateView2Label2.textAlignment=NSTextAlignmentCenter;
    [self.ldlc_AnimateView addSubview:animateView2Label2];
    
    UILabel * animateView2Label3=[ZCControl createLabelWithFrame:CGRectMake(0, self.ldlc_AnimateView.frame.size.height/2+17, self.ldlc_AnimateView.frame.size.width, 21) Font:PAGESIZE(13) Text:@"99％"];
    animateView2Label3.textColor=CREATECOLOR(51, 51, 51, 1);
    animateView2Label3.textAlignment=NSTextAlignmentCenter;
    [self.ldlc_AnimateView addSubview:animateView2Label3];
    
    //加个手势
    self.ldlc_AnimateView.tag=3000+2;
    self.ldlc_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.ldlc_AnimateView addGestureRecognizer:tap2];
    
    
    //总胆固醇
    self.cholesterol_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.cholesterol_AnimateView setPrecent:99 description:@"总胆固醇" descText:nil descType:2 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.cholesterol_AnimateView];
    self.cholesterol_AnimateView.center=CGPointMake(self.hdlc_AnimateView.center.x-PAGESIZE(90), self.hdlc_AnimateView.center.y+PAGESIZE(122));
    CGRect view4ToFrame=self.cholesterol_AnimateView.frame;
    self.cholesterol_AnimateView.center=self.hdlc_AnimateView.center;
    [self showPopWithPopButton:self.cholesterol_AnimateView showPosition:view4ToFrame];
    
    UILabel * animateView4Label=[ZCControl createLabelWithFrame:CGRectMake(0, self.cholesterol_AnimateView.frame.size.height/2+5, self.cholesterol_AnimateView.frame.size.width, 21) Font:PAGESIZE(13) Text:@"99％"];
    animateView4Label.textColor=CREATECOLOR(254, 2, 0, 1);
    animateView4Label.textAlignment=NSTextAlignmentCenter;
    [self.cholesterol_AnimateView addSubview:animateView4Label];
    
    //加个手势
    self.cholesterol_AnimateView.tag=3000+4;
    self.cholesterol_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.cholesterol_AnimateView addGestureRecognizer:tap4];
    
    
    //尿酸
    self.uric_acidAnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.uric_acidAnimateView setPrecent:99 description:@"尿酸" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.uric_acidAnimateView];
    self.uric_acidAnimateView.center=CGPointMake(self.hdlc_AnimateView.center.x+PAGESIZE(84), self.hdlc_AnimateView.center.y+PAGESIZE(120));
    CGRect view5ToFrame=self.uric_acidAnimateView.frame;
    self.uric_acidAnimateView.center=self.hdlc_AnimateView.center;
    [self showPopWithPopButton:self.uric_acidAnimateView showPosition:view5ToFrame];
    
    //加个手势
    self.uric_acidAnimateView.tag=3000+5;
    self.uric_acidAnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.uric_acidAnimateView addGestureRecognizer:tap5];
    
    
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
-(void)removeThirdSXWaveView
{
    [self.triglycerin_AnimateView removeFromSuperview];
    [self.ldlc_AnimateView removeFromSuperview];
    [self.hdlc_AnimateView removeFromSuperview];
    [self.cholesterol_AnimateView removeFromSuperview];
    [self.uric_acidAnimateView removeFromSuperview];
}

//动画
-(void)animateSXWaveView
{
    [self.triglycerin_AnimateView addAnimateWithType:0];
    [self.ldlc_AnimateView addAnimateWithType:0];
    [self.hdlc_AnimateView addAnimateWithType:0];
    [self.cholesterol_AnimateView addAnimateWithType:0];
    [self.uric_acidAnimateView addAnimateWithType:0];
}

//进入单项监测
-(void)tapGestureAction:(UITapGestureRecognizer*)tap
{
    NSString * str;
    switch (tap.view.tag-3000) {
        case 1:
            str=@"甘油三酯";
            break;
        case 2:
            str=@"低密度脂蛋白胆固醇";
            break;
        case 3:
            str=@"高密度脂蛋白胆固醇";
            break;
        case 4:
            str=@"总胆固醇";
            break;
        case 5:
            str=@"尿酸";
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
