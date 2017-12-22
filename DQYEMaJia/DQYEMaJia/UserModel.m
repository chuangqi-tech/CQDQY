//
//  UserModel.m
//  RecordShine
//
//  Created by zhao on 2017/10/26.
//  Copyright © 2017年 chuangqish. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

// encoder
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.inviter_id forKey:@"inviter_id"];
    [encoder encodeInteger:self.device_id forKey:@"device_id"];
    [encoder encodeInteger:self.user_id forKey:@"user_id"];
    [encoder encodeInteger:self.networkStatus forKey:@"networkStatus"];
    
    [encoder encodeBool:self.isJailBreak forKey:@"isJailBreak"];
    [encoder encodeBool:self.isInstalledSIMCard forKey:@"isInstalledSIMCard"];
    
    [encoder encodeObject:self.udid forKey:@"udid"];
    [encoder encodeObject:self.idfa forKey:@"idfa"];
    [encoder encodeObject:self.installed_apps forKey:@"installed_apps"];
    [encoder encodeObject:self.udid_real forKey:@"udid_real"];
    [encoder encodeObject:self.deviceName forKey:@"deviceName"];
    [encoder encodeObject:self.deviceModel forKey:@"deviceModel"];
    [encoder encodeObject:self.deviceType forKey:@"deviceType"];
    [encoder encodeObject:self.systemVersion forKey:@"systemVersion"];
    [encoder encodeObject:self.wifiSSID forKey:@"wifiSSID"];
    [encoder encodeObject:self.wifiBSSID forKey:@"wifiBSSID"];
    [encoder encodeObject:self.appBundleID forKey:@"appBundleID"];
    [encoder encodeObject:self.appVersion forKey:@"appVersion"];
}

// decoder
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.inviter_id = [decoder decodeIntegerForKey:@"inviter_id"];
        self.device_id = [decoder decodeIntegerForKey:@"device_id"];
        self.user_id = [decoder decodeIntegerForKey:@"user_id"];
        self.networkStatus = [decoder decodeIntegerForKey:@"networkStatus"];
        
        self.isJailBreak = [decoder decodeBoolForKey:@"isJailBreak"];
        self.isInstalledSIMCard = [decoder decodeBoolForKey:@"isInstalledSIMCard"];
        
        self.udid = [decoder decodeObjectForKey:@"udid"];
        self.idfa = [decoder decodeObjectForKey:@"idfa"];
        self.installed_apps = [decoder decodeObjectForKey:@"installed_apps"];
        self.udid = [decoder decodeObjectForKey:@"udid_real"];
        self.deviceName = [decoder decodeObjectForKey:@"deviceName"];
        self.deviceModel = [decoder decodeObjectForKey:@"deviceModel"];
        self.deviceType = [decoder decodeObjectForKey:@"deviceType"];
        self.systemVersion = [decoder decodeObjectForKey:@"systemVersion"];
        self.wifiSSID = [decoder decodeObjectForKey:@"wifiSSID"];
        self.wifiBSSID = [decoder decodeObjectForKey:@"wifiBSSID"];
        self.appBundleID = [decoder decodeObjectForKey:@"appBundleID"];
        self.appVersion = [decoder decodeObjectForKey:@"appVersion"];
    }
    return self;
}


/**
 * 将用户信息存到本地 归档
 */
- (BOOL)userInfoWriteToDocument
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [filePath stringByAppendingPathComponent:@"userInfo.data"];
    return  [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}

/**
 *  解归档 读取用户信息
 */
+ (instancetype)unarchiveUserInfoFromDocument
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [filePath stringByAppendingPathComponent:@"userInfo.data"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


@end
