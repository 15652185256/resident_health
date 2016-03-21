//
//  LoginViewModel.m
//  HealthManager
//
//  Created by mac on 15-9-1.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "LoginViewModel.h"

//用户信息模型
#import "UserModel.h"

@implementation LoginViewModel

//登录操作
-(void) LoginSystem
{

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSDictionary * parameter = @{@"loginName":[user objectForKey:@"loginName"],@"password":[user objectForKey:@"password"]};
    
    [NetRequestClass NetRequestLoginRegWithRequestURL:LoginHttp WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
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
    if ([[returnValue objectForKey:@"status"] intValue]==1) {        
        NSDictionary * result=returnValue[@"result"];
        
        UserModel * _userModel=[[UserModel alloc]init];
        [_userModel setValuesForKeysWithDictionary:result];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:_userModel.areaId forKey:@"areaId"];
        [user setObject:_userModel.birthDate forKey:@"birthDate"];
        [user setObject:_userModel.cityId forKey:@"cityId"];
        [user setObject:_userModel.gender forKey:@"gender"];
        [user setObject:_userModel.mobile forKey:@"mobile"];
        [user setObject:_userModel.name forKey:@"name"];
        [user setObject:_userModel.provinceId forKey:@"provinceId"];
        [user setObject:_userModel.streetId forKey:@"streetId"];
        
        [user setObject:@"1" forKey:ISLOGIN];
        [user synchronize];
    }
    
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
