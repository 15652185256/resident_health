//
//  FristMonitorViewController.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/10.
//  Copyright (c) 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FristMonitorViewController : UIViewController

//创建图标
-(void)createFristSXWaveView;

//移除
-(void)removeFristSXWaveView;

//传值
@property(nonatomic,copy)void(^myBlock)(NSString*);

@end
