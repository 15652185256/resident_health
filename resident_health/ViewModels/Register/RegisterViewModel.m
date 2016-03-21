//
//  RegisterViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/11.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "RegisterViewModel.h"
#import "UserModel.h"
@implementation RegisterViewModel

//登录操作
-(void) RegUser
{
    RegisterManager * _regManager=[RegisterManager shareManager];
    
    NSString * gender;
    if ([_regManager.customerGender isEqualToString:@"男"]) {
        gender=@"1";
    } else {
        gender=@"2";
    }
    
    NSDictionary * parameter = @{@"loginName": _regManager.customerCardId,@"password":_regManager.customerPsw,@"name":_regManager.customerName,@"gender":gender,@"birthDate":_regManager.customerBrithday,@"mobile":_regManager.customerPhone,@"provinceId":@"1",@"cityId":@"2",@"areaId":@"3",@"streetId":@"4"};
    
    [NetRequestClass NetRequestLoginRegWithRequestURL:RegisterHttp WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
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
        
        UserModel * _userModel=[[UserModel alloc]init];
        [_userModel setValuesForKeysWithDictionary:result];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:_userModel.areaId forKey:@"areaId"];
        [user setObject:_userModel.birthDate forKey:@"birthDate"];
        [user setObject:_userModel.cityId forKey:@"cityId"];
        [user setObject:_userModel.gender forKey:@"gender"];
        [user setObject:_userModel.loginName forKey:@"loginName"];
        [user setObject:_userModel.mobile forKey:@"mobile"];
        [user setObject:_userModel.name forKey:@"name"];
        [user setObject:_userModel.password forKey:@"password"];
        [user setObject:_userModel.provinceId forKey:@"provinceId"];
        [user setObject:_userModel.streetId forKey:@"streetId"];
        
        [user setObject:@"1" forKey:ISLOGIN];
        [user synchronize];
    }
    
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
