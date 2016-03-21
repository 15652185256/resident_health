//
//  SiteAddressDetailViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/30.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "SiteAddressDetailViewController.h"
#import "CycleScrollView.h"//轮播图

#import "SiteAddressMapViewController.h"//地图

@interface SiteAddressDetailViewController ()
//主视图
@property(nonatomic,retain)UIScrollView * rootScrollView;

@end


@implementation SiteAddressDetailViewController

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
    
}

//返回
-(void)returnButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 设置页面
-(void)createView
{
    _rootScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [self.view addSubview:_rootScrollView];
    
    //头部轮播图
    float headerViewHeight=PAGESIZE(182);
    [self createHeaderView:headerViewHeight];
    
    
    //地址背景
    UIView * bgAddressView=[ZCControl createView:CGRectMake(10, headerViewHeight+20, WIDTH-20, 56)];
    [_rootScrollView addSubview:bgAddressView];
    bgAddressView.backgroundColor=CREATECOLOR(122, 128, 137, 1);
    
    //图标
    UIImageView * iconImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 11, 16) ImageName:@"site_address_white@2x"];
    [bgAddressView addSubview:iconImageView];
    
    //地址
    UILabel * addressLabel=[ZCControl createLabelWithFrame:CGRectMake(10+11+6, 10, bgAddressView.frame.size.width-10-11-6-10, 14) Font:14 Text:self.content];
    [bgAddressView addSubview:addressLabel];
    addressLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    
    //距离
    UILabel * distanceLabel=[ZCControl createLabelWithFrame:CGRectMake(10+11+6, 10+14+8, bgAddressView.frame.size.width-10-11-6-10, 14) Font:14 Text:@"据您1690米"];
    [bgAddressView addSubview:distanceLabel];
    distanceLabel.textColor=CREATECOLOR(162, 197, 28, 1);
    
    
    
    //看全景
    UIButton * seeButton=[ZCControl createButtonWithFrame:CGRectMake(10, CGRectGetMaxY(bgAddressView.frame)+2, (WIDTH-20-2)/2, 40) Text:@"看全景" ImageName:nil bgImageName:nil Target:self Method:@selector(seeButtonClick)];
    [_rootScrollView addSubview:seeButton];
    seeButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [seeButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    seeButton.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    //到这去
    UIButton * gotoButton=[ZCControl createButtonWithFrame:CGRectMake(CGRectGetMaxX(seeButton.frame)+2, CGRectGetMaxY(bgAddressView.frame)+2, (WIDTH-20-2)/2, 40) Text:@"到这去" ImageName:nil bgImageName:nil Target:self Method:@selector(gotoButtonClick)];
    [_rootScrollView addSubview:gotoButton];
    gotoButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [gotoButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    gotoButton.backgroundColor=CREATECOLOR(122, 128, 137, 1);
    
    
    
    //场馆介绍
    UILabel * contentTitleLabel=[ZCControl createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(gotoButton.frame)+24, WIDTH-20, 17) Font:17 Text:@"场馆介绍"];
    [_rootScrollView addSubview:contentTitleLabel];
    contentTitleLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    
    
    //分割线
    UIView * lineView=[ZCControl createView:CGRectMake(10, CGRectGetMaxY(contentTitleLabel.frame)+14, WIDTH-20, 0.5)];
    [_rootScrollView addSubview:lineView];
    lineView.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    
    
    //介绍
    MyUILabel * contentLabel=[ZCControl createMyLabelWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame)+14, WIDTH-20, 40) Font:14 Text:nil];
    [_rootScrollView addSubview:contentLabel];
    contentLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    contentLabel.numberOfLines=0;
    
    //置顶
    [contentLabel setVerticalAlignment:VerticalAlignmentTop];
    
    NSString * labelText=self.content;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    contentLabel.attributedText = attributedString;
    
    [contentLabel sizeToFit];
    
    
    
    
    
    //设置滚动范围
    float rootScrollViewHeight=headerViewHeight+20+56+2+40+24+17+29+contentLabel.frame.size.height;
    
    if (rootScrollViewHeight<HEIGHT-64) {
        rootScrollViewHeight=HEIGHT-64;
    }
    
    _rootScrollView.contentSize=CGSizeMake(0, rootScrollViewHeight+100);
    //禁用滚动条,防止缩放还原时崩溃
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.bounces = NO;
}



#pragma mark 头部轮播图
-(void)createHeaderView:(float)headerViewHeight
{
   
    NSMutableArray * imageViewsArray = [[NSMutableArray alloc]init];//滚动视图数组
    
    CycleScrollView * headerView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, headerViewHeight) animationDuration:3 type:1];
    [_rootScrollView addSubview:headerView];
    
    NSArray * imageNames = @[@"infor4.jpg",@"infor6.jpg",@"infor3.jpg",@"infor4.jpg",@"infor7.jpg"];
    
    for (int i=0; i<imageNames.count; i++) {
        
        //创建一个图片
        UIImage * image = [UIImage imageNamed:imageNames[i]];
        //创建图片视图
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, headerViewHeight)];
        imageView.image = image;
        //将imageView加到滚动视图数组里
        [imageViewsArray addObject:imageView];
    }
    
    headerView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return imageViewsArray[pageIndex];
    };
    headerView.fetchTitleLabelAtIndex = ^UIView *(NSInteger pageIndex){
        return imageNames[pageIndex];
    };
    headerView.totalPagesCount = ^NSInteger(void){
        return imageViewsArray.count;
    };
    headerView.TapActionBlock = ^(NSInteger pageIndex){
        //NSLog(@"点击了第%ld个",pageIndex);
    };

}

#pragma mark 看全景
-(void)seeButtonClick
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://map.qq.com/#pano=10011013120328111339700&heading=279&pitch=20&zoom=1"]];
}

#pragma mark 到这去
-(void)gotoButtonClick
{
    //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://ditu.amap.com/"]];
    SiteAddressMapViewController * svc=[[SiteAddressMapViewController alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
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
