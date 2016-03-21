//
//  MonitorDataViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "MonitorDataViewModel.h"

@implementation MonitorDataViewModel

//请求数据
-(void)MonitorListData:(NSString*)loginName
{
    NSDictionary * parameter = @{@"loginName":loginName};
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];

    
    //发送请求
    [manager POST:MonitorListDataHttp parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
}

@end
