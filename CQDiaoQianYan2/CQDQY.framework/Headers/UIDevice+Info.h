//
//  UIDevice+Info.h
//  SoundRecord
//
//  Created by chuangqi on 2017/5/12.
//  Copyright © 2017年 chuangqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Info)

/**
 * 获取UUID并保存到keychain
 */
+ (NSString *)getUUID;


#pragma mark -- 用户设备信息

/**
 * 获取iPhone的名字
 */
+ (NSString *)getDeviceName;
/**
 * 获取设备的类型 e.g. iPhone Or iPod touch..
 */
+ (NSString *)getDeviceModel;
/**
 * 获取设备的型号标识符 e.g. iPhone6,2
 */
+ (NSString *)getDeviceModelID;
/**
 * 获取iPhone系统版本号 e.g. 9.3.1
 */
+ (NSString *)getDeviceSystemVersion;
/**
 * 获取电池电量 e.g. 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown
 */
+ (NSInteger)getDeviceBatteryLevel;
/**
 * 获取电池的状态  e.g. unkonw-未知, nplugged-未充电, charging-充电中未满, full-充电且充满
 */
+ (UIDeviceBatteryState)getDeviceBatteryStatus;
/**
 * 获取设备方向
 */
+ (UIDeviceOrientation)getDeviceOrientation;

#pragma mark --


@end
