//
//  InformationNewsListViewModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/10.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ViewModelClass.h"

@interface InformationNewsListViewModel : ViewModelClass

//请求数据
-(void)InformationNewsList:(NSString*)type title:(NSString*)title startPage:(NSString*)startPage pageSize:(NSString*)pageSize;

@end
