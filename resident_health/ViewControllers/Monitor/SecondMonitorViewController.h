//
//  SecondMonitorViewController.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondMonitorViewController : UIViewController

//创建图标
-(void)createSecondSXWaveView;
//移除图标
-(void)removeSecondSXWaveView;

//传值
@property(nonatomic,copy)void(^myBlock)(NSString*);

@end
