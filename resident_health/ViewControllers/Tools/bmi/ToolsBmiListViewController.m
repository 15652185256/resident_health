//
//  ToolsBmiListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/29.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ToolsBmiListViewController.h"

//键盘移动
#import "CDPMonitorKeyboard.h"
//计算结果
#import "ToolsBmiDeatailViewController.h"

@interface ToolsBmiListViewController ()<UITextFieldDelegate>
//主视图
@property(nonatomic,retain)UIScrollView * rootScrollView;
//身高
@property(nonatomic,retain)UITextField * heightField;
//身高单位
@property(nonatomic,retain)UILabel * heightUnitLabel;
//体重
@property(nonatomic,retain)UITextField * weightField;
//体重单位
@property(nonatomic,retain)UILabel * weightUnitLabel;
@end

@implementation ToolsBmiListViewController

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
    self.navigationItem.title = @"体重指数";
    
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
    _rootScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [self.view addSubview:_rootScrollView];
    _rootScrollView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    float headerHeight=PAGESIZE(107);
    
    //头部背景
    UIImageView * bgHeaderImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, headerHeight) ImageName:@"tools_bmi_header_bg@2x"];
    [_rootScrollView addSubview:bgHeaderImageView];
    
    
    //身高
    UIImageView * heightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _heightField=[ZCControl createTextFieldWithFrame:CGRectMake(0, headerHeight+PAGESIZE(22), WIDTH, PAGESIZE(46)) placeholder:@"请输入身高" passWord:NO leftImageView:heightImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _heightField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg"]];
    }
    else{
        _heightField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s"]];
    }
    _heightField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_heightField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_rootScrollView addSubview:_heightField];
    _heightField.delegate=self;
    
    //身高单位
    _heightUnitLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-110, 0, 90, PAGESIZE(44)) Font:PAGESIZE(17) Text:@"厘米 (cm)"];
    _heightUnitLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [_heightField addSubview:_heightUnitLabel];
    _heightUnitLabel.textAlignment=NSTextAlignmentRight;
    
    
    //体重
    UIImageView * weightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _weightField=[ZCControl createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(_heightField.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"请输入体重" passWord:NO leftImageView:weightImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _weightField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg"]];
    }
    else{
        _weightField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s"]];
    }
    _weightField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_weightField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_rootScrollView addSubview:_weightField];
    _weightField.delegate=self;
    
    //体重单位
    _weightUnitLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-110, 0, 90, PAGESIZE(44)) Font:PAGESIZE(17) Text:@"公斤  (kg)"];
    _weightUnitLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [_weightField addSubview:_weightUnitLabel];
    _weightUnitLabel.textAlignment=NSTextAlignmentRight;
    
    
    //确认计算
    UIButton * confirmButton=[ZCControl createButtonWithFrame:CGRectMake(0, HEIGHT-64-PAGESIZE(46), WIDTH, PAGESIZE(46)) Text:@"计算体重指数" ImageName:nil bgImageName:nil Target:self Method:@selector(confirmButtonClick)];
    [_rootScrollView addSubview:confirmButton];
    [confirmButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(20)];
    [confirmButton setBackgroundColor:CREATECOLOR(254, 154, 51, 1)];
    
    
    //收起键盘
    UITapGestureRecognizer * tapRoot = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRootAction)];
    //设置点击次数
    tapRoot.numberOfTapsRequired = 1;
    //设置几根胡萝卜有效
    tapRoot.numberOfTouchesRequired = 1;
    [_rootScrollView addGestureRecognizer:tapRoot];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark 确认计算
-(void)confirmButtonClick
{
    if ([_heightField.text isEqualToString:@""]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入身高" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if ([_heightField.text floatValue]<=0 || [_heightField.text floatValue]>250) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"身高请输入0~250之间的数字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if ([_weightField.text isEqualToString:@""]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入体重" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if ([_weightField.text floatValue]<=0 || [_weightField.text floatValue]>150) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"体重请输入0~150之间的数字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else {
        float _height = [_heightField.text floatValue];
        float _weight = [_weightField.text floatValue];
        float bmi=_weight/((_height/100)*(_height/100));
        
        ToolsBmiDeatailViewController * tvc=[[ToolsBmiDeatailViewController alloc]init];
        tvc.bmi=[NSString stringWithFormat:@"%.2f",bmi];
        tvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:tvc animated:YES];
    }
}


#pragma mark 输入完毕
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //收起键盘
    [self tapRootAction];
    
    return YES;
}

#pragma mark 键盘监听方法设置
//当键盘出现时调用
-(void)keyboardWillShow:(NSNotification *)aNotification{
    //第一个参数写输入view的父view即可，第二个写监听获得的notification，第三个写希望高于键盘的高度(只在被键盘遮挡时才启用,如控件未被遮挡,则无变化)
    //如果想不通输入view获得不同高度，可自己在此方法里分别判断区别
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillShowWithSuperView:_rootScrollView andNotification:aNotification higherThanKeyboard:0];
    
}
//当键退出时调用
-(void)keyboardWillHide:(NSNotification *)aNotification{
    
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillHide];
}
//dealloc中需要移除监听
-(void)dealloc{
    //移除监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    //移除监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
//收起键盘
-(void)tapRootAction
{
    //收起键盘
    [_rootScrollView endEditing:YES];
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
