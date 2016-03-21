//
//  InformationDiseaseViewController.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/24.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationDiseaseViewController : UIViewController
//文章
@property(nonatomic,copy)void(^newBlock)(NSString*);
//分类
@property(nonatomic,copy)void(^myBlock)(NSString*);
@end
