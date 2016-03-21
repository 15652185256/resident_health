//
//  SearchHistoryNewsViewModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ViewModelClass.h"

@interface SearchHistoryNewsViewModel : ViewModelClass

//请求数据
-(void)SearchHistoryNewsList:(NSString*)type title:(NSString*)title startPage:(NSString*)startPage pageSize:(NSString*)pageSize;

@end
