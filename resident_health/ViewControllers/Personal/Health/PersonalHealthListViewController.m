//
//  PersonalHealthListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/23.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "PersonalHealthListViewController.h"
#import "PersonalHealthModel.h"
#import "PersonalHealthDetialViewController.h"

@interface PersonalHealthListViewController ()
@property(nonatomic,retain)UIScrollView * rootScrollView;//信息列表
@property(nonatomic,retain)NSMutableArray * healthListArray;
@end

@implementation PersonalHealthListViewController

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
    
    //设置导航的标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(255, 255, 255, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationItem.title = @"健康档案";
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 10, 18) Text:nil ImageName:nil bgImageName:@"reg_return@2x.png" Target:self Method:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:returnButton];
    
}

//返回
-(void)returnButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 设置页面
-(void)createView
{
    //主视图
    _rootScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-46)];
    [self.view addSubview:_rootScrollView];
    
    //加载数据
    [self loadData];
    
    //健康档案
    [self createHealth];
}

#pragma mark 请求搜索数据
-(void)loadData
{
    _healthListArray = [[NSMutableArray alloc]init];
    
    NSArray * titleArray=@[@"一般检查",@"生活方式"];
    
    for (int i = 0; i< titleArray.count; i++) {
        NSString * string = titleArray[i];
        
        PersonalHealthModel * model = [[PersonalHealthModel alloc] init];
        model.title=string;
        
        [_healthListArray addObject:model];
    }
    
    
}

#pragma mark 健康档案
-(void)createHealth
{
    float HealthHeight=40;
    for (int i=0; i<_healthListArray.count; i++) {
        PersonalHealthModel * model = _healthListArray[i];
        
        
        UIButton * healthButton=[UIButton buttonWithType:UIButtonTypeCustom];
        healthButton.frame=CGRectMake(10, 20+(HealthHeight+10)*i, WIDTH-20, HealthHeight) ;
        [healthButton setTitle:model.title forState:UIControlStateNormal];
        [healthButton setTitleColor:CREATECOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
        healthButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_rootScrollView addSubview:healthButton];
        
        healthButton.tag=3000+i;
        [healthButton addTarget:self action:@selector(downHealthButton:) forControlEvents:UIControlEventTouchDown];
        [healthButton addTarget:self action:@selector(upHealthButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //上边线
        UIView * topView=[ZCControl createView:CGRectMake(0, 0, WIDTH-20, 0.5)];
        [healthButton addSubview:topView];
        topView.backgroundColor=CREATECOLOR(204, 204, 204, 1);
        
        //下变现
        UIView * bottomView=[ZCControl createView:CGRectMake(0, HealthHeight-0.5, WIDTH-20, 0.5)];
        [healthButton addSubview:bottomView];
        bottomView.backgroundColor=CREATECOLOR(204, 204, 204, 1);
        
        //左边线
        UIView * leftView=[ZCControl createView:CGRectMake(0, 0, 0.5, HealthHeight)];
        [healthButton addSubview:leftView];
        leftView.backgroundColor=CREATECOLOR(204, 204, 204, 1);
        
        //右边线
        UIView * rightView=[ZCControl createView:CGRectMake(WIDTH-20-0.5, 0, 0.5, HealthHeight)];
        [healthButton addSubview:rightView];
        rightView.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    }
    
    //设置滚动范围
    _rootScrollView.contentSize=CGSizeMake(0, HealthHeight*_healthListArray.count+20);
    //禁用滚动条,防止缩放还原时崩溃
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.bounces = NO;
}

-(void)downHealthButton:(UIButton*)button
{
    button.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    [button setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
}

-(void)upHealthButton:(UIButton*)button
{
    button.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    [button setTitleColor:CREATECOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    
    PersonalHealthDetialViewController * pvc=[[PersonalHealthDetialViewController alloc]init];
    pvc.navTitle=button.titleLabel.text;
    pvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pvc animated:YES];
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
