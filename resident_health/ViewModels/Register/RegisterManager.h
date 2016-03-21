//
//  RegisterManager.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterManager : NSObject
//头像
@property(nonatomic,retain) UIImage * headerImage;
//手机号码
@property(nonatomic,copy) NSString * customerPhone;
//密码
@property(nonatomic,copy) NSString * customerPsw;
//真实姓名
@property(nonatomic,copy) NSString * customerName;
//性别
@property(nonatomic,copy) NSString * customerGender;
//年月日
@property(nonatomic,copy) NSString * customerBrithday;
//身份证号
@property(nonatomic,copy) NSString * customerCardId;
//省份
@property(nonatomic,copy) NSString * provinceCode;
//地级市
@property(nonatomic,copy) NSString * cityCode;
//县区
@property(nonatomic,copy) NSString * areaCode;
//街道
@property(nonatomic,copy) NSString * streetCode;

+(id)shareManager;
@end
