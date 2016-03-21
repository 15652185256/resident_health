//
//  InformationHealthViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "InformationHealthViewController.h"
#import "CycleScrollView.h"//轮播图

//头部新闻
#import "SearchFirstViewModel.h"

//头新闻模型
#import "SearchFirstModel.h"

@interface InformationHealthViewController ()
//总视图
@property(nonatomic,retain)UIScrollView * rootScrollView;
//头新闻高度
@property(nonatomic,assign) float headerViewHeight;

@end

@implementation InformationHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //头新闻高度
    _headerViewHeight=111+30;
    
    //创建页面
    [self createView];
    
    //创建头部
    [self createSearchFristNews];
}

-(void)createView
{
    _rootScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-46)];
    [self.view addSubview:_rootScrollView];
    
    //分类按钮
    float bgViewWidth=WIDTH/3;
    
    NSArray * buttonImageNames = @[@"ji_bing_yu_fang@2x",@"fu_you_bao_jian@2x",@"lao_nian_bao_jian@2x",@"zhong_yi_zhong_yao@2x",@"jing_shen_wei_sheng@2x",@"kang_fu_hu_li@2x",@"jian_kang_sheng_huo@2x",@"jian_kang_shi_pin@2x"];
    
    NSArray * buttonTitles = @[@"疾病预防",@"妇幼保健",@"老年保健",@"中医中药",@"精神卫生",@"康复护理",@"健康生活",@"健康视频"];
    
    for (int i=0; i<buttonImageNames.count; i++) {
        UIView * bgView=[ZCControl createView:CGRectMake(bgViewWidth*(i%3), _headerViewHeight+bgViewWidth*(i/3), bgViewWidth, bgViewWidth)];
        [_rootScrollView addSubview:bgView];
        bgView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
        [bgView addGestureRecognizer:tap];
        bgView.tag=3000+i;
        
        //底线
        UIView * BottomView=[ZCControl createView:CGRectMake(0, bgViewWidth-0.5, bgViewWidth, 0.5)];
        [bgView addSubview:BottomView];
        BottomView.backgroundColor=CREATECOLOR(230, 230, 230, 1);
        
        //右边线
        if ((i+1)%3!=0) {
            UIView * RightView=[ZCControl createView:CGRectMake(bgViewWidth-0.5, 0, 0.5, bgViewWidth)];
            [bgView addSubview:RightView];
            RightView.backgroundColor=CREATECOLOR(230, 230, 230, 1);
        }
        
        //分类
        UIButton * button=[ZCControl createButtonWithFrame:CGRectMake((bgViewWidth-PAGESIZE(73))/2, PAGESIZE(17), PAGESIZE(73), PAGESIZE(73)) Text:nil ImageName:buttonImageNames[i] bgImageName:nil Target:self Method:@selector(buttonClick:)];
        button.tag=3000+i;
        [bgView addSubview:button];
        
        //标题
        UILabel * buttonLabel=[ZCControl createLabelWithFrame:CGRectMake(0, PAGESIZE(73)+PAGESIZE(10), PAGESIZE(73), 12) Font:12 Text:buttonTitles[i]];
        [button addSubview:buttonLabel];
        buttonLabel.textAlignment=NSTextAlignmentCenter;
        buttonLabel.textColor=CREATECOLOR(101, 101, 101, 1);
        buttonLabel.tag=button.tag+1000;
    }
    
    
    //设置滚动范围
    _rootScrollView.contentSize=CGSizeMake(0, _headerViewHeight+bgViewWidth*((buttonImageNames.count/3)+MIN(buttonImageNames.count%3, 1))+40 );
    //禁用滚动条,防止缩放还原时崩溃
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.bounces = NO;
}


//创建头新闻
-(void)createSearchFristNews
{
    CycleScrollView * headerView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _headerViewHeight) animationDuration:3 type:0];
    [_rootScrollView addSubview:headerView];
    
    NSMutableArray * imageViewsArray = [[NSMutableArray alloc]init];//滚动视图数组
    
    NSArray * imageNames = @[@"infor1",@"infor2",@"infor3",@"infor4",@"infor5"];
    NSArray * titlesArray= @[@"北美12家华文媒体考察“甘家口模式",@"海淀区副区长孟景伟视察甘家口智慧社区居民医疗养老健康指导中心",@"澳门妇女骨干研习班抵京首站调研医养康指导中心",@"医养康服务四社区联动出击 拉开秋冬送健康序幕",@"社区医院药品种类满意度最低"];

    
    for (int i=0; i<imageNames.count; i++) {
        //创建一个图片
        NSString * filePath = [[NSBundle mainBundle] pathForResource:imageNames[i] ofType:@"jpg"];
        //创建图片视图
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, _headerViewHeight-30)];
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
        
        if (self.newBlock) {
            self.newBlock(titlesArray[pageIndex]);
        }
    };
}

//点击跳转
-(void)buttonClick:(UIButton*)button
{
    UILabel * titleLabel=(UILabel*)[self.view viewWithTag:button.tag+1000];
    if (self.myBlock) {
        self.myBlock(titleLabel.text);
    }
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    UILabel * titleLabel=(UILabel*)[self.view viewWithTag:tap.view.tag+1000];
    if (self.myBlock) {
        self.myBlock(titleLabel.text);
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
