//
//  MonitorDataViewModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ViewModelClass.h"

@interface MonitorDataViewModel : ViewModelClass

//请求数据
-(void)MonitorListData:(NSString*)loginName;

@end
