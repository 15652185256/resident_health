//
//  UserAgreementViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/10/13.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()

@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    [self createView];
}

-(void)createView
{
    //头部
    UIView * bgView=[ZCControl createView:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:bgView];
    bgView.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(15, 20+(44-18)/2, 100, 18) Text:nil ImageName:@"reg_return@2x" bgImageName:nil Target:self Method:@selector(returnButtonClick)];
    [self.view addSubview:returnButton];
    returnButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 100/10*8);
    
    //标题
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(0, 0, WIDTH, 21) Font:18 Text:@"用户协议"];
    [bgView addSubview:titleLabel];
    titleLabel.center=CGPointMake(WIDTH/2, 20+10+8);
    titleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    NSURL * url = [NSURL URLWithString:AgreementHttp];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    
    [self.view addSubview:webView];
}

#pragma mark 返回
-(void)returnButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
