//
//  MonitorViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "MonitorViewController.h"
//健康监测 第一个页面
#import "FristMonitorViewController.h"
//健康监测 第二个页面
#import "SecondMonitorViewController.h"
//健康监测 第三个页面
#import "ThirdMonitorViewController.h"
//系统消息
#import "PersonalNewsListViewController.h"

#import "MonitorListViewController.h"//单项监测

@interface MonitorViewController ()<UIScrollViewDelegate>
{
    int _ViewPage;//页脚
}
@property(nonatomic,retain)UIScrollView * rootScrollView;

@property(nonatomic,retain)FristMonitorViewController * fmvc;

@property(nonatomic,retain)SecondMonitorViewController * smvc;

@property(nonatomic,retain)ThirdMonitorViewController * tmvc;

@end

@implementation MonitorViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ViewPage=0;
    
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
    self.navigationItem.title = @"健康监测";
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
    //设置刷新按钮
    UIButton * refreshButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 38, 36) Text:nil ImageName:@"nav_refresh@2x.png" bgImageName:nil Target:self Method:@selector(refreshButtonClick)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:refreshButton];
    
    //设置信息按钮
    UIButton * newsButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 38, 36) Text:nil ImageName:@"nav_new@2x.png" bgImageName:nil Target:self Method:@selector(newsButtonClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:newsButton];
    
}

//刷新
-(void)refreshButtonClick
{
    switch (_ViewPage) {
        case 0:
            [_fmvc createFristSXWaveView];
            break;
        case 1:
            [_smvc createSecondSXWaveView];
            break;
        case 2:
            [_tmvc createThirdSXWaveView];
            break;
        default:
            break;
    }
    
}

//信息按钮跳转
-(void)newsButtonClick
{
    //系统消息
    PersonalNewsListViewController * pvc=[[PersonalNewsListViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pvc animated:YES];
}

#pragma mark 设置页面
-(void)createView
{
    //主视图
    _rootScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:_rootScrollView];
    MonitorViewController * vc = self;
    
    MonitorListViewController * _mvc=[[MonitorListViewController alloc]init];
    
    _fmvc=[[FristMonitorViewController alloc]init];
    _fmvc.myBlock=^(NSString * title){
        _mvc.navTitle=title;
        _mvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:_mvc animated:YES];
    };
    
    _smvc=[[SecondMonitorViewController alloc]init];
    _smvc.myBlock=^(NSString * title){
        _mvc.navTitle=title;
        _mvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:_mvc animated:YES];
    };
    
    _tmvc=[[ThirdMonitorViewController alloc]init];
    _tmvc.myBlock=^(NSString * title){
        _mvc.navTitle=title;
        _mvc.hidesBottomBarWhenPushed=YES;
        [vc.navigationController pushViewController:_mvc animated:YES];
    };
    
    _fmvc.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    [_rootScrollView addSubview:_fmvc.view];
    
    _smvc.view.frame=CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
    [_rootScrollView addSubview:_smvc.view];
    
    _tmvc.view.frame=CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT);
    [_rootScrollView addSubview:_tmvc.view];
    
    
    _rootScrollView.contentSize=CGSizeMake(WIDTH*3, 0);
    //设置允许翻页
    _rootScrollView.pagingEnabled=YES;
    //设置代理
    _rootScrollView.delegate=self;
    
    //禁用滚动条,防止缩放还原时崩溃
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.bounces = NO;
}

//代理相应
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_fmvc removeFristSXWaveView];
    [_smvc removeSecondSXWaveView];
    [_tmvc removeThirdSXWaveView];
    
    //更改页码
    int index=scrollView.contentOffset.x/WIDTH;
    
    _ViewPage=index;
    
    if (index==0) {
        [_fmvc createFristSXWaveView];
    }
    else if(index==1){
        [_smvc createSecondSXWaveView];
    }
    else if(index==2){
        [_tmvc createThirdSXWaveView];
    }
}


#pragma mark 进入单项监测




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
