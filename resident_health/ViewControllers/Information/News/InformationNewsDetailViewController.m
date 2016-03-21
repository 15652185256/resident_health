//
//  InformationNewsDetailViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/10/8.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "InformationNewsDetailViewController.h"

@interface InformationNewsDetailViewController ()

@end

@implementation InformationNewsDetailViewController

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
    //标题
    UILabel * titlelabel=[ZCControl createLabelWithFrame:CGRectMake(15, 20, WIDTH-30, 20) Font:20 Text:self.newsTitle];
    [self.view addSubview:titlelabel];
    titlelabel.textColor=CREATECOLOR(51, 51, 51, 1);
    titlelabel.font=[UIFont boldSystemFontOfSize:20];
    
    //发布时间
    UILabel * postTimeLabel=[ZCControl createLabelWithFrame:CGRectMake(15, CGRectGetMaxY(titlelabel.frame)+10, 100, 14) Font:14 Text:@"2015-09-24"];
    [self.view addSubview:postTimeLabel];
    postTimeLabel.textColor=CREATECOLOR(103, 103, 103, 1);
    
    //发布人
    UILabel * authorLabel=[ZCControl createLabelWithFrame:CGRectMake(15+100, CGRectGetMaxY(titlelabel.frame)+10, 100, 14) Font:14 Text:@"福禄全书"];
    [self.view addSubview:authorLabel];
    authorLabel.textColor=CREATECOLOR(103, 103, 103, 1);
    
    //分割线
    UIView * lineView=[ZCControl createView:CGRectMake(15, CGRectGetMaxY(authorLabel.frame)+15, WIDTH-30, 0.5)];
    [self.view addSubview:lineView];
    lineView.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    
    
    //内容
    MyUILabel * contentLabel=[ZCControl createMyLabelWithFrame:CGRectMake(15, CGRectGetMaxY(lineView.frame)+15, WIDTH-30, 40) Font:14 Text:nil];
    [self.view addSubview:contentLabel];
    contentLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    //置顶
    [contentLabel setVerticalAlignment:VerticalAlignmentTop];
    
    contentLabel.numberOfLines=0;
    
    NSString * labelText=@"记者了解到，海淀区中医专科医联体是北京市第二个中医专科医联体。医联体成立后，西苑医院将按照各成员医疗机构的具体需求，选择部分科室与成员医疗机构分别形成一对一的帮扶关系，通过专家出诊、查房、病例讨论等方式，提高成员医疗机构的诊疗水平。医联体内还将以患者自愿、医保政策允许、连续服务、健康管理等为原则，在医联体内部建立转诊病人绿色通道，制定双向转诊的流程，使患者在医联体内合理流动。医联体还将建立影像诊断中心，开展放射检查远程会诊。今后，西苑医院还将在信息化完善的基础上，实现与医联体内成员间的预约挂号、转诊、会诊信息统计、患者医疗健康信息共享等。这意味着，今后，更多的海淀区患者可以在家门口的社区卫生服务中心看上西苑医院的专家；如果病情需要，有望通过社区医疗机构转诊到西苑医院。";
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    contentLabel.attributedText = attributedString;
    
    [contentLabel sizeToFit];
    
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
