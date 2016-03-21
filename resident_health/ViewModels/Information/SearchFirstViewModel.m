//
//  SearchFirstViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/10.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "SearchFirstViewModel.h"

//头新闻模型
#import "SearchFirstModel.h"

@implementation SearchFirstViewModel

-(void)SearchFirstNewsList:(NSString*)type
{
    NSDictionary * parameter = @{@"type":type};
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
//    [manager GET:SearchFirstInfoHttp parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    
    [NetRequestClass NetRequestGETWithRequestURL:SearchFirstInfoHttp WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        
        [self fetchValueSuccessWithDic:returnValue];
        
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
        
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

#pragma 获取到正确的数据，对正确的数据进行处理
-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue
{
    //对从后台获取的数据进行处理，然后传给ViewController层进行显示
    NSArray * result=returnValue[@"result"];
    
    NSMutableArray * SearchFirstNewsListArray = [[NSMutableArray alloc] initWithCapacity:result.count];
    
    for (int i=0; i<result.count; i++) {
        NSDictionary * dict=result[i];
        
        SearchFirstModel * _searchFirstModel = [[SearchFirstModel alloc] init];
        
        [_searchFirstModel setValuesForKeysWithDictionary:dict];
        
        [SearchFirstNewsListArray addObject:_searchFirstModel];
    }

    self.returnBlock(SearchFirstNewsListArray);
}

#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic: (NSDictionary *) errorDic
{
    self.errorBlock(errorDic);
}

#pragma 对网路异常进行处理
-(void) netFailure
{
    self.failureBlock();
}

@end
