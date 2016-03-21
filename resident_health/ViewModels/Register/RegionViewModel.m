//
//  RegionViewModel.m
//  resident_health
//
//  Created by 赵晓东 on 15/12/16.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "RegionViewModel.h"

@implementation RegionViewModel

//下载数据
-(void) RegionData
{
    NSDictionary * parameter = @{@"parentld":@"000000000"};
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    //发送请求
    [manager GET:RegionHttp parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
}

@end
