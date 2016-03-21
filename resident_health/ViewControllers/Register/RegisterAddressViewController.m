//
//  RegisterAddressViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "RegisterAddressViewController.h"

//更换头像
#import "FSMediaPicker.h"
//注册数据
#import "RegisterViewModel.h"
//主界面
#import "MainTabBarViewController.h"
//选择器
#import "ZHPickView.h"
//省市县区街道 数据
#import "RegionViewModel.h"

@interface RegisterAddressViewController ()<FSMediaPickerDelegate,UIActionSheetDelegate,ZHPickViewDelegate>
//头像
@property(nonatomic,retain)FSMediaPicker * mediaPicker;
//头像按钮
@property(nonatomic,retain)UIButton * headerImageButton;
//省
@property(nonatomic,retain)UILabel * provinceLabel;
//市
@property(nonatomic,retain)UILabel * cityLabel;
//县区
@property(nonatomic,retain)UILabel * countyLabel;
//街道
@property(nonatomic,retain)UILabel * streetLabel;
//注册单列
@property(nonatomic,retain)RegisterManager * regManager;
//选择器
@property(nonatomic,retain)ZHPickView * pickview;
@end

@implementation RegisterAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _regManager=[RegisterManager shareManager];
    
    [self createView];
    
    RegionViewModel * _regionViewModel=[[RegionViewModel alloc]init];
    [_regionViewModel RegionData];
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
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 21) Font:18 Text:@"所在区域"];
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
    
    //省背景
    UIView * bgProvinceView=[ZCControl createView:CGRectMake(0, mainViewHeight+PAGESIZE(20), WIDTH, PAGESIZE(46))];
    if (WIDTH>320) {
        bgProvinceView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        bgProvinceView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    bgProvinceView.userInteractionEnabled=YES;
    [self.view addSubview:bgProvinceView];
    
    //省
    _provinceLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, WIDTH-15, PAGESIZE(46)) Font:PAGESIZE(17) Text:@"所在省份"];
    _provinceLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [bgProvinceView addSubview:_provinceLabel];
    
    //省触发事件
    UITapGestureRecognizer * tapProvince = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProvinceGestureAction)];
    [bgProvinceView addGestureRecognizer:tapProvince];
    
    
    //市背景
    UIView * bgCityView=[ZCControl createView:CGRectMake(0, CGRectGetMaxY(bgProvinceView.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46))];
    if (WIDTH>320) {
        bgCityView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    }
    else{
        bgCityView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg_4s.jpg"]];
    }
    bgCityView.userInteractionEnabled=YES;
    [self.view addSubview:bgCityView];
    
    //市
    _cityLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, WIDTH-15, PAGESIZE(46)) Font:PAGESIZE(17) Text:@"所在城市"];
    _cityLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [bgCityView addSubview:_cityLabel];
    
    //市触发事件
    UITapGestureRecognizer * tapCity = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProvinceGestureAction)];
    [bgCityView addGestureRecognizer:tapCity];
    
    
    //县区背景
    UIView * bgCountyView=[ZCControl createView:CGRectMake(0, CGRectGetMaxY(bgCityView.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46))];
    bgCountyView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    bgCountyView.userInteractionEnabled=YES;
    [self.view addSubview:bgCountyView];
    
    //县区
    _countyLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, WIDTH-15, PAGESIZE(46)) Font:PAGESIZE(17) Text:@"所在区县"];
    _countyLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [bgCountyView addSubview:_countyLabel];
    
    //县区触发事件
    UITapGestureRecognizer * tapCounty = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCountyGestureAction)];
    [bgCountyView addGestureRecognizer:tapCounty];
    
    
    //街道背景
    UIView * bgStreetView=[ZCControl createView:CGRectMake(0, CGRectGetMaxY(bgCountyView.frame)+PAGESIZE(20), WIDTH, PAGESIZE(46))];
    bgStreetView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_textField_bg.jpg"]];
    bgStreetView.userInteractionEnabled=YES;
    [self.view addSubview:bgStreetView];
    
    //街道
    _streetLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 0, WIDTH-15, PAGESIZE(46)) Font:PAGESIZE(17) Text:@"所在街道"];
    _streetLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    [bgStreetView addSubview:_streetLabel];
    
    //街道触发事件
    UITapGestureRecognizer * tapStreet = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCountyGestureAction)];
    [bgStreetView addGestureRecognizer:tapStreet];
    
    
    //提示
    float promptLabelHeight;
    if (HEIGHT>480) {
        promptLabelHeight=CGRectGetMaxY(bgStreetView.frame)+PAGESIZE(14);
    }
    else{
        promptLabelHeight=CGRectGetMaxY(bgStreetView.frame)+PAGESIZE(7);
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
    
    UIView * pageView2=[ZCControl createView:CGRectMake(0, 0, 11, 11)];
    pageView2.center=CGPointMake(WIDTH/2 ,pageViewHeight);
    pageView2.backgroundColor=CREATECOLOR(204, 204, 204, 1);
    pageView2.layer.cornerRadius=pageView2.frame.size.width/2;
    pageView2.layer.masksToBounds=YES;
    [self.view addSubview:pageView2];
    
    UIView * pageView3=[ZCControl createView:CGRectMake(0, 0, 14, 14)];
    pageView3.center=CGPointMake(WIDTH/2+11/2+21+14/2, pageViewHeight);
    pageView3.backgroundColor=CREATECOLOR(254, 154, 51, 1);
    pageView3.layer.cornerRadius=pageView3.frame.size.width/2;
    pageView3.layer.masksToBounds=YES;
    [self.view addSubview:pageView3];
    
    //注册按钮
    UIButton * regButton=[ZCControl createButtonWithFrame:CGRectMake(0, HEIGHT-PAGESIZE(46), WIDTH, PAGESIZE(46)) Text:@"下一步" ImageName:nil bgImageName:nil Target:self Method:@selector(regButtonClick)];
    [regButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    regButton.titleLabel.font=[UIFont systemFontOfSize:PAGESIZE(20)];
    [regButton setBackgroundColor:CREATECOLOR(254, 154, 51, 1)];
    [self.view addSubview:regButton];
    
}

#pragma mark 返回
-(void)returnButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark 更换头像
-(void)headerImageButtonClick:(UIButton*)sender
{
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


#pragma mark 注册
-(void)regButtonClick
{
    
    if ([_provinceLabel.text isEqualToString:@"所在省份"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请选择所在省份" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if ([_cityLabel.text isEqualToString:@"所在城市"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请选择所在城市" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }
    else{
        
        //保存省份
        _regManager.provinceCode=_provinceLabel.text;
        //保存城市
        _regManager.cityCode=_cityLabel.text;
        
        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"正在注册。。。",KVNProgressViewParameterBackgroundType: @(KVNProgressBackgroundTypeSolid),KVNProgressViewParameterFullScreen: @(0)}];
        
        
        
        dispatch_main_after(1.5f, ^{
            [KVNProgress showSuccessWithStatus:@"注册成功"];
            
            dispatch_main_after(1.5f, ^{
                
                [UIView animateWithDuration:1 animations:^{
                    
                    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                    
                    [user setObject:_regManager.customerPhone forKey:@"customerPhone"];
                    [user setObject:_regManager.customerPsw forKey:@"customerPsw"];
                    
                    [user setObject:_regManager.customerName forKey:@"customerName"];
                    [user setObject:_regManager.customerGender forKey:@"customerGender"];
                    [user setObject:_regManager.customerBrithday forKey:@"customerBrithday"];
                    [user setObject:_regManager.customerCardId forKey:@"customerCardId"];
                    
                    [user setObject:_regManager.provinceCode forKey:@"provinceCode"];
                    [user setObject:_regManager.cityCode forKey:@"cityCode"];
                    
                    [user setObject:@"1" forKey:ISLOGIN];
                    [user synchronize];
                    
                    
                    MainTabBarViewController * mvc=[[MainTabBarViewController alloc]init];
                    [self presentViewController:mvc animated:YES completion:^{}];
                    mvc.selectedViewController=mvc.viewControllers[2];
                }];
            });
        });
        
        
        
        
        
        
//        RegisterViewModel * _regViewModel = [[RegisterViewModel alloc] init];
//        
//        [_regViewModel setBlockWithReturnBlock:^(id returnValue) {
//            
//            //NSLog(@"%@",returnValue);
//            
//            if ([[returnValue objectForKey:@"status"] intValue]==1) {
//                //存储头像
//                NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//                NSString * docDir = [paths objectAtIndex:0];
//                if(!docDir) {
//                    NSLog(@"Documents 目录未找到");
//                }
//                UIImage * headerImage=_regManager.headerImage;
//                NSData * imageData=UIImagePNGRepresentation(headerImage);
//                NSString * filePath = [docDir stringByAppendingPathComponent:@"userHeader.png"];
//                [imageData writeToFile:filePath atomically:YES];
//                
//                
//                dispatch_main_after(1.5f, ^{
//                    [KVNProgress showSuccessWithStatus:@"注册成功"];
//                    
//                    dispatch_main_after(1.5f, ^{
//                        
//                        [UIView animateWithDuration:1 animations:^{
//                            MainTabBarViewController * mvc=[[MainTabBarViewController alloc]init];
//                            [self presentViewController:mvc animated:YES completion:^{}];
//                            mvc.selectedViewController=mvc.viewControllers[2];
//                        }];
//                    });
//                });
//            }
//        } WithErrorBlock:^(id errorCode) {
//            [KVNProgress dismiss];
//        } WithFailureBlock:^{
//            [KVNProgress dismiss];
//        }];
//        
//        [_regViewModel RegUser];
        
        
        
    }
    
    
    
    
    
//    MainTabBarViewController * mvc=[[MainTabBarViewController alloc]init];
//    [self presentViewController:mvc animated:YES completion:^{}];
//    mvc.selectedViewController=mvc.viewControllers[2];
}

static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

#pragma mark 省市
-(void)tapProvinceGestureAction
{
    [_pickview remove];
    
    _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO];
    
    _pickview.tag=1000;
    
    _pickview.delegate=self;
    
    [_pickview show];
    
    
}

#pragma mark 区县 街道
-(void)tapCountyGestureAction
{
    
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (pickView.tag==1000) {
        
        NSArray * strArray=[resultString componentsSeparatedByString:@"|"];
        _provinceLabel.text = strArray[0];
        _cityLabel.text = strArray[1];
    }
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
