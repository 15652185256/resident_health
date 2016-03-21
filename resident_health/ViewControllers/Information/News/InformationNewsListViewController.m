//
//  InformationNewsListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "InformationNewsListViewController.h"


#import "CycleScrollView.h"//轮播图

#import "InformationSearchListViewController.h"//搜索


#import "InformationNewsListModel.h"
#import "InformationNewsListViewModel.h"
#import "InformationNewsListTableViewCell.h"

#import "InformationNewsDetailViewController.h"//详情

//新闻列表数据
#import "InformationNewsListViewModel.h"

@interface InformationNewsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView * tableView;//新闻列表

@property(nonatomic,retain)NSMutableArray * newsListArray;//新闻列表数据
//头新闻数据
@property (strong, nonatomic) NSMutableArray * SearchFirstNewsListArray;

@end

@implementation InformationNewsListViewController

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
    self.navigationItem.title = self.navTitle;
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 10, 18) Text:nil ImageName:nil bgImageName:@"reg_return@2x.png" Target:self Method:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:returnButton];
    
    //设置搜索按钮
    UIButton * searchButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 36, 36) Text:nil ImageName:@"nav_search@2x.png" bgImageName:nil Target:self Method:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchButton];
}

//返回
-(void)returnButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//搜索 跳转
-(void)searchButtonClick
{
    InformationSearchListViewController * svc=[[InformationSearchListViewController alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}


#pragma mark 设置页面
-(void)createView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*0, 0, WIDTH, HEIGHT-64)];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[InformationNewsListTableViewCell class] forCellReuseIdentifier:@"ID"];
    
    //创建 头部轮播图
    [self createHeaderView];
    
    //加载数据
    [self loadData];
}


//创建 头部轮播图
-(void)createHeaderView
{
    //头部轮播图
    float headerViewHeight=111+30;
    
    CycleScrollView * headerView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, headerViewHeight) animationDuration:3 type:0];
    _tableView.tableHeaderView=headerView;
    

    NSMutableArray * imageViewsArray = [[NSMutableArray alloc]init];//滚动视图数组
    
    NSArray * imageNames = @[@"infor1",@"infor2",@"infor3",@"infor4",@"infor5"];
    NSArray * titlesArray= @[@"北美12家华文媒体考察“甘家口模式",@"海淀区副区长孟景伟视察甘家口智慧社区居民医疗养老健康指导中心",@"澳门妇女骨干研习班抵京首站调研医养康指导中心",@"医养康服务四社区联动出击 拉开秋冬送健康序幕",@"社区医院药品种类满意度最低"];
    
    
    for (int i=0; i<imageNames.count; i++) {
        //创建一个图片
        NSString * filePath = [[NSBundle mainBundle] pathForResource:imageNames[i] ofType:@"jpg"];
        //创建图片视图
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, headerViewHeight-30)];
        //加载图片
        imageView.image=[UIImage imageWithContentsOfFile:filePath];
        //将imageView加到滚动视图数组里
        [imageViewsArray addObject:imageView];
    }
    
    headerView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return imageViewsArray[pageIndex];
    };
    headerView.fetchTitleLabelAtIndex = ^UIView *(NSInteger pageIndex){
        return titlesArray[pageIndex];
    };
    headerView.totalPagesCount = ^NSInteger(void){
        return imageViewsArray.count;
    };
    headerView.TapActionBlock = ^(NSInteger pageIndex){
        //NSLog(@"点击了第%ld个",pageIndex);
        
        InformationNewsDetailViewController * nvc=[[InformationNewsDetailViewController alloc]init];
        nvc.navTitle=self.navTitle;
        nvc.newsTitle=titlesArray[pageIndex];
        nvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:nvc animated:YES];
    };
}



#pragma mark 请求搜索数据
-(void)loadData
{
    _newsListArray = [[NSMutableArray alloc]init];
    for (int i = 0; i< 10; i++) {
        NSString * string = [NSString stringWithFormat:@"第 %d 条数据",i+1];
        NSString * string1 = [NSString stringWithFormat:@"2015-9-16"];
        
        InformationNewsListModel * model = [[InformationNewsListModel alloc] init];
        model.title=string;
        model.date=string1;
        
        [_newsListArray addObject:model];
    }
    
    [_tableView reloadData];
}

#pragma mark 创建搜索列表
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsListArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationNewsListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    InformationNewsListModel * model=_newsListArray[indexPath.row];
    
    [cell configModel:model];
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationNewsListModel * model=_newsListArray[indexPath.row];
    
    InformationNewsDetailViewController * nvc=[[InformationNewsDetailViewController alloc]init];
    nvc.navTitle=self.navTitle;
    nvc.newsTitle=model.title;
    nvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nvc animated:YES];
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
