//
//  ToolsViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "ToolsViewController.h"
//腰臀比
#import "ToolsWhrListViewController.h"
//体重指数
#import "ToolsBmiListViewController.h"
//基础代谢
#import "ToolsBmrListViewController.h"
//标准体重
#import "ToolsBodyWeightListViewController.h"

@interface ToolsViewController ()<UITableViewDataSource,UITableViewDelegate>
//主视图
@property(nonatomic,retain)UITableView * tableView;
//标题
@property(nonatomic,retain)NSMutableArray * titleArray;
//图标
@property(nonatomic,retain)NSMutableArray * imageArray;
@end

@implementation ToolsViewController

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
    
    //设置导航的标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(255, 255, 255, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationItem.title = @"应用";
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
}


#pragma mark 设置页面
-(void)createView
{
    //主视图
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    [_tableView setSeparatorColor:CREATECOLOR(227, 227, 227, 1)];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //创建头部
    [self createHeaderView];
    
    //加载数据
    [self loadData];
}

//创建头部
-(void)createHeaderView
{
    UIView * bgView=[ZCControl createView:CGRectMake(0, 0, WIDTH, PAGESIZE(20)+PAGESIZE(116)+PAGESIZE(20))];
    bgView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    _tableView.tableHeaderView=bgView;
    
    //头部背景
    UIImageView * bgHeaderImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, PAGESIZE(20), WIDTH, PAGESIZE(116)) ImageName:@"tools_index_header_bg@2x"];
    [bgView addSubview:bgHeaderImageView];
}

#pragma mark 加载数据
-(void)loadData
{
    
    _titleArray=[NSMutableArray arrayWithObjects:@"腰臀比",@"体重指数",@"基础代谢",@"标准体重",nil];
    
    _imageArray=[NSMutableArray arrayWithObjects:@"tools_whr@2x",@"tools_bmi@2x",@"tools_ bmr@2x",@"tools_body_weight@2x", nil];
    
    [_tableView reloadData];
}

#pragma mark 创建搜索列表

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //图标
    UIImageView * imageView=[ZCControl createImageViewWithFrame:CGRectMake(15, 10, 21, 21) ImageName:_imageArray[indexPath.row]];
    [cell.contentView addSubview:imageView];
    
    //标题
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(15+21+7, 0, WIDTH-15-21-10-10, 40) Font:15 Text:_titleArray[indexPath.row]];
    [cell.contentView addSubview:titleLabel];
    titleLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    
    //右箭头
    UIImageView * arrowImageView=[ZCControl createImageViewWithFrame:CGRectMake(WIDTH-10-7, (40-12)/2, 7, 12) ImageName:@"personal_arrow@2x"];
    [cell.contentView addSubview:arrowImageView];
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


#pragma mark 应用管理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //腰臀比
            ToolsWhrListViewController * tvc=[[ToolsWhrListViewController alloc]init];
            tvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;
        case 1:
        {
            //体重指数
            ToolsBmiListViewController * tvc=[[ToolsBmiListViewController alloc]init];
            tvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;

        case 2:
        {
            //基础代谢
            ToolsBmrListViewController * tvc=[[ToolsBmrListViewController alloc]init];
            tvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;

        case 3:
        {
            //标准体重
            ToolsBodyWeightListViewController * tvc=[[ToolsBodyWeightListViewController alloc]init];
            tvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;

        default:
            break;
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
