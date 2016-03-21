//
//  RegisterManager.m
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import "RegisterManager.h"
static RegisterManager * manager=nil;
@implementation RegisterManager
+(id)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[RegisterManager alloc]init];
    });
    return manager;
}
@end
