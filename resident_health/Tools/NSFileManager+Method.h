//
//  NSFileManager+Method.h
//  MyFreeLimitProject
//
//  Created by qianfeng on 15-6-8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Method)

//用于判断文件是否超时
-(BOOL)timeOutFileName:(NSString*)name time:(NSTimeInterval)time;

@end
