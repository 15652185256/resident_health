//
//  LoginViewController.m
//  HealthManager
//
//  Created by mac on 15-8-31.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "LoginViewController.h"
//注册页
#import "RegisterUserViewController.h"
//键盘移动
#import "CDPMonitorKeyboard.h"
//忘记密码
#import "forgetPasswordViewController.h"
//主页
#import "MainTabBarViewController.h"
//登录数据
#import "LoginViewModel.h"

@interface LoginViewController ()<UITextFieldDelegate>
//用户名
@property(nonatomic,retain)UITextField * userNameTextField;
//密码
@property(nonatomic,retain)UITextField * passwordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
}

-(void)createView
{
    //设置背景
    UIImageView * bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) ImageName:@"login"];
    [self.view addSubview:bgImageView];
    
    float logoHeight=0;
    if (HEIGHT>480)
    {
        logoHeight=PAGESIZE(116+95);
    }else{
        logoHeight=PAGESIZE(116+95)-40;
    }
    
    //设置logo
    UIImageView * logoImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, PAGESIZE(193), PAGESIZE(116)) ImageName:@"logo@2x"];
    logoImageView.center=CGPointMake(WIDTH/2, logoHeight/2+20);
    [self.view addSubview:logoImageView];
    
    //账号
    UIImageView * userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, PAGESIZE(46))];
    UIImageView * userNameImageView=[ZCControl createImageViewWithFrame:CGRectMake(20, (PAGESIZE(46)-PAGESIZE(21))/2, PAGESIZE(21), PAGESIZE(21)) ImageName:@"login_username@2x"];
    [userImageView addSubview:userNameImageView];
    
    _userNameTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, logoHeight+20, WIDTH, PAGESIZE(46)) placeholder:@"请输入手机号" passWord:NO leftImageView:userImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    _userNameTextField.backgroundColor=CREATECOLOR(255, 255, 255, 0.4);
    _userNameTextField.textColor=CREATECOLOR(255, 255, 255, 1);
    [_userNameTextField setValue:CREATECOLOR(255, 255, 255, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_userNameTextField];
    _userNameTextField.delegate=self;
    _userNameTextField.keyboardType = UIKeyboardTypePhonePad;

    //密码
    UIImageView * passImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, PAGESIZE(46))];
    UIImageView * passwordImageView=[ZCControl createImageViewWithFrame:CGRectMake(20, (PAGESIZE(46)-PAGESIZE(21))/2, PAGESIZE(21), PAGESIZE(21)) ImageName:@"login_password@2x"];
    [passImageView addSubview:passwordImageView];
    
    _passwordTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(_userNameTextField.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"请输入登录密码" passWord:YES leftImageView:passImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    _passwordTextField.backgroundColor=CREATECOLOR(255, 255, 255, 0.4);
    _passwordTextField.textColor=CREATECOLOR(255, 255, 255, 1);
    [_passwordTextField setValue:CREATECOLOR(255, 255, 255, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_passwordTextField];
    _passwordTextField.delegate=self;

    //忘记密码
    UIButton * forgetPassworkBurron=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-90, CGRectGetMaxY(_passwordTextField.frame)+PAGESIZE(16), 80, 21) Text:@"忘记密码?" ImageName:nil bgImageName:nil Target:self Method:@selector(forgetPassworkBurronClick)];
    forgetPassworkBurron.titleLabel.font=[UIFont systemFontOfSize:14];
    [forgetPassworkBurron setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.view addSubview:forgetPassworkBurron];

    //登录
    UIButton * loginButton=[ZCControl createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(forgetPassworkBurron.frame)+PAGESIZE(33), WIDTH, PAGESIZE(46)) Text:@"登录" ImageName:nil bgImageName:nil Target:self Method:@selector(loginButtonClick)];
    [loginButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(20)];
    [loginButton setBackgroundColor:CREATECOLOR(254, 154, 51, 1)];
    [self.view addSubview:loginButton];

    //建档
    UILabel * regLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-20-60-74, CGRectGetMaxY(loginButton.frame)+PAGESIZE(65), 74, 25) Font:14 Text:@"还没建档?"];
    regLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    [self.view addSubview:regLabel];
    
    //注册
    UIButton * regButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-20-60, CGRectGetMaxY(loginButton.frame)+PAGESIZE(65), 60, 25) Text:@"注 册" ImageName:nil bgImageName:nil Target:self Method:@selector(regButtonClick)];
    [regButton setTitleColor:CREATECOLOR(55, 125, 9, 1) forState:UIControlStateNormal];
    regButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [regButton setBackgroundColor:CREATECOLOR(255, 255, 255, 0.4)];
    [self.view addSubview:regButton];
    
    //收起键盘
    UITapGestureRecognizer * tapRoot = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRootAction)];
    //设置点击次数
    tapRoot.numberOfTapsRequired = 1;
    //设置几根胡萝卜有效
    tapRoot.numberOfTouchesRequired = 1;
    [bgImageView addGestureRecognizer:tapRoot];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}


#pragma mark 忘记密码
-(void)forgetPassworkBurronClick
{
    forgetPasswordViewController * fvc=[[forgetPasswordViewController alloc]init];
    
    [self presentViewController:fvc animated:YES completion:^{}];
}

#pragma mark 登录
-(void)loginButtonClick
{
    if ([_userNameTextField.text isEqualToString:@""]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if ([_passwordTextField.text isEqualToString:@""]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入登录密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else {
        
        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"正在登录。。。",KVNProgressViewParameterBackgroundType: @(KVNProgressBackgroundTypeSolid),KVNProgressViewParameterFullScreen: @(0)}];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        
        
        //NSLog(@"%@ %@",[user objectForKey:@"customerPhone"],[user objectForKey:@"customerPsw"]);
        
        if ([_userNameTextField.text isEqualToString:[user objectForKey:@"customerPhone"]] && [[Base64 base64StringFromText:_passwordTextField.text] isEqualToString:[user objectForKey:@"customerPsw"]]) {
            dispatch_main_after(1.5f, ^{
                [KVNProgress showSuccessWithStatus:@"登录成功"];
                
                dispatch_main_after(1.5f, ^{
                    [UIView animateWithDuration:1 animations:^{
                        
                        [user setObject:@"1" forKey:ISLOGIN];
                        [user synchronize];
                        
                        MainTabBarViewController * mvc=[[MainTabBarViewController alloc]init];
                        [self presentViewController:mvc animated:YES completion:^{}];
                        mvc.selectedViewController=mvc.viewControllers[2];
                    }];
                });
            });
        } else {
            
            [KVNProgress dismiss];
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"手机号码/密码错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
    }
}

static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}


#pragma mark 注册
-(void)regButtonClick
{
    RegisterUserViewController * rvc=[[RegisterUserViewController alloc]init];
    
    [self presentViewController:rvc animated:YES completion:^{}];
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
-(void)keyboardWillShow:(NSNotification *)aNotification
{
    //第一个参数写输入view的父view即可，第二个写监听获得的notification，第三个写希望高于键盘的高度(只在被键盘遮挡时才启用,如控件未被遮挡,则无变化)
    //如果想不通输入view获得不同高度，可自己在此方法里分别判断区别
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillShowWithSuperView:self.view andNotification:aNotification higherThanKeyboard:0];
    
}
//当键退出时调用
-(void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillHide];
}
//dealloc中需要移除监听
-(void)dealloc
{
    //移除监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    //移除监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
//收起键盘
-(void)tapRootAction
{
    [self.view endEditing:YES];
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
