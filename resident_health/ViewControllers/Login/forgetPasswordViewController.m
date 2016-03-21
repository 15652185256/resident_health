//
//  forgetPasswordViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/25.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "forgetPasswordViewController.h"
//设置新密码
#import "NewPasswordViewController.h"

//键盘移动
#import "CDPMonitorKeyboard.h"
//手机验证码
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+ExtexdMethods.h>
#import <SMS_SDK/Extend/SMSSDKUserInfo.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>

@interface forgetPasswordViewController ()<UITextFieldDelegate>
//手机号码
@property(nonatomic,retain)UITextField * telephoneField;
//发送验证码
@property(nonatomic,retain)UIButton * timeButton;
//验证码
@property(nonatomic,retain)UITextField * verifyCodeField;
@end

@implementation forgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    //初始化应用，appKey和appSecret从后台申请得到
    [SMSSDK registerApp:SMS_APP_Key withSecret:SMS_APP_SECRET];
    
    //设置导航
    [self createNav];
    
    //设置页面
    [self createView];
}

#pragma mark 设置导航
-(void)createNav
{
    //导航条
    UIView * navView=[ZCControl createView:CGRectMake(0, 0, WIDTH, 64)];
    navView.backgroundColor=CREATECOLOR(165, 197, 29, 1);
    [self.view addSubview:navView];
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(15, 20+(44-18)/2, 100, 18) Text:nil ImageName:@"reg_return@2x" bgImageName:nil Target:self Method:@selector(returnButtonClick)];
    [navView addSubview:returnButton];
    returnButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 100/10*8);
    
    //标题
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 21) Font:18 Text:@"忘记密码"];
    titleLabel.center=CGPointMake(WIDTH/2, 20+10+8);
    titleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    
}

//返回
-(void)returnButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark 设置页面
-(void)createView
{
    float navHeight=64;
    
    
    //手机号码
    UIImageView * telephoneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _telephoneField=[ZCControl createTextFieldWithFrame:CGRectMake(0, navHeight+PAGESIZE(20), WIDTH-115, PAGESIZE(46)) placeholder:@"手机号码" passWord:NO leftImageView:telephoneImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _telephoneField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _telephoneField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _telephoneField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_telephoneField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_telephoneField];
    _telephoneField.delegate=self;
    _telephoneField.keyboardType = UIKeyboardTypePhonePad;
    
    //发送验证码
    _timeButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-105, CGRectGetMinY(_telephoneField.frame), 105, PAGESIZE(45)) Text:@"验证码" ImageName:nil bgImageName:nil Target:self Method:@selector(startTime)];
    _timeButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(17)];
    [_timeButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    [_timeButton setBackgroundColor:CREATECOLOR(254, 154, 51, 1)];
    [self.view addSubview:_timeButton];
    
    
    //验证码
    UIImageView * verifyCodeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _verifyCodeField=[ZCControl createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(_telephoneField.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"验证码" passWord:NO leftImageView:verifyCodeImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
//    _verifyCodeField.keyboardType = UIKeyboardTypePhonePad;
    if (WIDTH>320) {
        _verifyCodeField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _verifyCodeField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _verifyCodeField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_verifyCodeField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_verifyCodeField];
    _verifyCodeField.delegate=self;
    _verifyCodeField.keyboardType = UIKeyboardTypePhonePad;
    
    //注册按钮
    UIButton * regButton=[ZCControl createButtonWithFrame:CGRectMake(0, HEIGHT-PAGESIZE(46), WIDTH, PAGESIZE(46)) Text:@"下一步" ImageName:nil bgImageName:nil Target:self Method:@selector(regButtonClick)];
    [regButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    regButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(20)];
    [regButton setBackgroundColor:CREATECOLOR(254, 154, 51, 1)];
    [self.view addSubview:regButton];
    
    
    //收起键盘
    UITapGestureRecognizer * tapRoot = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRootAction)];
    //设置点击次数
    tapRoot.numberOfTapsRequired = 1;
    //设置几根胡萝卜有效
    tapRoot.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapRoot];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark 发送验证码
-(void)startTime{
    if (![Validate validateMobile:_telephoneField.text])
    {
        //手机号码不正确
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"请输入正确的手机号码", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil)otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString * alertStr = [NSString stringWithFormat:@"%@:+86 %@",NSLocalizedString(@"发送验证码到", nil),_telephoneField.text];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"确定电话号码", nil) message:alertStr delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
    [alert show];
    
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_timeButton setTitle:@"验证码" forState:UIControlStateNormal];
                _timeButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(17)];
                _timeButton.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString * strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [_timeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                _timeButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(14)];
                _timeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex){
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_telephoneField.text zone:@"86" customIdentifier:nil result:^(NSError *error){
            
            if (!error){
                NSLog(@"验证码发送成功");
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"手机号码错误", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil)otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}


#pragma mark 注册
-(void)regButtonClick
{
//    //跳转下一页
//    NewPasswordViewController * rvc=[[NewPasswordViewController alloc]init];
//    
//    rvc.loginName=_telephoneField.text;
//    
//    [self presentViewController:rvc animated:YES completion:^{}];
    
    
    if (![Validate validateMobile:_telephoneField.text]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入正确的手机号码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if (_verifyCodeField.text.length != 4) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入4位有效验证码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else {
        
        [SMSSDK commitVerificationCode:_verifyCodeField.text phoneNumber:_telephoneField.text zone:@"86" result:^(NSError *error) {
            
            if (!error) {
                
                //跳转下一页
                NewPasswordViewController * rvc=[[NewPasswordViewController alloc]init];
                
                rvc.loginName=_telephoneField.text;
                
                [self presentViewController:rvc animated:YES completion:^{}];
                
            } else {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证码错误", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
                [alertView show];
                
            }
        }];
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
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillShowWithSuperView:self.view andNotification:aNotification higherThanKeyboard:0];
    
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
