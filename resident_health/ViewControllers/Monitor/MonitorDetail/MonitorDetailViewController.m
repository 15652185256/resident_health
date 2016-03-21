//
//  MonitorDetailViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/17.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "MonitorDetailViewController.h"


#import "UUChart.h"//折线图
@interface MonitorDetailViewController ()<UUChartDataSource>
{
    UUChart * chartView;
    
    NSIndexPath * path;
}
@end

@implementation MonitorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置导航
    [self createNav];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置页面
    [self createView];
}

#pragma mark 设置导航
-(void)createNav
{
    UIView * navView=[ZCControl createView:CGRectMake(0, 0, HEIGHT, 46)];
    [self.view addSubview:navView];
    navView.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(15, (44-18)/2, 100, 18) Text:nil ImageName:@"reg_return@2x.png" bgImageName:nil Target:self Method:@selector(returnButtonClick)];
    [navView addSubview:returnButton];
    returnButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 100/10*8);
    
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, HEIGHT-30, 46) Font:18 Text:[NSString stringWithFormat:@"%@记录",self.navTitle]];
    [navView addSubview:titleLabel];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
}

//返回
-(void)returnButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark 设置页面
-(void)createView
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(16, 46+6, WIDTH-16, HEIGHT-60) withSource:self withStyle:UUChartLineStyle];
    [chartView showInView:self.view];
    
    
}

//强制横屏
-(BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

//名称
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray * xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return [self getXTitles:7];
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
    
    return @[ary1,ary2];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    return CGRangeMake(100, 0);
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    return CGRangeMake(25, 75);
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return 2;
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
