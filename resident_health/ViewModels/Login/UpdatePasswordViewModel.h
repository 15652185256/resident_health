//
//  UpdatePasswordViewModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/10.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ViewModelClass.h"

@interface UpdatePasswordViewModel : ViewModelClass

//登录操作
-(void) UpdatePassword:(NSString*)loginName oldPassword:(NSString*)oldPassword password:(NSString*)password;

@end
