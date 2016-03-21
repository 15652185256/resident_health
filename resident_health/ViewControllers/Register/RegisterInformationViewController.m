//
//  RegisterInformationViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "RegisterInformationViewController.h"

//更换头像
#import "FSMediaPicker.h"
//键盘移动
#import "CDPMonitorKeyboard.h"
//注册地址
#import "RegisterAddressViewController.h"
//Base64加密
#import "Base64.h"
//选择器
#import "ZHPickView.h"

@interface RegisterInformationViewController ()<FSMediaPickerDelegate,UIActionSheetDelegate,ZHPickViewDelegate,UITextFieldDelegate>
//头像
@property(nonatomic,retain)FSMediaPicker * mediaPicker;
//头像按钮
@property(nonatomic,retain)UIButton * headerImageButton;
//真实姓名
@property(nonatomic,retain)UITextField * nickNameField;
//性别
@property(nonatomic,retain)UILabel * sexLabel;
//出生年月日
@property(nonatomic,retain)UILabel * birthdayLabel;
//身份证号
@property(nonatomic,retain)UITextField * cardNumberField;
//注册单列
@property(nonatomic,retain)RegisterManager * regManager;
//选择器
@property(nonatomic,retain)ZHPickView * pickview;
@end

@implementation RegisterInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 21) Font:18 Text:@"基本信息"];
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
    
    //真实姓名
    UIImageView * nameImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _nickNameField=[ZCControl createTextFieldWithFrame:CGRectMake(0, mainViewHeight+PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"真实姓名" passWord:NO leftImageView:nameImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _nickNameField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _nickNameField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _nickNameField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_nickNameField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_nickNameField];
    _nickNameField.delegate=self;
    
    
    //性别背景
    UIView * bgSexView=[ZCControl createView:CGRectMake(0, CGRectGetMaxY(_nickNameField.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46))];
    if (WIDTH>320) {
        bgSexView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        bgSexView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    bgSexView.userInteractionEnabled=YES;
    [self.view addSubview:bgSexView];
    
    //性别
    _sexLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, WIDTH-15, PAGESIZE(46)) Font:PAGESIZE(17) Text:@"性别"];
    _sexLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [bgSexView addSubview:_sexLabel];
    
    //性别触发事件
    UITapGestureRecognizer * tapSex = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSexGestureAction)];
    [bgSexView addGestureRecognizer:tapSex];
    
    //生日背景
    UIView * bgBirthdayView=[ZCControl createView:CGRectMake(0, CGRectGetMaxY(bgSexView.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46))];
    if (WIDTH>320) {
        bgBirthdayView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        bgBirthdayView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    bgBirthdayView.userInteractionEnabled=YES;
    [self.view addSubview:bgBirthdayView];
    
    //生日
    _birthdayLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, WIDTH-15, PAGESIZE(46)) Font:PAGESIZE(17) Text:@"出生年月日"];
    _birthdayLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [bgBirthdayView addSubview:_birthdayLabel];
    
    //生日触发事件
    UITapGestureRecognizer * tapBirthday = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBirthdayGestureAction)];
    [bgBirthdayView addGestureRecognizer:tapBirthday];
    
    
    //身份证号
    UIImageView * cardNumberImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, PAGESIZE(46))];
    _cardNumberField=[ZCControl createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(bgBirthdayView.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46)) placeholder:@"身份证号码" passWord:NO leftImageView:cardNumberImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    if (WIDTH>320) {
        _cardNumberField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        _cardNumberField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    _cardNumberField.textColor=CREATECOLOR(153, 153, 153, 1);
    [_cardNumberField setValue:CREATECOLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_cardNumberField];
    _cardNumberField.delegate=self;
    
    
    //提示
    float promptLabelHeight;
    if (HEIGHT>480) {
        promptLabelHeight=CGRectGetMaxY(_cardNumberField.frame)+PAGESIZE(14);
    }
    else{
        promptLabelHeight=CGRectGetMaxY(_cardNumberField.frame)+PAGESIZE(7);
    }
    UILabel * promptLabel=[ZCControl createLabelWithFrame:CGRectMake(0, promptLabelHeight, WIDTH, 21) Font:12 Text:@"温馨提示 : 填写内容请与有效证件一致!"];
    promptLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    promptLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:promptLabel];
    
    
    //page页脚
    float pageViewHeight=0;
    if (HEIGHT>480) {
        pageViewHeight=HEIGHT-PAGESIZE(46-77/2-14/2);
    }
    else{
        pageViewHeight=HEIGHT-PAGESIZE(46-77/2-14/2)+20;
    }
    
    UIView * pageView1=[ZCControl createView:CGRectMake(0, 0, 11, 11)];
    pageView1.center=CGPointMake(WIDTH/2-11/2-21-14/2, pageViewHeight);
    pageView1.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    pageView1.layer.cornerRadius=pageView1.frame.size.width/2;
    pageView1.layer.masksToBounds=YES;
    [self.view addSubview:pageView1];
    
    UIView * pageView2=[ZCControl createView:CGRectMake(0, 0, 14, 14)];
    pageView2.center=CGPointMake(WIDTH/2 ,pageViewHeight);
    pageView2.backgroundColor=CREATECOLOR(254, 154, 51, 1);
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
    
    UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    sheet.delegate=self;
    sheet.tag=1000;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==2) {
        return;
    }
    
    if (actionSheet.tag==1000) {
        if (buttonIndex==0) {
            [_mediaPicker takePhotoFromCamera];
        }
        else if(buttonIndex==1){
            [_mediaPicker takePhotoFromPhotoLibrary];
        }
    }else if (actionSheet.tag==2000) {
        if (buttonIndex) {
            //女
            _sexLabel.text=@"女";
            
        }else{
            //男
            _sexLabel.text=@"男";
        }
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


#pragma mark 性别
-(void)tapSexGestureAction
{
    //收起键盘
    [self tapRootAction];
    
    UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男♂",@"女♀", nil];
    sheet.delegate=self;
    sheet.tag=2000;
    [sheet showInView:self.view];
}

#pragma mark 生日
-(void)tapBirthdayGestureAction
{
    [_pickview remove];
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date=[formatter dateFromString:@"1970-01-01"];
    
    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    
    _pickview.tag=0;
    
    _pickview.delegate=self;
    
    [_pickview show];
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (pickView.tag==0) {
        _birthdayLabel.text = resultString;
    }
}


#pragma mark 注册
-(void)regButtonClick
{
        if (![Validate validateNickname:_nickNameField.text]) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入正确的姓名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else if ([_sexLabel.text isEqualToString:@"性别"]) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请选择性别" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else if ([_birthdayLabel.text isEqualToString:@"出生年月日"]) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请选择出生年月日" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else if (![Validate validateIdentityCard:_cardNumberField.text]) {
    
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入正确的身份证号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
    
        }else{
    
            //保存真实姓名
            _regManager.customerName=_nickNameField.text;
            //保存性别
            _regManager.customerGender=_sexLabel.text;
            //保存年月日
            _regManager.customerBrithday=_birthdayLabel.text;
            //保存身份证号
            _regManager.customerCardId=_cardNumberField.text;
    
            //跳转下一页
            RegisterAddressViewController * rvc=[[RegisterAddressViewController alloc]init];
            [self presentViewController:rvc animated:YES completion:^{}];
        }
//    //跳转下一页
//    RegisterAddressViewController * rvc=[[RegisterAddressViewController alloc]init];
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
    //移除选择器
    [_pickview remove];
    //收起键盘
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
