//
//  MonitorListViewController.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/7.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonitorListViewController : UIViewController

@property(nonatomic,copy)NSString * navTitle;//导航标题

-(void)loadMonitorListData;

@end
