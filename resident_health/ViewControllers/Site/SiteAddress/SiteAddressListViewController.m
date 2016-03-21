//
//  SiteAddressListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/30.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "SiteAddressListViewController.h"

#import "SiteAddressListModel.h"
#import "SiteAddressListTableViewCell.h"

//场馆数据
#import "SiteDataViewModel.h"

@interface SiteAddressListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView * tableView;//新闻列表

@property(nonatomic,retain)NSMutableArray * dataSource;
@end

@implementation SiteAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    
    //设置页面
    [self createView];
}

#pragma mark 设置页面
-(void)createView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*0, 0, WIDTH, HEIGHT-64-46)];
    _tableView.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;//去掉分割线
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[SiteAddressListTableViewCell class] forCellReuseIdentifier:@"ID"];
    
    
    //加载数据
    [self loadData];
}

#pragma mark 加载数据
-(void)loadData
{
//    SiteDataViewModel * _siteDataViewModel=[[SiteDataViewModel alloc]init];
//    [_siteDataViewModel SiteDataNewsList:@"11" startPage:@"1" pageSize:@"15"];
//    
//    [_siteDataViewModel setBlockWithReturnBlock:^(id returnValue) {
//
//        _dataSource = [[NSMutableArray alloc]initWithCapacity:[returnValue count]];
//        [_dataSource addObjectsFromArray:returnValue];
//        
//        [_tableView reloadData];
//        
//    } WithErrorBlock:^(id errorCode) {
//        
//    } WithFailureBlock:^{
//        
//    }];
    
    _dataSource = [[NSMutableArray alloc]init];
    for (int i=1; i<3; i++) {
        if (i==1) {
            SiteAddressListModel * _siteAddressListModel = [[SiteAddressListModel alloc] init];
            _siteAddressListModel.imageURL=@"infor8.jpg";
            _siteAddressListModel.name=@"甘家口智慧社区居民医疗养老健康指导中心";
            _siteAddressListModel.address=@"2015年11月12日，海淀区副区长孟景伟来到位于花园村社区的甘家口智慧社区居民医疗养老健康指导中心视察工作。海淀区经信办主任何建吾，海淀区卫计委副主任张宇光，民政局老龄办主任赵迎春，甘家口街道主任李振山全程陪同视察，市区两届政协委员、医养康（北京）健康管理有限公司董事长余立新对医养康平台运营工作做了介绍。";
            _siteAddressListModel.descripe=@"发展养老服务业，是应对人口老龄化的战略任务，是保证和改善民生的德政工程，也是建设服务型政府的重要内容，有利于满足老年人个性化、多样化的养老服务需求，提升老年人的生活质量与幸福指数；有利于拉动内需、扩大就业，形成服务业发展新的增长点；有利于创新社会管理与服务，维护社会和谐稳定，推进海淀经济社会发展。为加快全区养老服务业的发展，根据《国务院关于加快发展养老服务业的若干意见》（国发〔2013〕35号）和《北京市人民政府关于加快推进养老服务业发展的意见》（京政发〔2013〕32号），结合海淀实际，现提出以下意见。";
            [_dataSource addObject:_siteAddressListModel];
        } else {
            SiteAddressListModel * _siteAddressListModel = [[SiteAddressListModel alloc] init];
            _siteAddressListModel.imageURL=@"infor9.jpg";
            _siteAddressListModel.name=@"花园村智慧社区居民医疗养老健康指导中心";
            _siteAddressListModel.address=@"北京市海淀区人民政府关于加快推进养老服务业发展的意见";
            _siteAddressListModel.descripe=@"1.统筹规划养老服务业发展。将养老服务业发展纳入全区国民经济和社会发展规划，列入服务业重点发展领域，明确发展思路、发展目标、发展方向，形成服务项目供需有效、“9064”服务格局空间布局合理、相互联动，服务设施建设标准、机构土地供应持续、资金投入多元，高、中、低多层次服务保障完善、政策保障有力的发展格局。制定海淀区居家社区（村）养老服务建设实施方案、政府购买服务、养老机构建设与管理等政策和居家、社区养老服务、机构建设标准化实施办法，为养老服务业发展提供支持。各街道（镇）要注重社区（村）公共服务设施建设和社会服务资源整合，如社区卫生、生活、文化、体育、养老院等资源与社区（村）居家养老服务的功能衔接，发挥综合效益，提高服务效率。处理好机构养老服务特性和养老服务需求的关系,重点发展居家养老和社区养老服务,让最有需要的老年人住进养老机构。\n2.加大养老服务业投融资力度。一是发挥财政资金杠杆作用，通过补助投资、运营补贴、以奖代补等方式，撬动更多社会资本参与养老服务业发展。二是加大对公共服务设施建设的投入，重点向社区（村）倾斜。三是探索采取股份制、合作、低偿或无偿提供场地等形式建设不同层次的养老服务设施。四是为低收入失能老年人，失独老年人的长期照料提供基本补贴。五是按总体规划要求和自身实际，建立街（镇）养老服务专项资金保障机制，各街（镇）每年为辖区开展养老服务工作提供必要的经费保障。形成多渠道、全方位的资金投入格局。";
            [_dataSource addObject:_siteAddressListModel];
        }
    }
}

#pragma mark 创建搜索列表
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiteAddressListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    SiteAddressListModel * model=_dataSource[indexPath.row];
    
    [cell configModel:model];
    
    return cell;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiteAddressListModel * model=_dataSource[indexPath.row];
    if (self.myBlock) {
        self.myBlock(model);
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
