//
//  UserModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/10.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy)NSString * areaId;
@property(nonatomic,copy)NSString * birthDate;
@property(nonatomic,copy)NSString * cityId;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * loginName;
@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * password;
@property(nonatomic,copy)NSString * provinceId;
@property(nonatomic,copy)NSString * streetId;
@end
