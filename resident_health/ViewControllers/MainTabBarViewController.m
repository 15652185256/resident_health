//
//  MainTabBarViewController.m
//  HealthManager
//
//  Created by mac on 15-8-31.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "FullScreenViewController.h"//自定义导航

#import "InformationViewController.h"
#import "ToolsViewController.h"
#import "MonitorViewController.h"
#import "SiteViewController.h"
#import "PersonalViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViewContollers];
    
    //创建item
    [self createTabBarItem];
    
}

-(void)createViewContollers
{
    
    //创建资讯
    InformationViewController * vc1=[[InformationViewController alloc]init];
    FullScreenViewController * nc1=[[FullScreenViewController alloc]initWithRootViewController:vc1];
    
    //创建工具
    ToolsViewController * vc2=[[ToolsViewController alloc]init];
    FullScreenViewController * nc2=[[FullScreenViewController alloc]initWithRootViewController:vc2];
    
    //创建健康管理
    MonitorViewController * vc3=[[MonitorViewController alloc]init];
    FullScreenViewController * nc3=[[FullScreenViewController alloc]initWithRootViewController:vc3];
    
    //创建场馆
    SiteViewController * vc4=[[SiteViewController alloc]init];
    FullScreenViewController * nc4=[[FullScreenViewController alloc]initWithRootViewController:vc4];
    
    //创建我的
    PersonalViewController * vc5=[[PersonalViewController alloc]init];
    FullScreenViewController * nc5=[[FullScreenViewController alloc]initWithRootViewController:vc5];
    
    self.viewControllers=@[nc1,nc2,nc3,nc4,nc5];
    
    
}

-(void)createTabBarItem
{
    NSArray * titileArray=@[@"资讯",@"工具",@"",@"场馆",@"我的"];
    
    NSArray * SelectArray=@[@"tabbar_information@2x.png",@"tabbar_tool@2x.png",@"tabbar_health_monitoring@2x.png",@"tabbar_venues@2x.png",@"tabbar_user@2x.png"];
    
    NSArray * unSelectArray=@[@"un_tabbar_information@2x.png",@"un_tabbar_tool@2x.png",@"tabbar_health_monitoring@2x.png",@"un_tabbar_venues@2x.png",@"un_tabbar_user@2x.png"];
    
    for (int i=0; i<titileArray.count; i++)
    {
        //读取itme
        UITabBarItem * item=self.tabBar.items[i];
        //bar 使用图片需要经过处理才可以使用，否则是阴影
        UIImage * selectImage=[UIImage imageNamed:SelectArray[i]];
        selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * unSelectImage=[UIImage imageNamed:unSelectArray[i]];
        unSelectImage=[unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item=[item initWithTitle:titileArray[i] image:unSelectImage selectedImage:selectImage];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(152, 153, 154, 1)} forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(119, 142, 28, 1)} forState:UIControlStateSelected];
        
        if (i==2) {
            [item setImageInsets:UIEdgeInsetsMake(-4, 0, 4, 0)];
        }
    }
    
    
    //去掉tabBarController里的边框黑线
    CGRect rect = CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    
    //设置tabbar背景色
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg@2x.jpg"]];
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
