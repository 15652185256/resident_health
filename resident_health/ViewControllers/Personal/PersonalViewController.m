//
//  PersonalViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "PersonalViewController.h"
//更换头像
#import "FSMediaPicker.h"
//健康档案
#import "PersonalHealthListViewController.h"
//我的资料
#import "PersonalDataViewController.h"
//系统消息
#import "PersonalNewsListViewController.h"
//修改密码
#import "PersonalPasswordViewController.h"
//登录
#import "LoginViewController.h"

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate,FSMediaPickerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
//主视图
@property(nonatomic,retain)UITableView * tableView;
//头像
@property(nonatomic,retain)FSMediaPicker * mediaPicker;
//头像按钮
@property(nonatomic,retain)UIButton * headerImageButton;
//系统消息
@property(nonatomic,retain)UILabel * newsLabel;
//标题
@property(nonatomic,retain)NSMutableArray * titleArray;
//图标
@property(nonatomic,retain)NSMutableArray * imageArray;
//缓存路径
@property(nonatomic,copy)NSString * cacheString;

@end

@implementation PersonalViewController

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
    self.navigationItem.title = @"我的";
    
    //设置导航背景图
    self.navigationController.navigationBar.barTintColor = CREATECOLOR(165, 197, 29, 1);
    
}

#pragma mark 设置页面
-(void)createView
{
    //主视图
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    [_tableView setSeparatorColor:CREATECOLOR(227, 227, 227, 1)];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //创建头部
    [self createHeaderView];
    
    //加载数据
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * docDir = [paths objectAtIndex:0];
    NSString * filePath = [docDir stringByAppendingPathComponent:@"userHeader.png"];
    UIImage * header_image=[UIImage imageWithContentsOfFile:filePath];
    [_headerImageButton setImage:header_image forState:UIControlStateNormal];
}

//创建头部
-(void)createHeaderView
{
    float headerHeight=105;
    
    //用户
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    //头部背景
    UIImageView * bgHeaderImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, headerHeight) ImageName:@"personal_header_bg@2x"];
    _tableView.tableHeaderView=bgHeaderImageView;
    
    //头像
    _headerImageButton=[ZCControl createButtonWithFrame:CGRectMake((headerHeight-75)/2, (headerHeight-75)/2, 75, 75) Text:nil ImageName:nil bgImageName:@"reg_header_bg_image.jpg" Target:self Method:@selector(headerImageButtonClick:)];
    _headerImageButton.layer.cornerRadius=_headerImageButton.frame.size.width/2;
    _headerImageButton.layer.masksToBounds=YES;
    [bgHeaderImageView addSubview:_headerImageButton];
    
    
    
    //姓名
    UILabel * nickNameLabel=[ZCControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(_headerImageButton.frame)+10, 27, 100, 24) Font:20 Text:[user objectForKey:@"customerName"]];
    nickNameLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    [bgHeaderImageView addSubview:nickNameLabel];
    
    //性别
    UILabel * sexLabel=[ZCControl createLabelWithFrame:CGRectMake(CGRectGetMinX(nickNameLabel.frame), CGRectGetMaxY(nickNameLabel.frame)+10, 16, 16) Font:16 Text:[user objectForKey:@"customerGender"]];
    sexLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    [bgHeaderImageView addSubview:sexLabel];
    
    //年龄
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString * dateTime=[formatter stringFromDate:[NSDate date]];
    
    NSArray * brithdayArray=[[user objectForKey:@"customerBrithday"] componentsSeparatedByString:@"-"];
    
    UILabel * ageLabel=[ZCControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(sexLabel.frame)+17, CGRectGetMinY(sexLabel.frame), 60, 16) Font:16 Text:[NSString stringWithFormat:@"%d岁",[dateTime intValue]-[brithdayArray[0] intValue]]];
    ageLabel.textColor=CREATECOLOR(255, 255, 255, 1);
    [bgHeaderImageView addSubview:ageLabel];
    
    
    //健康档案
    UIButton * healthButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-10-105, (headerHeight-40)/2, 105, 40) Text:@"健康档案" ImageName:nil bgImageName:@"personal_health@2x" Target:self Method:@selector(healthButtonClick)];
    healthButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [healthButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    healthButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [bgHeaderImageView addSubview:healthButton];
}


#pragma mark 加载数据
-(void)loadData
{
    
    NSArray * titleArr1=@[@"我的资料",@"修改密码"];
    NSArray * titleArr2=@[@"系统消息",@"清理缓存"];
    NSArray * titleArr3=@[@""];
    
    _titleArray=[NSMutableArray arrayWithObjects:titleArr1,titleArr2,titleArr3,nil];
    
    
    NSArray * imageArr1=@[@"personal_data@2x",@"personal_password@2x"];
    NSArray * imageArr2=@[@"personal_news@2x",@"personal_cache@2x"];
    NSArray * imageArr3=@[@""];
    
    _imageArray=[NSMutableArray arrayWithObjects:imageArr1,imageArr2,imageArr3, nil];
    
    [_tableView reloadData];
}


#pragma mark 创建搜索列表
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr=_titleArray[section];
    
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray * imageArr=_imageArray[indexPath.section];
    NSArray * titleArr=_titleArray[indexPath.section];
    
    if (indexPath.section==2) {
        //退出登录
        UILabel * exitLabel=[ZCControl createLabelWithFrame:CGRectMake(0, 0, WIDTH, 46) Font:17 Text:@"退出登录"];
        [cell.contentView addSubview:exitLabel];
        exitLabel.backgroundColor=CREATECOLOR(254, 154, 51, 1);
        exitLabel.textColor=CREATECOLOR(255, 255, 255, 1);
        exitLabel.textAlignment=NSTextAlignmentCenter;
    }
    else{
        //图标
        UIImageView * imageView=[ZCControl createImageViewWithFrame:CGRectMake(15, 10, 21, 21) ImageName:imageArr[indexPath.row]];
        [cell.contentView addSubview:imageView];
        
        //标题
        UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(15+21+7, 0, WIDTH-15-21-10-10, 40) Font:15 Text:titleArr[indexPath.row]];
        [cell.contentView addSubview:titleLabel];
        titleLabel.textColor=CREATECOLOR(51, 51, 51, 1);
        
        //右箭头
        UIImageView * arrowImageView=[ZCControl createImageViewWithFrame:CGRectMake(WIDTH-10-7, (40-12)/2, 7, 12) ImageName:@"personal_arrow@2x"];
        [cell.contentView addSubview:arrowImageView];
    }
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            _newsLabel=[ZCControl createLabelWithFrame:CGRectMake(WIDTH-10-7-7-15, (40-15)/2, 15, 15) Font:11 Text:@"9"];
            _newsLabel.layer.cornerRadius=_newsLabel.frame.size.width/2;
            _newsLabel.layer.masksToBounds=YES;
            _newsLabel.font=[UIFont boldSystemFontOfSize:11];
            _newsLabel.textAlignment=NSTextAlignmentCenter;
            _newsLabel.textColor=CREATECOLOR(255, 255, 255, 1);
            _newsLabel.backgroundColor=CREATECOLOR(227, 46, 50, 1);
            [cell.contentView addSubview:_newsLabel];
        }
    }
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 46;
    }
    else {
        return 40;
    }
}


//头部高度
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return PAGESIZE(15.0)+5.0;
    }
    else if (section==2){
        if (HEIGHT>480) {
            return 35.0;
        }
        else{
            return PAGESIZE(15.0);
        }
    }
    else{
        return PAGESIZE(15.0);
    }
}
//尾部高度
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

#pragma mark 用户管理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //我的资料
            PersonalDataViewController * pvc=[[PersonalDataViewController alloc]init];
            pvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:pvc animated:YES];
        }
        else {
            //修改密码
            PersonalPasswordViewController * pvc=[[PersonalPasswordViewController alloc]init];
            pvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:pvc animated:YES];
        }
    }
    else if (indexPath.section==1) {
        if (indexPath.row==0) {
            //系统消息
            PersonalNewsListViewController * pvc=[[PersonalNewsListViewController alloc]init];
            pvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:pvc animated:YES];
        }
        else {
            //清除缓存
            NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            _cacheString = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches/"];
            
            NSString * str = [NSString stringWithFormat:@"清除缓存%.1fM", [self folderSizeAtPath:_cacheString]];
            
            UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
            alertview.tag=3000;
            [alertview show];
        }
    }
    else if (indexPath.section==2) {
        #pragma mark 退出登录
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:@"你确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertview.tag=4000;
        [alertview show];
        
        
    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    #pragma mark 清除缓存
    if (alertView.tag==3000) {
        if (buttonIndex==1) {
            NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:_cacheString];
            for (NSString * p in files) {
                NSError * error;
                NSString * Path = [_cacheString stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
                }
            }
        }
    }
    #pragma mark 退出登录
    else if (alertView.tag==4000) {
        if (buttonIndex==1) {
            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
            [user setObject:@"0" forKey:ISLOGIN];
            [user synchronize];
            
            LoginViewController * lvc=[[LoginViewController alloc]init];
            [self presentViewController:lvc animated:YES completion:^{}];
        }
    }
    
}
//遍历文件夹获得文件夹大小，返回多少M
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
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
        
        //存储头像
        NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString * docDir = [paths objectAtIndex:0];
        if(!docDir) {
            NSLog(@"Documents 目录未找到");
        }
        UIImage * headerImage=mediaInfo.circularEditedImage;
        NSData * imageData=UIImagePNGRepresentation(headerImage);
        NSString * filePath = [docDir stringByAppendingPathComponent:@"userHeader.png"];
        [imageData writeToFile:filePath atomically:YES];
    }
}
- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark 健康档案
-(void)healthButtonClick
{
    PersonalHealthListViewController * pvc=[[PersonalHealthListViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pvc animated:YES];
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
