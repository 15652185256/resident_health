//
//  Config.h
//  MVVMTest
//

//

#ifndef MVVMTest_Config_h
#define MVVMTest_Config_h

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);

//页面尺寸
#define WIDTH [UIScreen mainScreen].bounds.size.width    //屏幕宽度
#define HEIGHT [UIScreen mainScreen].bounds.size.height  //屏幕高度

#define PAGE_COLUMN     MIN(WIDTH/375, 1)
#define PAGESIZE(NUM)   PAGE_COLUMN*NUM


//自定义颜色
#define CREATECOLOR(ONE,TWO,THREE,FOUR) [UIColor colorWithRed:ONE/255.0 green:TWO/255.0 blue:THREE/255.0 alpha:FOUR]

//登录
#define ISLOGIN @"isLogin"   //是否登录

//注册信息
#define PASSWORD @"customerPsw"       //密码
#define CARDNUMBER @"customerCardId"  //身份证号

//登录接口
#define LoginHttp @"http://192.168.3.170:8080/doc/api/health/loginController/login"

//修改密码
#define UpdatePasswordHttp @"http://192.168.3.170:8080/doc/api/health/loginController/updatePassword"

//用户协议
#define AgreementHttp @"http://192.168.3.170:8080/doc/api/health/agreementController/agreement"

//注册接口
#define RegisterHttp @"http://192.168.3.170:8080/doc/api/health/registerController/register"

//省市区县街道
#define RegionHttp @"http://192.168.3.170:8080/doc/api/health/regionController/searchRegionByParentId"

//资讯头条
#define SearchFirstInfoHttp @"http://192.168.3.170:8080/doc/api/health/informationController/searchFirstInfo"

//新闻列表
#define InformationNewsHttp @"http://192.168.3.170:8080/doc/api/health/informationController/searchInfoList"

//搜索列表
#define SearchHistoryNewsHttp @"http://192.168.3.170:8080/doc/api/health/informationController/searchHistoryInfoList"

//测量指标数据
#define MonitorListDataHttp @"http://192.168.3.170:8080/doc/api/health/monitorController/lastData"

//测量单项指标
#define MonitorDetailDataHttp @"http://192.168.3.170:8080/doc/api/health/monitorController/searchDataByType"

//城管数据
#define SiteDataHttp @"http://192.168.3.170:8080/doc/api/health/siteController/searchSiteList"




//手机验证码
#define SMS_APP_Key @"1048ebe0e57b4"
#define SMS_APP_SECRET @"d67002e7150c1b0dbee09380d0a81517"

#endif
