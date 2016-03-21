//
//  SiteDataViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "SiteDataViewModel.h"

#import "SiteAddressListModel.h"//场馆模型

@implementation SiteDataViewModel

//请求数据
-(void)SiteDataNewsList:(NSString*)title startPage:(NSString*)startPage pageSize:(NSString*)pageSize
{
    NSDictionary * parameter = @{@"title":title,@"startPage":startPage,@"pageSize":pageSize};
    
//    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
//    
//    //发送请求
//    [manager POST:SiteDataHttp parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
    [NetRequestClass NetRequestPOSTWithRequestURL:SiteDataHttp WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        
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
    
    NSMutableArray * SiteDataArray = [[NSMutableArray alloc] initWithCapacity:result.count];
    
    for (int i=0; i<result.count; i++) {
        NSDictionary * dict=result[i];
        
        SiteAddressListModel * _siteAddressListModel = [[SiteAddressListModel alloc] init];
        
        [_siteAddressListModel setValuesForKeysWithDictionary:dict];
        
        [SiteDataArray addObject:_siteAddressListModel];
    }
    
    self.returnBlock(SiteDataArray);
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
