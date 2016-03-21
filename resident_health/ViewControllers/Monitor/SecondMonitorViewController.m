//
//  SecondMonitorViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "SecondMonitorViewController.h"
#import "SXWaveView.h"  //波浪加载
#import "SXHalfWaveView.h"

#import "POP.h"//pop动画
@interface SecondMonitorViewController ()

@property(nonatomic,retain)UIImageView * bgImageView;

@property(nonatomic,retain)SXWaveView * waist_line_AnimateView;
@property(nonatomic,retain)SXWaveView * bmi_AnimateView;
@property(nonatomic,retain)SXWaveView * animateView3;
@property(nonatomic,retain)SXWaveView * hbalc_AnimateView;
@property(nonatomic,retain)SXWaveView * animateView5;
@property(nonatomic,retain)SXWaveView * temp_AnimateView;
@property(nonatomic,retain)SXWaveView * body_height_AnimateView;



@end

@implementation SecondMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置页面
    [self createView];
}

#pragma mark 设置页面
-(void)createView
{
    _bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-46-64) ImageName:@"hm_bg_2@2x"];
    [self.view addSubview:_bgImageView];
}

//创建图标
-(void)createSecondSXWaveView
{
    [self removeSecondSXWaveView];
    
    
    //糖化血红蛋白
    self.hbalc_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(134), PAGESIZE(134))];
    [self.hbalc_AnimateView setPrecent:99 description:@"糖化血红蛋白" descText:@"185/95 mmhg" descType:2 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(254, 2, 0, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    self.hbalc_AnimateView.center=CGPointMake(_bgImageView.center.x+25, HEIGHT/2-64+4);
    [_bgImageView addSubview:self.hbalc_AnimateView];
    
    //加个手势
    self.hbalc_AnimateView.tag=3000+4;
    self.hbalc_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.hbalc_AnimateView addGestureRecognizer:tap4];
    
    
    //腰围
    self.waist_line_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(90), PAGESIZE(90))];
    [self.waist_line_AnimateView setPrecent:99 description:@"腰围" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.waist_line_AnimateView];
    self.waist_line_AnimateView.center=CGPointMake(self.hbalc_AnimateView.center.x-PAGESIZE(95), self.hbalc_AnimateView.center.y-PAGESIZE(129));
    CGRect view1ToFrame=self.waist_line_AnimateView.frame;
    self.waist_line_AnimateView.center=self.hbalc_AnimateView.center;
    [self showPopWithPopButton:self.waist_line_AnimateView showPosition:view1ToFrame];
    
    //加个手势
    self.waist_line_AnimateView.tag=3000+1;
    self.waist_line_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.waist_line_AnimateView addGestureRecognizer:tap1];
    
    
    //体重指数
    self.bmi_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(118), PAGESIZE(118))];
    [self.bmi_AnimateView setPrecent:99 description:@"体重指数" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.bmi_AnimateView];
    self.bmi_AnimateView.center=CGPointMake(self.hbalc_AnimateView.center.x+PAGESIZE(45), self.hbalc_AnimateView.center.y-PAGESIZE(147));
    CGRect view2ToFrame=self.bmi_AnimateView.frame;
    self.bmi_AnimateView.center=self.hbalc_AnimateView.center;
    [self showPopWithPopButton:self.bmi_AnimateView showPosition:view2ToFrame];
    
    //加个手势
    self.bmi_AnimateView.tag=3000+2;
    self.bmi_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.bmi_AnimateView addGestureRecognizer:tap2];
    
    
    //臀围
    self.animateView3 = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.animateView3 setPrecent:99 description:@"臀围" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.animateView3];
    self.animateView3.center=CGPointMake(self.hbalc_AnimateView.center.x-PAGESIZE(140), self.hbalc_AnimateView.center.y-PAGESIZE(12));
    CGRect view3ToFrame=self.animateView3.frame;
    self.animateView3.center=self.hbalc_AnimateView.center;
    [self showPopWithPopButton:self.animateView3 showPosition:view3ToFrame];
    
    //加个手势
    self.animateView3.tag=3000+3;
    self.animateView3.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.animateView3 addGestureRecognizer:tap3];
    
    
    //腰臀比
    self.animateView5 = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.animateView5 setPrecent:99 description:@"腰臀比" descText:nil descType:2 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.animateView5];
    self.animateView5.center=CGPointMake(self.hbalc_AnimateView.center.x-PAGESIZE(120), self.hbalc_AnimateView.center.y+PAGESIZE(112));
    CGRect view5ToFrame=self.animateView5.frame;
    self.animateView5.center=self.hbalc_AnimateView.center;
    [self showPopWithPopButton:self.animateView5 showPosition:view5ToFrame];
    
    UILabel * animateView3Label=[ZCControl createLabelWithFrame:CGRectMake(0, self.animateView5.frame.size.height/2+5, self.animateView5.frame.size.width, 21) Font:PAGESIZE(13) Text:@"99％"];
    animateView3Label.textColor=CREATECOLOR(254, 2, 0, 1);
    animateView3Label.textAlignment=NSTextAlignmentCenter;
    [self.animateView5 addSubview:animateView3Label];
    
    //加个手势
    self.animateView5.tag=3000+5;
    self.animateView5.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.animateView5 addGestureRecognizer:tap5];
    
    
    //体温
    self.temp_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(90), PAGESIZE(90))];
    [self.temp_AnimateView setPrecent:99 description:@"体温" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.temp_AnimateView];
    self.temp_AnimateView.center=CGPointMake(self.hbalc_AnimateView.center.x-PAGESIZE(12), self.hbalc_AnimateView.center.y+PAGESIZE(150));
    CGRect view6ToFrame=self.temp_AnimateView.frame;
    self.temp_AnimateView.center=self.hbalc_AnimateView.center;
    [self showPopWithPopButton:self.temp_AnimateView showPosition:view6ToFrame];
    
    //加个手势
    self.temp_AnimateView.tag=3000+6;
    self.temp_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.temp_AnimateView addGestureRecognizer:tap6];
    
    
    //身高
    self.body_height_AnimateView = [[SXWaveView alloc]initWithFrame:CGRectMake(0, 0, PAGESIZE(100), PAGESIZE(100))];
    [self.body_height_AnimateView setPrecent:99 description:@"身高" descText:nil descType:1 textColor:CREATECOLOR(51, 51, 51, 1) DescTextColor:CREATECOLOR(51, 51, 51, 1) bgColor:CREATECOLOR(255, 255, 255, 0.5) alpha:0.5 clips:YES];
    [_bgImageView addSubview:self.body_height_AnimateView];
    self.body_height_AnimateView.center=CGPointMake(self.hbalc_AnimateView.center.x+PAGESIZE(95), self.hbalc_AnimateView.center.y+PAGESIZE(107));
    CGRect view7ToFrame=self.body_height_AnimateView.frame;
    self.body_height_AnimateView.center=self.hbalc_AnimateView.center;
    [self showPopWithPopButton:self.body_height_AnimateView showPosition:view7ToFrame];
    
    //加个手势
    self.body_height_AnimateView.tag=3000+7;
    self.body_height_AnimateView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.body_height_AnimateView addGestureRecognizer:tap7];
    
    
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
-(void)removeSecondSXWaveView
{
    [self.waist_line_AnimateView removeFromSuperview];
    [self.bmi_AnimateView removeFromSuperview];
    [self.animateView3 removeFromSuperview];
    [self.hbalc_AnimateView removeFromSuperview];
    [self.animateView5 removeFromSuperview];
    [self.temp_AnimateView removeFromSuperview];
    [self.body_height_AnimateView removeFromSuperview];
}

//动画
-(void)animateSXWaveView
{
    [self.waist_line_AnimateView addAnimateWithType:0];
    [self.bmi_AnimateView addAnimateWithType:0];
    [self.animateView3 addAnimateWithType:0];
    [self.hbalc_AnimateView addAnimateWithType:0];
    [self.animateView5 addAnimateWithType:0];
    [self.temp_AnimateView addAnimateWithType:0];
    [self.body_height_AnimateView addAnimateWithType:0];
}

//进入单项监测
-(void)tapGestureAction:(UITapGestureRecognizer*)tap
{
    NSString * str;
    switch (tap.view.tag-3000) {
        case 1:
            str=@"腰围";
            break;
        case 2:
            str=@"体重指数";
            break;
        case 3:
            str=@"臀围";
            break;
        case 4:
            str=@"糖化血红蛋白";
            break;
        case 5:
            str=@"腰臀比";
            break;
        case 6:
            str=@"体温";
            break;
        case 7:
            str=@"身高";
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
