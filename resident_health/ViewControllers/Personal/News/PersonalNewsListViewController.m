//
//  PersonalNewsListViewController.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "PersonalNewsListViewController.h"
#import "PersonalNewsListModel.h"
#import "PersonalNewsListTableViewCell.h"

#import "PersonalNewsDetailViewController.h"//消息详情

@interface PersonalNewsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView * tableView;//新闻列表

@property(nonatomic,retain)NSMutableArray * dataSource;


//为了去删除多选的内容,那么在准备两个数组
//一个数组用来装删除的数据,
@property(nonatomic,retain)NSMutableArray * deleteData;//这个用来删除数据源用
//另一个数组用来装删除数据的indexPath
@property(nonatomic,retain)NSMutableArray * deleteIndexPath;//用来刷新使用
@end

@implementation PersonalNewsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=CREATECOLOR(246, 246, 246, 1);
    //设置导航
    [self createNav];
    //准备数据
    [self prepareDataSource];
    //设置页面
    [self prepareTableView];
    //备编辑按钮
    [self prepareEditButton];
}

#pragma mark 设置导航
-(void)createNav
{
    //设置导航不透明
    self.navigationController.navigationBar.translucent=NO;
    
    //设置导航的标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CREATECOLOR(255, 255, 255, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationItem.title = @"系统消息";
    
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


#pragma mark 准备数据
-(void)prepareDataSource
{
    _dataSource = [[NSMutableArray alloc]init];
    _deleteData = [[NSMutableArray alloc]init];
    _deleteIndexPath = [[NSMutableArray alloc]init];
    for (int i = 0; i< 9; i++) {
        NSString * string = [NSString stringWithFormat:@"第 %d 条信息",i+1];
        NSString * string1 = [NSString stringWithFormat:@"会议指出，学生资助管理信息系统是教育管理信息化的重要组成部分，也是各级教育部门和学校管理学生资助信息的重要平台。各级资助管理机构要从规范学生资助业务、加强资助信息监管、提高资助决策与服务能力等角度来审视中职资助管理新系统的重要地位和作用。会议明确提出了“精心组织，确保中职资助管理新系统应用工作落到实处”的总要求，特别强调了系统建设要做到“三个到位”和处理好“三个关系”的具体要求，即组织要到位、培训要到位、系统应用要到位；处理好中职新系统与旧系统的关系、处理好资助系统与学籍系统的关系、处理好信息化管理手段与常规管理手段的关系。"];
        NSString * string2 = [NSString stringWithFormat:@"2015/9/16"];
        
        PersonalNewsListModel * model = [[PersonalNewsListModel alloc] init];
        model.title=string;
        model.detail=string1;
        model.postTime=string2;
        
        [_dataSource addObject:model];
    }
}


#pragma mark 设置页面
-(void)prepareTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[PersonalNewsListTableViewCell class] forCellReuseIdentifier:@"ID"];
    [self.view addSubview:_tableView];
    
    //去掉多余cell分割线
    [self setExtraCellLineHidden:self.tableView];
    
    //如果想要在非编辑状态下多选单元格话,需要设置
    //_tableView.allowsMultipleSelection = YES;
    
}


#pragma mark 设备编辑按钮
-(void)prepareEditButton
{
    //准备编辑按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title=@"编辑";
    self.navigationController.navigationBar.tintColor = CREATECOLOR(255, 255, 255, 1);
    
    //准备编辑视图,上面加一个删除的按钮
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-64, WIDTH, 40)];
    view.backgroundColor = CREATECOLOR(255, 255, 255, 1);
    view.tag = 1000;
    
    UIView * topView=[ZCControl createView:CGRectMake(0, 0, WIDTH, 0.5)];
    view.backgroundColor = CREATECOLOR(227, 227, 227, 1);
    [view addSubview:topView];

    
    UIButton * deleteButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, WIDTH, 40) Text:@"删除" ImageName:nil bgImageName:nil Target:self Method:@selector(deleteButtonClick:)];
    deleteButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [deleteButton setTitleColor:CREATECOLOR(153, 153, 153, 1) forState:UIControlStateNormal];
    [view addSubview:deleteButton];
    //因为上来没有东西可删,所以先禁用按钮
    deleteButton.enabled = NO;
    deleteButton.tag = 2000;
    
    [self.view addSubview:view];
}
//清除所有的选中数据
-(void)clearSelectData
{
    [_deleteData removeAllObjects];
    [_deleteIndexPath removeAllObjects];
}

//这个是删除按钮的响应方法
-(void)deleteButtonClick:(UIButton *)button
{
    //首先在数据源里删除数据
    [_dataSource removeObjectsInArray:_deleteData];
    //刷新表格
    [_tableView deleteRowsAtIndexPaths:_deleteIndexPath withRowAnimation:UITableViewRowAnimationMiddle];
    
    //因为删除后,数据源中就没有这此已经删除的数据了,为了防止程序在下一次删除时,删除到非法数据,所以要将数据清空
    [self clearSelectData];
    
    //删除之后,让按钮变灰
    if (_deleteData.count == 0) {
        UIButton * button = (UIButton *)[self.view viewWithTag:2000];
        [button setTitleColor:CREATECOLOR(153, 153, 153, 1) forState:UIControlStateNormal];
        button.enabled = NO;
    }
    
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
    
    if (editing) {
        self.editButtonItem.title=@"取消";
    }
    else {
        self.editButtonItem.title=@"编辑";
    }
    
    //设置一个动画,来根据是否在编辑状态,然后让删除条出现或隐藏
    UIView * view = [self.view viewWithTag:1000];
    //因为要在block里去修改center的值,因为center是一个局部变量,
    //所以默认在block里,是不允许操作修改的,那么,如果要完成目标操作,那么在center前加一个 __block来修饰一下
    __block CGPoint center = view.center;
    if (editing) {
        [UIView animateWithDuration:0.3 animations:^{
            center.y -= 40;
            view.center = center;
        }];
        
        //在这里去加一个清空操作,因为,可以选中但不做任何操作,那么为了防止下一次再操作时崩掉,清掉所有数据
        [self clearSelectData];
        
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            center.y += 40;
            view.center = center;
        }];
    }
}




#pragma mark - 编辑方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark - 选中单元格的方法
//选中单元格的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView.editing) {
        //先找到单元格对应的数据
        PersonalNewsListModel * model = [_dataSource objectAtIndex:indexPath.row];
        [_deleteData addObject:model];
        [_deleteIndexPath addObject:indexPath];
        if (_deleteData.count != 0) {
            UIButton * button = (UIButton *)[self.view viewWithTag:2000];
            [button setTitleColor:CREATECOLOR(165, 197, 29, 1) forState:UIControlStateNormal];
            button.enabled = YES;
        }
        
    }
    else{
        //消息详情
        PersonalNewsDetailViewController * pvc=[[PersonalNewsDetailViewController alloc]init];
        pvc.hidesBottomBarWhenPushed=YES;
        PersonalNewsListModel * model=_dataSource[indexPath.row];
        pvc.navTitle=model.title;
        [self.navigationController pushViewController:pvc animated:YES];
    }
}
//取消选中单元格的方法,反选
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView.editing) {
        PersonalNewsListModel * model = [_dataSource objectAtIndex:indexPath.row];
        if ([_deleteData containsObject:model]) {
            [_deleteData removeObject:model];
            [_deleteIndexPath removeObject:indexPath];
            if (_deleteData.count == 0) {
                UIButton * button = (UIButton *)[self.view viewWithTag:2000];
                [button setTitleColor:CREATECOLOR(153, 153, 153, 1) forState:UIControlStateNormal];
                button.enabled = NO;
            }
        }
    }
}

#pragma mark - 必选方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalNewsListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    PersonalNewsListModel * model=_dataSource[indexPath.row];
    [cell configModel:model];
    return cell;
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//去掉多余cell分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
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
