//
//  MonitorListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/7.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "MonitorListViewController.h"

#import "MonitorDetailViewController.h"//详情页

#import "NIDropDown.h"//下拉列表


//单项指标
#import "MonitorListModel.h"
#import "MonitorListTableViewCell.h"

@interface MonitorListViewController ()<NIDropDownDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NIDropDown * dropDown;
}
@property(nonatomic,retain)UITableView * tableView;//新闻列表

@property(nonatomic,retain)NSMutableArray * monitorListArray;
@end

@implementation MonitorListViewController

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
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
    //设置导航的标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(255, 255, 255, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationItem.title = [NSString stringWithFormat:@"%@记录",self.navTitle];
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 10, 18) Text:nil ImageName:nil bgImageName:@"reg_return@2x.png" Target:self Method:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:returnButton];
    
    //设置 监测详情 按钮
    UIButton * searchButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 36, 36) Text:nil ImageName:@"nav_MonitorList@2x" bgImageName:nil Target:self Method:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchButton];
}

//返回
-(void)returnButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//监测详情 跳转
-(void)searchButtonClick
{
    MonitorDetailViewController * mvc=[[MonitorDetailViewController alloc]init];
    mvc.navTitle=self.navTitle;
    [self presentViewController:mvc animated:YES completion:nil];
}


#pragma mark 设置页面
-(void)createView
{
    //设置头视图
    [self createTopView];
    
    //创建列表
    [self createTableView];
}


//设置头视图（时间选择）
-(void)createTopView
{
    //年份
    NSDateFormatter * nianDateFormatter = [[NSDateFormatter alloc]init];
    [nianDateFormatter setDateFormat:@"yyyy"];
    NSDate * nianDate = [NSDate date];
    NSString * nianDateString = [[nianDateFormatter stringFromDate:nianDate] stringByAppendingString:@" 年"];
    
    //年份按钮
    UIButton * yearButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, WIDTH/2-0.5, 40) Text:nianDateString ImageName:nil bgImageName:@"buddy_header_bg" Target:self Method:@selector(yearButtonClick:)];
    [self.view addSubview:yearButton];
    [yearButton setTitleColor:CREATECOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    yearButton.titleLabel.font=[UIFont systemFontOfSize:16];
    yearButton.tag=3001;
    
    //下剪头
    UIImageView * yearArrowView=[ZCControl createImageViewWithFrame:CGRectMake(WIDTH/2-0.5-50, (40-6)/2, 11, 6) ImageName:@"icon_arrow_b"];
    [yearButton addSubview:yearArrowView];
    
    //分割线
    UIView * lineView=[ZCControl createView:CGRectMake(WIDTH/2-0.5, 0, 1, 40)];
    [yearButton addSubview:lineView];
    lineView.backgroundColor=CREATECOLOR(232, 232, 232, 1);
    
    //月份
    NSDateFormatter * yueDateFormatter = [[NSDateFormatter alloc]init];
    [yueDateFormatter setDateFormat:@"MM"];
    NSDate * yueDate = [NSDate date];
    NSString * yueDateString = [[yueDateFormatter stringFromDate:yueDate] stringByAppendingString:@" 月"];
    
    //月份按钮
    UIButton * monthButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH/2+0.5, 0, WIDTH/2-0.5, 40) Text:yueDateString ImageName:nil bgImageName:@"buddy_header_bg" Target:self Method:@selector(monthButtonClick:)];
    [self.view addSubview:monthButton];
    [monthButton setTitleColor:CREATECOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    monthButton.titleLabel.font=[UIFont systemFontOfSize:16];
    monthButton.tag=3002;
    
    //下剪头
    UIImageView * monthArrowView=[ZCControl createImageViewWithFrame:CGRectMake(WIDTH/2-0.5-60, (40-6)/2, 11, 6) ImageName:@"icon_arrow_b"];
    [monthButton addSubview:monthArrowView];
    
    //    //点击取消
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    //    [self.view addGestureRecognizer:tap];
}

-(void)yearButtonClick:(UIButton*)button
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"2010 年", @"2011 年", @"2012 年", @"2013 年", @"2014 年", @"2015 年",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:button height:&f arr:arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:button];
        [self rel];
    }
}

-(void)monthButtonClick:(UIButton*)button
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"1 月", @"2 月", @"3 月", @"4 月", @"5 月", @"6 月",@"7 月", @"8 月", @"9 月", @"10 月", @"11 月", @"12 月",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:button height:&f arr:arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:button];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

//点击取消
//-(void)tapGestureAction:(UITapGestureRecognizer*)tap
//{
//    for (int i=3001; i<=3002; i++) {
//        UIButton * button=(UIButton*)[self.view viewWithTag:i];
//        [dropDown hideDropDown:button];
//        [self rel];
//    }
//}

//创建列表
-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-64-40) style:UITableViewStylePlain];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[MonitorListTableViewCell class] forCellReuseIdentifier:@"ID"];
    
}


#pragma mark 创建搜索列表
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _monitorListArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonitorListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    MonitorListModel * model=_monitorListArray[indexPath.row];
    
    [cell configModel:model tag:indexPath.row];
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
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
