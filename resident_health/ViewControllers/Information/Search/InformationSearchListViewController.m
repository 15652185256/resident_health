//
//  InformationSearchListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "InformationSearchListViewController.h"

#import "DWTagList.h"//自定义标签

#import "InformationSearchListModel.h"
#import "InformationSearchListTableViewCell.h"

//搜索数据
#import "SearchHistoryNewsViewModel.h"


@interface InformationSearchListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

//搜索关键字
@property(nonatomic,retain)UITextField * searchTextField;

@property(nonatomic,retain)UIScrollView * rootScrollView;//主页

@property(nonatomic,retain)UITableView * tableView;//搜索列表

@property(nonatomic,retain)NSMutableArray * searchArray;

//取消
@property(nonatomic,retain)UIButton * returnButton;
//确定
@property(nonatomic,retain)UIButton * sureButton;

@end

@implementation InformationSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    self.historyDict=[[NSMutableDictionary alloc] init];
    
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
    
    //设置搜索框
    UIImageView * searchImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 14+12+4)];
    UIImageView * searchNameImageView=[ZCControl createImageViewWithFrame:CGRectMake(12, (30-14)/2+1, 14, 14) ImageName:@"nav_textField_search@2x"];
    [searchImageView addSubview:searchNameImageView];
    
    _searchTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, 0, WIDTH-80, 30) placeholder:@"搜索资讯" passWord:NO leftImageView:searchImageView rightImageView:nil Font:PAGESIZE(17) backgRoundImageName:nil];
    _searchTextField.font=[UIFont systemFontOfSize:15];
    _searchTextField.backgroundColor=CREATECOLOR(255, 255, 255, 1);
    _searchTextField.textColor=CREATECOLOR(164, 196, 28, 1);
    _searchTextField.layer.masksToBounds = YES ;
    _searchTextField.layer.cornerRadius =15;
    [_searchTextField setValue:CREATECOLOR(164, 196, 28, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_searchTextField addTarget:self action:@selector(searchTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    _searchTextField.delegate=self;
    _searchTextField.returnKeyType=UIReturnKeySearch;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_searchTextField];
    
    //取消按钮
    _returnButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 40, 44) Text:@"取消" ImageName:nil bgImageName:nil Target:self Method:@selector(returnButtonClick)];
    [_returnButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _returnButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_returnButton];
    
    //确定按钮
    _sureButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 40, 44) Text:@"确定" ImageName:nil bgImageName:nil Target:self Method:@selector(sureButtonClick)];
    [_sureButton setTitleColor:CREATECOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    _sureButton.titleLabel.font=[UIFont systemFontOfSize:15];

    
    //收起键盘
    UITapGestureRecognizer * tapRoot = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRootAction)];
    //设置点击次数
    tapRoot.numberOfTapsRequired = 1;
    //设置几根胡萝卜有效
    tapRoot.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapRoot];
}


//UITextField值变化
-(void)searchTextFieldChanged
{
    if ([_searchTextField.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_returnButton];
    }
    else{
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_sureButton];
    }
}

//返回
-(void)returnButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



//搜索
-(void)sureButtonClick
{
    //让输入框放弃第一响应着的身份，收起键盘
    [_searchTextField resignFirstResponder];
    
    if (![_searchTextField.text isEqualToString:@""]) {
        
        //搜索历史记录
        [self.historyDict setObject:@"title" forKey:_searchTextField.text];
        
        NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString * docDir = [paths objectAtIndex:0];
        [self.historyDict writeToFile:[docDir stringByAppendingPathComponent:@"/searchHistory.plist"] atomically:YES];
        
        
        [_rootScrollView removeFromSuperview];
        
        [self.view addSubview:_tableView];
        //加载数据
        [self loadData:_searchTextField.text];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_returnButton];
    }
}



//收起键盘
-(void)tapRootAction
{
    //让输入框放弃第一响应着的身份，收起键盘
    [_searchTextField resignFirstResponder];
}

//搜索查询
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == _searchTextField) {
        //让输入框放弃第一响应着的身份，收起键盘
        [theTextField resignFirstResponder];
        
        if (![theTextField.text isEqualToString:@""]) {
            
            [_rootScrollView removeFromSuperview];
            
            [self.view addSubview:_tableView];
            //加载数据
            [self loadData:_searchTextField.text];
            
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_returnButton];
        }
    }
    
    return YES;
}




#pragma mark 设置页面
-(void)createView
{
    _rootScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [self.view addSubview:_rootScrollView];
    [self createRootScrollView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    //[self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[InformationSearchListTableViewCell class] forCellReuseIdentifier:@"ID"];
    
}

#pragma mark 创建 搜索历史 热搜 页面
-(void)createRootScrollView
{
    //搜索历史
    UILabel * historyLabel=[ZCControl createLabelWithFrame:CGRectMake(10, 22, 100, 14) Font:14 Text:@"搜索历史"];
    [_rootScrollView addSubview:historyLabel];
    historyLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    
    //清空搜索历史
    UIButton * deleteSearchHistoryButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-30, 22, 15, 15) Text:nil ImageName:@"delete_search_news@2x" bgImageName:nil Target:self Method:@selector(deleteSearchHistoryButtonClick)];
    [_rootScrollView addSubview:deleteSearchHistoryButton];
    
    //分割线
    UIView * lineView1=[ZCControl createView:CGRectMake(10, CGRectGetMaxY(historyLabel.frame)+15/2, WIDTH-20, 1)];
    [_rootScrollView addSubview:lineView1];
    lineView1.backgroundColor=CREATECOLOR(214, 214, 214, 1);
    
    DWTagList * historyTagList = [[DWTagList alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView1.frame)+17, WIDTH-20, 50)];
    [_rootScrollView addSubview:historyTagList];
    //读取本地搜索历史
    NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * docDir = [paths objectAtIndex:0];
    NSDictionary * titleDict=[NSDictionary dictionaryWithContentsOfFile:[docDir stringByAppendingPathComponent:@"/searchHistory.plist"]];
    NSArray * keysArray=[titleDict allKeys];
    //重新记录
    [self.historyDict addEntriesFromDictionary:titleDict];
    
    //NSLog(@"%@",[docDir stringByAppendingPathComponent:@"/searchHistory.plist"]);
    
    CGFloat historyTagListHeight = [historyTagList setTags:keysArray];
    historyTagList.frame=CGRectMake(10, CGRectGetMaxY(lineView1.frame)+17, WIDTH-20, historyTagListHeight);
    
    historyTagList.myBlock=^(NSInteger tag){
        [_rootScrollView removeFromSuperview];
        
        [self.view addSubview:_tableView];
        
        //加载数据
        [self loadData:keysArray[tag]];
    };
    
    
    
    //关键词
    UILabel * keywordLabel=[ZCControl createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(historyTagList.frame)+17, 100, 14) Font:14 Text:@"热搜关键字"];
    [_rootScrollView addSubview:keywordLabel];
    keywordLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    
    UIView * lineView2=[ZCControl createView:CGRectMake(10, CGRectGetMaxY(keywordLabel.frame)+15/2, WIDTH-20, 1)];
    [_rootScrollView addSubview:lineView2];
    lineView2.backgroundColor=CREATECOLOR(214, 214, 214, 1);
    
    DWTagList * keywordTagList = [[DWTagList alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView2.frame)+17, WIDTH-20, 50)];
    [_rootScrollView addSubview:keywordTagList];
    NSArray * keywordArray = [[NSArray alloc] initWithObjects:@"疾病预防", @"妇幼保健", nil];
    CGFloat keywordTagListHeight = [keywordTagList setTags:keywordArray];
    keywordTagList.frame=CGRectMake(10, CGRectGetMaxY(lineView2.frame)+17, WIDTH-20, keywordTagListHeight);
    
    keywordTagList.myBlock=^(NSInteger tag){
        [_rootScrollView removeFromSuperview];
        
        [self.view addSubview:_tableView];
        //加载数据
        [self loadData:keywordArray[tag]];
    };
    
    //设置滚动范围
    _rootScrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(historyTagList.frame)+40 );
    //禁用滚动条,防止缩放还原时崩溃
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.bounces = NO;
}


//清空搜索历史
-(void)deleteSearchHistoryButtonClick
{
    [self.historyDict removeAllObjects];
    
    NSArray  * paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * docDir = [paths objectAtIndex:0];
    [self.historyDict writeToFile:[docDir stringByAppendingPathComponent:@"/searchHistory.plist"] atomically:YES];
    
    [_rootScrollView removeFromSuperview];
    
    [self createView];
}


#pragma mark 请求搜索数据
-(void)loadData:(NSString*)title
{
    _searchArray = [[NSMutableArray alloc]init];
    for (char c = 'A'; c<='B'; c++) {
        NSMutableArray * array = [[NSMutableArray alloc]init];
        for (int i = 0; i< 3; i++) {
            NSString * string;
            NSString * string1;
            if (c=='A') {
                switch (i) {
                    case 0:
                        string=@"预防颈椎病的健身动作有哪些？";
                        string1=@"2015-09-16";
                        break;
                    case 1:
                        string=@"入秋后当心6大常见病";
                        string1=@"2015-09-09";
                        break;
                    case 2:
                        string=@"7种最容易转化成癌症的小疾病";
                        string1=@"2015-09-03";
                        break;
                    default:
                        break;
                }
            }
            else if(c=='B'){
                switch (i) {
                    case 0:
                        string=@"糖尿病患者要运动";
                        string1=@"2015-09-30";
                        break;
                    case 1:
                        string=@"糖尿病人体检不可忽略的6个项目";
                        string1=@"2015-09-24";
                        break;
                    case 2:
                        string=@"老人突然变瘦 或是糖尿病驾到";
                        string1=@"2015-09-12";
                        break;
                    default:
                        break;
                }
            }
            
            InformationSearchListModel * model = [[InformationSearchListModel alloc] init];
            model.title=string;
            model.publishTime=string1;
            
            [array addObject:model];
        }
        [_searchArray addObject:array];
    }
    
}

#pragma mark 创建搜索列表
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _searchArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = [_searchArray objectAtIndex:section];
    return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationSearchListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    NSArray * array = [_searchArray objectAtIndex:indexPath.section];
    InformationSearchListModel * model=array[indexPath.row];
    
    [cell configModel:model];
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 9+14+6+12+9;
}

//头标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView=[ZCControl createView:CGRectMake(0, 0, WIDTH, 40)];
    bgView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    UILabel * titleLabel=[ZCControl createLabelWithFrame:CGRectMake(15, 40-14-8, WIDTH-15-10, 14) Font:14 Text:nil];
    [bgView addSubview:titleLabel];
    titleLabel.textColor=CREATECOLOR(153, 153, 153, 1);
    
    if (section==0) {
        titleLabel.text=@"健康课堂";
    }
    else{
        titleLabel.text=@"疾病百科";
    }
    
    UIView * BottomLineView=[ZCControl createView:CGRectMake(15, 40-0.5, WIDTH-15, 0.5)];
    [bgView addSubview:BottomLineView];
    BottomLineView.backgroundColor=CREATECOLOR(214, 214, 214, 1);
    
    return bgView;
}

// 设置头标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
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
