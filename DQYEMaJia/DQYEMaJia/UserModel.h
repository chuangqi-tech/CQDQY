//
//  UserModel.h
//  RecordShine
//
//  Created by zhao on 2017/10/26.
//  Copyright © 2017年 chuangqish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantString.h"

/**
 * 用户信息模型 用于存储 展示用户信息
 */
@interface UserModel : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger device_id;/**< 设备id*/
@property (nonatomic, assign) NSInteger user_id;/**< 用户id*/
@property (nonatomic, assign) NSInteger inviter_id; /**< 师傅id*/
@property (nonatomic, copy) NSString *udid;/**< UUID*/
@property (nonatomic, copy) NSString *idfa;/**< IFDA*/
@property (nonatomic, copy) NSString *installed_apps;/**< 设备上左右安装的app*/
// 10.2之后新增
@property (nonatomic, copy) NSString *udid_real; /**< 绑定苹果证书后，苹果返回的设备唯一标识*/

/*--------------------------------------------------------------*/

@property (nonatomic, copy) NSString *deviceName;/**< 设备名称*/
@property (nonatomic, copy) NSString *deviceModel;/**< 设备型号标识符 e.g.iPhone6,2*/
@property (nonatomic, copy) NSString *deviceType;/**< 设备类型 iPhone/iPad*/
@property (nonatomic, copy) NSString *systemVersion;/**< 系统版本*/
@property (nonatomic, copy) NSString *wifiSSID;/**< wifi名称*/
@property (nonatomic, copy) NSString *wifiBSSID;/**< Mac地址*/
@property (nonatomic, copy) NSString *appBundleID; /**< bundleID*/
@property (nonatomic, copy) NSString *appVersion; /**< app版本*/

@property (nonatomic, assign) CQNetworkStatus networkStatus; /**< 网络状态*/
@property (nonatomic, assign) BOOL isJailBreak; /**< 是否越狱*/
@property (nonatomic, assign) BOOL isInstalledSIMCard; /**< 是否安装SIM卡*/

/**
 * 将用户信息存到本地 归档
 */
- (BOOL)userInfoWriteToDocument;

/**
 *  解归档 读取用户信息
 */
+ (instancetype)unarchiveUserInfoFromDocument;

@end
