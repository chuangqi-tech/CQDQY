//
//  ConstantString.h
//  DQYMaJia
//
//  Created by zhao on 22/12/2017.
//  Copyright © 2017 chuangqish. All rights reserved.
//

#import <UIKit/UIKit.h>

// 屏幕尺寸
#define DQYSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define DQYSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, CQNetworkStatus) {
    
    CQNetworkStatusUnknow = 0, // 未知
    CQNetworkStatus2G, // 2G
    CQNetworkStatus3G, // 3G
    CQNetworkStatus4G, // 4G
    CQNetworkStatusWifi, // wifi
};

typedef NS_ENUM(NSInteger, SIMCarrierName){
    
    SIMCarrierNameUnknow = -1, // 未安装SIM卡
    SIMCarrierNameChinaMobile = 0, // 中国移动
    SIMCarrierNameChinaUnicon, //中国联通
    SIMCarrierNameChinaTelecom, // 中国电信
};

/**
 * 字符串常量类
 */
@interface ConstantString : NSObject

// bugly
UIKIT_EXTERN NSString * const kBuglyAppKey;
UIKIT_EXTERN NSString * const kBuglyAppID;

#pragma mark -- API

UIKIT_EXTERN NSString * const kBaseURL;
UIKIT_EXTERN NSString * const kSocketServerHost; /**< socket的host*/
UIKIT_EXTERN NSString * const kIsShowDiaoQianYanerVCApi; /**< 是否展示掉钱眼儿界面*/
UIKIT_EXTERN NSString * const kFetchUserInfoApi; /**< 获取用户信息*/
UIKIT_EXTERN NSString * const kRegisterApi; /**< 注册*/
UIKIT_EXTERN NSString * const kCertificateApi; /**< 10.2版本获取证书*/
UIKIT_EXTERN NSString * const kUpdateDeviceInfoApi; /**< 更新用户信息*/
UIKIT_EXTERN NSString * const kBindInviterIDApi; /**< 绑定师傅ID*/

// 通知名
UIKIT_EXTERN NSString * const kLocalNotificationName;

// umeng
UIKIT_EXTERN NSString * const kUMengAppKey;

// talkingData
UIKIT_EXTERN NSString * const kTalkingDataAppID;

// share
UIKIT_EXTERN NSString * const kShareSDKAppKey;
UIKIT_EXTERN NSString * const kShareSDKAppSecret;
UIKIT_EXTERN NSString * const kQQAppID;
UIKIT_EXTERN NSString * const kQQAppKey;
UIKIT_EXTERN NSString * const kSinaWeiBoAppKey;
UIKIT_EXTERN NSString * const kSinaWeiBoAppSecret;
UIKIT_EXTERN NSString * const kWeChatAppID;
UIKIT_EXTERN NSString * const kWeChatAppSecret;

@end
