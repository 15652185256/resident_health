//
//  PersonalPasswordViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/25.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "PersonalPasswordViewController.h"

//键盘移动
#import "CDPMonitorKeyboard.h"

@interface PersonalPasswordViewController ()<UITextFieldDelegate>
//主视图
@property(nonatomic,retain)UIScrollView * rootScrollView;
//当前密码
@property(nonatomic,retain)UITextField * oldPasswordField;
//新密码
@property(nonatomic,retain)UITextField * passwordField;
//确认密码
@property(nonatomic,retain)UITextField * confirmPasswordField;

@end

@implementation PersonalPasswordViewController

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
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
    //设置导航的标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(255, 255, 255, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationItem.title = @"修改密码";
    
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
    
    //当前密码
    UIImageView * oldPasswordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _oldPasswordField=[ZCControl createTextFieldWithFrame:CGRectMake(0, PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"当前密码" passWord:YES leftImageView:oldPasswordImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _oldPasswordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _oldPasswordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _oldPasswordField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_oldPasswordField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_rootScrollView addSubview:_oldPasswordField];
    _oldPasswordField.delegate=self;
    
    
    //新密码
    UIImageView * passwordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _passwordField=[ZCControl createTextFieldWithFrame:CGRectMake(0, PAGESIZE(20)*2+PAGESIZE(46), WIDTH, PAGESIZE(46)) placeholder:@"新密码" passWord:YES leftImageView:passwordImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _passwordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _passwordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _passwordField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_passwordField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_rootScrollView addSubview:_passwordField];
    _passwordField.delegate=self;
    
    
    //当前密码
    UIImageView * confirmPasswordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _confirmPasswordField=[ZCControl createTextFieldWithFrame:CGRectMake(0, PAGESIZE(20)*3+PAGESIZE(46)*2, WIDTH, PAGESIZE(46)) placeholder:@"确认密码" passWord:YES leftImageView:confirmPasswordImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _confirmPasswordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _confirmPasswordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _confirmPasswordField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_confirmPasswordField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_rootScrollView addSubview:_confirmPasswordField];
    _confirmPasswordField.delegate=self;
    
    
    //确认修改
    UIButton * confirmButton=[ZCControl createButtonWithFrame:CGRectMake(0, HEIGHT-64-PAGESIZE(46), WIDTH, PAGESIZE(46)) Text:@"确认修改" ImageName:nil bgImageName:nil Target:self Method:@selector(confirmButtonClick)];
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


#pragma mark 确认修改
-(void)confirmButtonClick
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    //NSLog(@"%@",[Base64 textFromBase64String:[user objectForKey:@"customerPsw"]]);

    if ([_oldPasswordField.text isEqualToString:@""]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入当前密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if (![Validate validatePassword:_passwordField.text]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入6~10位数字和字母混合d的新密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if (![_confirmPasswordField.text isEqualToString:_passwordField.text]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"两次输入的密码不相同" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else {

        if ([[Base64 base64StringFromText:_oldPasswordField.text] isEqualToString:[user objectForKey:@"customerPsw"]]) {
            
            [user setObject:[Base64 base64StringFromText:_confirmPasswordField.text] forKey:@"customerPsw"];
            [user synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"当前密码错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
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
