//
//  SiteAddressListViewController.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/30.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SiteAddressListModel;
@interface SiteAddressListViewController : UIViewController
//传值
@property(nonatomic,copy)void(^myBlock)(SiteAddressListModel*);
@end
