//
//  UIDevice+Info.m
//  SoundRecord
//
//  Created by chuangqi on 2017/5/12.
//  Copyright © 2017年 chuangqi. All rights reserved.
//

#import "UIDevice+Info.h"
#import <sys/sysctl.h>
#import "NSString+Add.h"

#pragma mark -- KeyChainStore

@interface KeyChainStore : NSObject

// 将UUID保存到钥匙串
+ (void)save:(NSString *)service data:(id)data;
// 读取保存到钥匙串的UUID
+ (id)load:(NSString *)service;
// 删除保存到钥匙串的UUID
+ (void)deleteKeyData:(NSString *)service;

@end


@implementation KeyChainStore

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

// 将UUID保存到钥匙串
+ (void)save:(NSString *)service data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

// 读取保存到钥匙串的UUID
+ (id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try{
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

// 删除保存到钥匙串的UUID
+ (void)deleteKeyData:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end

#pragma mark -- UIDevice

@implementation UIDevice (Info)

// C3988927-611E-4686-AF4D-7B43E1D37C71
+ (NSString *)getUUID
{
    NSString * strUUID = (NSString *)[KeyChainStore load:[NSString getBundleID]];
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //获取UUID
        strUUID = [UIDevice currentDevice].identifierForVendor.UUIDString;
        //将该uuid保存到keychain
        [KeyChainStore save:@"123456" data:strUUID];
    }
    return strUUID;
}

#pragma mark -- 用户设备信息

+ (NSString *)getDeviceName
{
    return [UIDevice currentDevice].name;
}

// 获取设备的类型 e.g. iPhone Or iPod touch..
+ (NSString *)getDeviceModel
{
    return [UIDevice currentDevice].model;
}

// 获取设备的型号标识符  e.g. iPhone6,2
+ (NSString *)getDeviceModelID
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return deviceModel;
}

// 系统版本 9.3.1
+ (NSString *)getDeviceSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

// 电量
+ (NSInteger)getDeviceBatteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    if ([UIDevice currentDevice].batteryLevel == -1) {
        return -1;
    } else {
        return [UIDevice currentDevice].batteryLevel * 100;
    }
}

// 电池状态
+ (UIDeviceBatteryState)getDeviceBatteryStatus
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [UIDevice currentDevice].batteryState;
}

// 获取设备方向
+ (UIDeviceOrientation)getDeviceOrientation
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    return [UIDevice currentDevice].orientation;
}

@end
