//
//  Validate.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject

//验证手机号
+(BOOL)validateMobile:(NSString *)mobile;

//验证密码
+(BOOL)validatePassword:(NSString *)password;

//验证真实姓名
+(BOOL)validateNickname:(NSString *)nickname;

//验证身份证号
+(BOOL)validateIdentityCard: (NSString *)identityCard;

@end
