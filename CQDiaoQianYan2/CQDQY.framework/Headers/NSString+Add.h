//
//  NSString+Add.h
//  SoundRecord
//
//  Created by chuangqi on 2017/6/15.
//  Copyright © 2017年 chuangqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantString.h"

@interface NSString (Add)

#pragma mark -- 设备唯一ID
/**
 * 获取UDID
 */
+ (NSString *)getUDID;
/**
 * 获取广告标识符
 */
+ (NSString *)getIDFA;
+ (NSString *)getIDFV;

#pragma mark -- app信息

/**
 * 获取app的BundleID
 */
+ (NSString *)getBundleID;
/**
 * 获取app的名字
 */
+ (NSString *)getAppName;
/**
 * 获取app版本号
 */
+ (NSString *)getAppVersion;
/**
 * 获取app Build号
 */
+ (NSString *)getAppBuild;

#pragma mark --
/**
 * 获取设备屏幕亮度 e.g. 0 .. 1.0
 */
+ (NSInteger)getScreenBrightness;

/**
 * 获取磁盘的总容量 MB
 */
+ (float)getTotalDiskCapacity;
/**
 * 获取未使用的磁盘的容量 MB
 */
+ (float)getFreeDiskCapacity;


#pragma mark -- 网络

/**
 * 获取网络状态
 *
 * @warning 使用时一定要保证statusbar没有隐藏
 */
+ (CQNetworkStatus)getNetworkStatus;

/**
 * 获取Wifi的信号强度
 */
+ (NSInteger)getWifiSignalStrength;

/**
 * 获取WiFi的SSID 也就是WiFi名称
 */
+ (NSString *)getWifiSSID;

/**
 * 获取WiFi的BSSID 也就是Mac地址
 */
+ (NSString *)getWifiBSSID;

/**
 * 是否安装SIM卡
 */
+ (BOOL)isInstallSIMCard;

/**
 * 获取SIM卡的运营商 e.g. 移动 电信 联通
 */
+ (SIMCarrierName)getSIMCarrierName;

/**
 * 获取运营商信号强度
 */
+ (int)getSIMSignalStrength;

#pragma mark --

/**
 * 判断iPhone设备是否越狱
 */
+ (BOOL)isJailBreak;

#pragma mark --
/**
 * 用bundleID判断是否安转此app
 *
 * @param bundleID 唯一标记
 */
+ (BOOL)isInstalledWithBundleID:(NSString *)bundleID;

/**
 * 用bundleID打开设备上安装的app
 *
 * @param bundleID 唯一标记
 */
+ (BOOL)openAppWithBundleID:(NSString *)bundleID;

/**
 * 是否重复安装
 *
 * @param bundleID 唯一标记
 */
+ (BOOL)isPurchasedReDownloadWithBundleID:(NSString *)bundleID;

/**
 * 获取手机上已安装的所有app的bundleID
 */
+ (NSString *)fetchAllInstalledAppBundleID;

@end
