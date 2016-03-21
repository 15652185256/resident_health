//
//  SiteAddressListModel.h
//  resident_health
//
//  Created by 赵晓东 on 15/9/30.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiteAddressListModel : NSObject
@property(nonatomic,copy)NSString * EastLongitude;
@property(nonatomic,copy)NSString * NorthLatitude;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * descripe;
@property(nonatomic,copy)NSString * panoramaURL;
@property(nonatomic,copy)NSString * imageURL;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * zipCode;
@end
