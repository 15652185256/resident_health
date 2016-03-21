//
//  Validate.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "Validate.h"

@implementation Validate

//验证手机号
+(BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString * phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate * phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//验证密码
+(BOOL)validatePassword:(NSString *)password
{
    //6~10位数字和字母混合
    NSString * passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$";
    NSPredicate * passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

//验证真实姓名
+(BOOL)validateNickname:(NSString *)nickname
{
    NSString * nicknameRegex = @"^[\u4e00-\u9fa5·]{2,}$";
    NSPredicate * passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//验证身份证号
+(BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

@end
