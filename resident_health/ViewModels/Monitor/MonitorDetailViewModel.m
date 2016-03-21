//
//  MonitorDetailViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "MonitorDetailViewModel.h"

//监测列表模型
#import "MonitorListModel.h"

@implementation MonitorDetailViewModel

-(void)MonitorDetailData:(NSString*)loginName type:(NSString*)type year:(NSString*)year month:(NSString*)month
{
    NSDictionary * parameter = @{@"loginName":loginName,@"type":type,@"year":year,@"month":month};
    
//    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
//    
//    //发送请求
//    [manager POST:MonitorDetailDataHttp parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
    
    [NetRequestClass NetRequestPOSTWithRequestURL:MonitorDetailDataHttp WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        
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
    
    
    
    if ([[returnValue objectForKey:@"status"] intValue]==1) {
        
        NSDictionary * result=returnValue[@"result"];
        
        self.returnBlock(result);
    }
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
