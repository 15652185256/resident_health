//
//  UpdatePasswordViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/10.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "UpdatePasswordViewModel.h"

@implementation UpdatePasswordViewModel

//登录操作
-(void) UpdatePassword:(NSString*)loginName oldPassword:(NSString*)oldPassword password:(NSString*)password
{
    NSDictionary * parameter = @{@"loginName":loginName,@"oldPassword":oldPassword,@"password":password};
    
    [NetRequestClass NetRequestLoginRegWithRequestURL:UpdatePasswordHttp WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
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
    self.returnBlock(returnValue);
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
