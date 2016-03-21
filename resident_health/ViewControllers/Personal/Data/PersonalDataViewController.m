//
//  PersonalDataViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonalDataTableViewCell.h"
//更换头像
#import "FSMediaPicker.h"
//选择器
#import "ZHPickView.h"

@interface PersonalDataViewController ()<UITableViewDataSource,UITableViewDelegate,FSMediaPickerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,ZHPickViewDelegate>
//信息列表
@property(nonatomic,retain)UITableView * tableView;
//头像
@property(nonatomic,retain)FSMediaPicker * mediaPicker;
//头像按钮
@property(nonatomic,retain)UIButton * headerImageButton;
//标题
@property(nonatomic,retain)NSMutableArray * titleArray;
//资料
@property(nonatomic,retain)NSMutableArray * dataArray;
//选择器
@property(nonatomic,retain)ZHPickView * pickview;
@end

@implementation PersonalDataViewController

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
    self.navigationItem.title = @"我的资料";
    
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
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    [_tableView setSeparatorColor:CREATECOLOR(227, 227, 227, 1)];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //加载数据
    [self loadData];
}

#pragma mark 加载数据
-(void)loadData
{
    NSArray * titleArr1=@[@"头像",@"姓名",@"性别",@"出生日期",@"身份证号码"];
    NSArray * titleArr2=@[@"手机号",@"所在区域"];
    
    _titleArray=[NSMutableArray arrayWithObjects:titleArr1,titleArr2,nil];
    
//    //用户
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    
//    NSString * sex;
//    if ([[user objectForKey:@"gender"] intValue]==1) {
//        sex=@"男";
//    } else {
//        sex=@"女";
//    }
//    
//    NSArray * dataArr1=@[@"",[user objectForKey:@"name"],sex,[user objectForKey:@"birthDate"],[user objectForKey:@"loginName"]];
//    NSArray * dataArr2=@[[user objectForKey:@"mobile"],[NSString stringWithFormat:@"%@ %@",[user objectForKey:@"provinceCode"],[user objectForKey:@"cityCode"]]];
    
    NSArray * dataArr1=@[@"",@"赵晓东",@"男",@"1991-03-09",@"142729199103091211"];
    NSArray * dataArr2=@[@"15652185256",@"山西省 运城市"];
    
    _dataArray=[NSMutableArray arrayWithObjects:dataArr1,dataArr2, nil];
    
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
    PersonalDataTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell=[[PersonalDataTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //标题
    NSArray * titleArr=_titleArray[indexPath.section];
    cell.textLabel.text=titleArr[indexPath.row];
    cell.textLabel.textColor=CREATECOLOR(51, 51, 51, 1);
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    
    //右箭头
    UIImageView * arrowImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, 0, 0) ImageName:@"personal_arrow@2x"];
    [cell.contentView addSubview:arrowImageView];

    //内容
    NSArray * dataArr=_dataArray[indexPath.section];

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //头像
            _headerImageButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-10-7-10-58, (78-58)/2, 58, 58) Text:nil ImageName:nil bgImageName:@"reg_header_bg_image" Target:self Method:@selector(headerImageButtonClick:)];
            _headerImageButton.layer.cornerRadius=_headerImageButton.frame.size.width/2;
            _headerImageButton.layer.masksToBounds=YES;
            [cell.contentView addSubview:_headerImageButton];
            
            NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString * docDir = [paths objectAtIndex:0];
            NSString * filePath = [docDir stringByAppendingPathComponent:@"userHeader.png"];
            UIImage * header_image=[UIImage imageWithContentsOfFile:filePath];
            [_headerImageButton setImage:header_image forState:UIControlStateNormal];
            
            arrowImageView.frame=CGRectMake(WIDTH-10-7, (77-12)/2, 7, 12);
        }
        else{
            arrowImageView.frame=CGRectMake(WIDTH-10-7, (40-12)/2, 7, 12);
            [cell configModel:dataArr[indexPath.row]];
        }
    }
    else{
        arrowImageView.frame=CGRectMake(WIDTH-10-7, (40-12)/2, 7, 12);
        [cell configModel:dataArr[indexPath.row]];
    }
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 78;
        }
        else{
            return 40;
        }
    }
    else{
        return 40;
    }
}


//头部高度
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return PAGESIZE(15.0)+5;
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
                //手机号
                //[self createAlertViewStr:@"请输入手机号" tag:indexPath.row];
                
                break;
            case 1:
                //所在区域
            {
//                [_pickview remove];
//                
//                _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO];
//                
//                _pickview.tag=1000;
//                
//                _pickview.delegate=self;
//                
//                [_pickview show];
            }
                break;
            default:
                break;
        }
    }
}


-(void)createAlertViewStr:(NSString*)str tag:(NSInteger)tag{
    UIAlertView * al=[[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    al.alertViewStyle=UIAlertViewStylePlainTextInput;
    al.tag=tag;
    [al show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    UITextField*text=[alertView textFieldAtIndex:0];
    if (text.text.length==0) {
        return;
    }
    
    switch (alertView.tag) {
        case 1:
            //昵称

            break;
        case 2:
            //签名

            break;
        case 4:
            //地区

            break;
        case 6:
            //手机号

            break;
        default:
            break;
    }
}


#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (pickView.tag==1000) {
        
        NSArray * strArray=[resultString componentsSeparatedByString:@"|"];
        
        //用户
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        [user setObject:strArray[0] forKey:@"provinceCode"];
        [user setObject:strArray[1] forKey:@"cityCode"];
        
        [user synchronize];
        
        [self loadData];
    }
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
