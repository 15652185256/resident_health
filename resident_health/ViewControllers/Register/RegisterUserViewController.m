//
//  RegisterUserViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "RegisterUserViewController.h"

//更换头像
#import "FSMediaPicker.h"
//键盘移动
#import "CDPMonitorKeyboard.h"
//手机验证码
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+ExtexdMethods.h>
#import <SMS_SDK/Extend/SMSSDKUserInfo.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
//复选框
#import "QCheckBox.h"
//注册个人信息
#import "RegisterInformationViewController.h"
//用户协议
#import "UserAgreementViewController.h"

@interface RegisterUserViewController ()<FSMediaPickerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
//头像
@property(nonatomic,retain)FSMediaPicker * mediaPicker;
//头像按钮
@property(nonatomic,retain)UIButton * headerImageButton;
//手机号码
@property(nonatomic,retain)UITextField * telephoneField;
//发送验证码
@property(nonatomic,retain)UIButton * timeButton;
//验证码
@property(nonatomic,retain)UITextField * verifyCodeField;
//密码
@property(nonatomic,retain)UITextField * passwordField;
//复选框
@property(nonatomic,retain)QCheckBox * agreedCheck;
//注册单列
@property(nonatomic,retain)RegisterManager * regManager;
@end

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化应用，appKey和appSecret从后台申请得到
    [SMSSDK registerApp:SMS_APP_Key withSecret:SMS_APP_SECRET];
    
    //实列化注册单列
    _regManager=[RegisterManager shareManager];
    
    [self createView];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (_regManager.headerImage) {
        [_headerImageButton setImage:_regManager.headerImage forState:UIControlStateNormal];
    }
}

-(void)createView
{
    //设置背景
    UIImageView * bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) ImageName:@"login"];
    [self.view addSubview:bgImageView];
    
    //返回
    UIButton * returnButton=[ZCControl createButtonWithFrame:CGRectMake(15, 20+(44-18)/2, 100, 18) Text:nil ImageName:@"reg_return@2x" bgImageName:nil Target:self Method:@selector(returnButtonClick)];
    [self.view addSubview:returnButton];
    returnButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 100/10*8);
    
    //标题
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 21) Font:18 Text:@"新用户注册"];
    [bgImageView addSubview:titleLabel];
    titleLabel.center=CGPointMake(WIDTH/2, 20+10+8);
    titleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    float mainViewHeight;
    if (HEIGHT>480) {
        mainViewHeight=PAGESIZE(370/2)+20;
    }
    else{
        mainViewHeight=PAGESIZE(370/2)+20-25;
    }
    
    //头像
    _headerImageButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, PAGESIZE(93), PAGESIZE(93)) Text:nil ImageName:@"reg_header_image@2x" bgImageName:@"reg_header_bg_image.jpg" Target:self Method:@selector(headerImageButtonClick:)];
    _headerImageButton.center=CGPointMake(WIDTH/2, mainViewHeight/2+23);
    _headerImageButton.layer.cornerRadius=_headerImageButton.frame.size.width/2;
    _headerImageButton.layer.masksToBounds=YES;
    [bgImageView addSubview:_headerImageButton];

    //主视图背景
    UIView * mainView=[ZCControl createView:CGRectMake(0, mainViewHeight, WIDTH, HEIGHT-mainViewHeight)];
    [self.view addSubview:mainView];
    mainView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    //手机号码
    UIImageView * telephoneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _telephoneField=[ZCControl createTextFieldWithFrame:CGRectMake(0, mainViewHeight+PAGESIZE(20), WIDTH-115, PAGESIZE(46)) placeholder:@"手机号码" passWord:NO leftImageView:telephoneImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
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
    
    //密码
    UIImageView * passwordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _passwordField=[ZCControl createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(_verifyCodeField.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"密码" passWord:YES leftImageView:passwordImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _passwordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _passwordField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _passwordField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_passwordField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_passwordField];
    _passwordField.delegate=self;
    
    
    //复选框
    _agreedCheck = [[QCheckBox alloc] initWithDelegate:self];
    _agreedCheck.frame = CGRectMake(15, CGRectGetMaxY(_passwordField.frame)+8, 120, PAGESIZE(40));
    [_agreedCheck setTitle:@"我已阅读并同意" forState:UIControlStateNormal];
    [_agreedCheck setTitleColor:CREATECOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    [_agreedCheck.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [self.view addSubview:_agreedCheck];
    
    //左括号
    UILabel * leftParenthesesLabel=[ZCControl createLabelWithFrame:CGRectMake(120, CGRectGetMinY(_agreedCheck.frame), 20, PAGESIZE(40)) Font:15 Text:@"《"];
    leftParenthesesLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    [self.view addSubview:leftParenthesesLabel];
    
    //用户协议
    UILabel * userAgreementLabel=[ZCControl createLabelWithFrame:CGRectMake(120+16, CGRectGetMinY(_agreedCheck.frame), 50, PAGESIZE(40)) Font:12 Text:@"用户协议"];
    userAgreementLabel.textColor=CREATECOLOR(21, 126, 251, 1);
    userAgreementLabel.userInteractionEnabled=YES;
    [self.view addSubview:userAgreementLabel];
    
    //触发事件
    UITapGestureRecognizer * tapUserAgreement = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAgreementGestureAction)];
    [userAgreementLabel addGestureRecognizer:tapUserAgreement];
    
    //右括号
    UILabel * rightParenthesesLabel=[ZCControl createLabelWithFrame:CGRectMake(120+15+50, CGRectGetMinY(_agreedCheck.frame), 20, PAGESIZE(40)) Font:15 Text:@"》"];
    rightParenthesesLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    [self.view addSubview:rightParenthesesLabel];
    
    
    //page页脚
    float pageViewHeight=0;
    if (HEIGHT>480) {
        pageViewHeight=HEIGHT-PAGESIZE(46-77/2-14/2);
    }
    else{
        pageViewHeight=HEIGHT-PAGESIZE(46-77/2-14/2)+20;
    }
    
    UIView * pageView1=[ZCControl createView:CGRectMake(0, 0, 14, 14)];
    pageView1.center=CGPointMake(WIDTH/2-11/2-21-14/2, pageViewHeight);
    pageView1.backgroundColor=CREATECOLOR(254, 154, 51, 1);
    pageView1.layer.cornerRadius=pageView1.frame.size.width/2;
    pageView1.layer.masksToBounds=YES;
    [self.view addSubview:pageView1];
    
    UIView * pageView2=[ZCControl createView:CGRectMake(0, 0, 11, 11)];
    pageView2.center=CGPointMake(WIDTH/2 ,pageViewHeight);
    pageView2.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    pageView2.layer.cornerRadius=pageView2.frame.size.width/2;
    pageView2.layer.masksToBounds=YES;
    [self.view addSubview:pageView2];
    
    UIView * pageView3=[ZCControl createView:CGRectMake(0, 0, 11, 11)];
    pageView3.center=CGPointMake(WIDTH/2+11/2+21+14/2, pageViewHeight);
    pageView3.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    pageView3.layer.cornerRadius=pageView3.frame.size.width/2;
    pageView3.layer.masksToBounds=YES;
    [self.view addSubview:pageView3];
    
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

#pragma mark 返回
-(void)returnButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark 更换头像
-(void)headerImageButtonClick:(UIButton*)sender
{
    //收起键盘
    [self tapRootAction];
    
    _mediaPicker = [[FSMediaPicker alloc] init];
    _mediaPicker.mediaType = 0;
    _mediaPicker.editMode = 1;
    _mediaPicker.delegate = self;
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [_mediaPicker takePhotoFromCamera];
//    }];
//    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [_mediaPicker takePhotoFromPhotoLibrary];
//    }];
//    [alertController addAction:cancelAction];
//    [alertController addAction:cameraAction];
//    [alertController addAction:photoAction];
//    [self presentViewController:alertController animated:YES completion:nil];
    
    UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    sheet.delegate=self;
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [_mediaPicker takePhotoFromCamera];
    }
    else if(buttonIndex==1){
        [_mediaPicker takePhotoFromPhotoLibrary];
    }
    else{
        return;
    }
}
- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    
    if (mediaInfo.mediaType == FSMediaTypeVideo) {
        
    } else {
        [_headerImageButton setTitle:nil forState:UIControlStateNormal];
        [_headerImageButton setImage:mediaInfo.circularEditedImage forState:UIControlStateNormal];
        
        _regManager.headerImage=mediaInfo.circularEditedImage;
    }
}
- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    NSLog(@"%s",__FUNCTION__);
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
    
    NSString * str = [NSString stringWithFormat:@"%@:+86 %@",NSLocalizedString(@"发送验证码到", nil),_telephoneField.text];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"确定电话号码", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
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


#pragma mark 用户协议
-(void)tapUserAgreementGestureAction
{
    UserAgreementViewController * nvc=[[UserAgreementViewController alloc]init];
    [self presentViewController:nvc animated:YES completion:^{}];
}

#pragma mark 注册
-(void)regButtonClick
{
        if (![Validate validateMobile:_telephoneField.text]) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入正确的手机号码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else if (_verifyCodeField.text.length != 4) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入4位有效验证码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else if (![Validate validatePassword:_passwordField.text]) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入6~10位数字和字母混合密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else if (_agreedCheck.selected==NO) {
    
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"请同意用户协议", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
            [alertView show];
    
        }else{
            
            //跳转下一页
            RegisterInformationViewController * rvc=[[RegisterInformationViewController alloc]init];
            [self presentViewController:rvc animated:YES completion:^{}];
            
            
            [SMSSDK commitVerificationCode:_verifyCodeField.text phoneNumber:_telephoneField.text zone:@"86" result:^(NSError *error) {
                
                if (!error) {
                    
                    //保存手机号码
                    _regManager.customerPhone=_telephoneField.text;
                    //保存密码
                    _regManager.customerPsw=[Base64 base64StringFromText:_passwordField.text];
                    
                    //跳转下一页
                    RegisterInformationViewController * rvc=[[RegisterInformationViewController alloc]init];
                    [self presentViewController:rvc animated:YES completion:^{}];
                    
                } else {
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证码错误", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
                    [alertView show];
                    
                }
            }];
        }
    
//    RegisterInformationViewController * rvc=[[RegisterInformationViewController alloc]init];
//    [self presentViewController:rvc animated:YES completion:^{}];
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
