//
//  MonitorDetailViewModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ViewModelClass.h"

@interface MonitorDetailViewModel : ViewModelClass

//请求数据
-(void)MonitorDetailData:(NSString*)loginName type:(NSString*)type year:(NSString*)year month:(NSString*)month;

@end
