//
//  NSString+Add.m
//  SoundRecord
//
//  Created by chuangqi on 2017/6/15.
//  Copyright © 2017年 chuangqi. All rights reserved.
//

#import "NSString+Add.h"
#import <AdSupport/AdSupport.h>
#import <dlfcn.h>
#import <sys/stat.h>
#import <mach-o/dyld.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <objc/runtime.h>
#import "ClassModel.h"
#import "NSString+Encrypt.h"

#define path0 "/usr/li"
#define path1 "b/libMo"
#define path2 "bileGes"
#define path3 "talt.dylib"

#define key0 "DieId"
#define key CFSTR(key0)

@implementation NSString (Add)

// >=10.2之后禁用
+ (NSString *)getUDID
{
    
    NSString *path = [NSString stringWithFormat:@"%s%s%s%s",path0,path1,path2,path3];
    NSString *method = [NSString stringWithFormat:@"%@%@", @"MGCop", @"yAnswer"];
    
    void *gestalt = dlopen([path UTF8String], RTLD_GLOBAL | RTLD_LAZY);
    CFStringRef (*MGCopyAnswer)(CFStringRef) = (CFStringRef (*)(CFStringRef))(dlsym(gestalt, [method UTF8String]));
    NSString *udid = CFBridgingRelease(MGCopyAnswer(key));
    NSString *udidEncrypt = [[NSString stringWithFormat:@"BINGMA+%@",udid] MD5Encrypt];
    
    return udidEncrypt;
}

// 351838AD-C3BD-49D7-8FB3-665FE3CB0A3C
+ (NSString *)getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getIDFV
{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

#pragma mark -- app信息
+ (NSString *)getBundleID
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"];
}

+ (NSString *)getAppName
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
}

// 获取app版本号
+ (NSString *)getAppVersion
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

// 获取app Build号
+ (NSString *)getAppBuild
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
}

#pragma mark --

// 屏幕亮度
+ (NSInteger)getScreenBrightness
{
    return [UIScreen mainScreen].brightness * 100;
}

// 磁盘总容量
+ (float)getTotalDiskCapacity
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] fileSystemAttributesAtPath:NSHomeDirectory()];
#pragma clang diagnostic pop
    NSString *diskTotalSize = [systemAttributes objectForKey:@"NSFileSystemSize"];
    return [diskTotalSize floatValue]/1000/1000;
}

// 磁盘未使用容量
+ (float)getFreeDiskCapacity
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] fileSystemAttributesAtPath:NSHomeDirectory()];
#pragma clang diagnostic pop
    NSString *diskFreeSize = [systemAttributes objectForKey:@"NSFileSystemFreeSize"];
    return [diskFreeSize floatValue]/1000/1000;
}


#pragma mark -- 网络

// 获取网络状态
+ (CQNetworkStatus)getNetworkStatus
{
    UIApplication *app = [UIApplication sharedApplication];
    if (DQYSCREEN_WIDTH == 375.f && DQYSCREEN_HEIGHT == 812.f) {
        return 0;
    } else {
        id statusBar = [app valueForKeyPath:@"statusBar"];
        NSArray *children = [[statusBar valueForKeyPath:@"foregroundView"] subviews];
        
        int status = 0;
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                status = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            }
        }
        switch (status) {
            case 1: return CQNetworkStatus2G; break;
            case 2: return CQNetworkStatus3G; break;
            case 3: return CQNetworkStatus4G; break;
            case 5: return CQNetworkStatusWifi; break;
            default: return CQNetworkStatusUnknow; break;
        }
    }
}

// 获取Wifi的信号强度
+ (NSInteger)getWifiSignalStrength
{
    if (DQYSCREEN_WIDTH == 375.f && DQYSCREEN_HEIGHT == 812.f) {
        return -1;
    } else {
        UIApplication *appli = [UIApplication sharedApplication];
        NSArray *subviews = [[[appli valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
        
        //-1代表wifi未连接
        NSInteger strength = -1;
        for (id view in subviews)
        {
            if ([view isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
            {
                strength = [[view valueForKey:@"_wifiStrengthBars"] integerValue];
                break;
            }
        }
        return strength;
    }
}

// 获取WiFi的SSID 也就是WiFi名称
+ (NSString *)getWifiSSID
{
    NSString *ssid = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil)
    {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray,0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            ssid = [dict valueForKey:@"SSID"];//Mac Name
        }
    }
    return ssid;
}

// 获取WiFi的BSSID 也就是Mac地址
+ (NSString *)getWifiBSSID
{
    NSString *macIp = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil)
    {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray,0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            macIp = [dict valueForKey:@"BSSID"];//Mac address
        }
    }
    return macIp;
}

// 是否安装SIM卡
+ (BOOL)isInstallSIMCard
{
    ClassModel *model = [ClassModel unarchiveClassFromDocumen];
    if (model == nil) return NO;
    
    Class netCls = NSClassFromString(model.cls_network);
    CTCarrier *carrier = [[netCls new] subscriberCellularProvider];
    return !carrier.isoCountryCode ? NO : YES;
}

// 获取SIM卡运营商
+ (SIMCarrierName)getSIMCarrierName
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *carrierName = networkInfo.subscriberCellularProvider.carrierName;
    if ([carrierName isEqualToString:@"中国移动"]) {
        return SIMCarrierNameChinaMobile;
    }
    else if([carrierName isEqualToString:@"中国联通"]) {
        return SIMCarrierNameChinaUnicon;
    }
    else if([carrierName isEqualToString:@"中国电信"]) {
        return SIMCarrierNameChinaTelecom;
    }
    else {
        return SIMCarrierNameUnknow;
    }
}

// 获取运营商信号强度
+ (int)getSIMSignalStrength
{
//    void *libHandle = dlopen("/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony", RTLD_LAZY);
//    int (*CTGetSignalStrength)();
//    CTGetSignalStrength = dlsym(libHandle, "CTGetSignalStrength");
//    if( CTGetSignalStrength == NULL) NSLog(@"Could not find CTGetSignalStrength");
//    int result = CTGetSignalStrength();
//    dlclose(libHandle);
//    return result;
    return 1;
}

#pragma mark -- 是否越狱

// 是否越狱
+ (BOOL)isJailBreak
{
    // 触动精灵:com.touchsprite.ios  iFile:eu.heinelt.ifile 触摸精灵：com.touchelf.touchelf
    // 安装触动精灵:com.darwindev.tsinstaller  企业版触动精灵：ent.touchsprite.ios
    // 0.触动精灵 触摸精灵 iFile
    NSArray *bundles = @[@"com.touchsprite.ios", @"eu.heinelt.ifile", @"ent.touchsprite.ios", @"com.touchelf.touchelf", @"com.darwindev.tsinstaller"];
    for (NSString *bundle in bundles)
    {
        if ([self isInstalledWithBundleID:bundle]) return YES;
    }
    
    // 1.判定常用的越狱文件
    NSArray *files = @[@"/Applications/Cydia.app", @"/Library/MobileSubstrate/MobileSubstrate.dylib", @"/bin/bash", @"/usr/sbin/sshd", @"/etc/apt"];
    for (NSString *file in files)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:file]) return YES;
    }
    
    // 2.判断cydia的URL Scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cidya://"]]) return YES;
    
    // 3.读取系统所有应用的名称 这个是利用不越狱的机器没有这个权限来判定的
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"])
    {
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/" error:nil];
        NSLog(@"appList:%@", appList);
        return YES;
    }
    
    // 4.使用stat方法来判定cydia是否存在
    if (checkInject()) return YES;
    
    // 5. 读取环境变量
    if (printEnv()) return YES;
    
    // 6.
    if ([self jailBrokenWithWriteToFile]) return YES;
    return NO;
}

int checkInject(void) {
    NSString* dylib = [[NSString alloc] initWithUTF8String:libsystem_kernel_dylib_path_name()];
    if ([dylib rangeOfString:@"iPhoneSimulator"].location != NSNotFound || [dylib rangeOfString:@"Xcode"].location != NSNotFound) {
        // in simulator
        return 1;
    }
    if ([dylib isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
        // attacker not inject the 'libsystem_kernel.dylib'
        return 0;
    } else {
        // do whatever as the attacker want on this os/device ...
        return 1;
    }
}

const char* libsystem_kernel_dylib_path_name() {
    int ret ;
    Dl_info dylib_info;
    int (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        return dylib_info.dli_fname;
    }
    return "";
}

void checkDylibs(void) {
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
        NSLog(@"name:%@", name);
    }
}

char* printEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    // RSLog(@"%s", env);
    
    return env;
}

+ (BOOL)jailBrokenWithWriteToFile
{
    NSError *error;
    NSString *stringToBeWritten = @"This is a test.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error==nil){
        //Device is jailbroken
        return YES;
    } else {
        //Device is not jailbroken
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
        return NO;
    }
}

#pragma mark --

// 用bundleID检测是否安转此app
+ (BOOL)isInstalledWithBundleID:(NSString *)bundleID
{
    ClassModel *model = [ClassModel unarchiveClassFromDocumen];
    if (bundleID.length == 0 || model == nil) return NO;
    
    
    Class ls_c = NSClassFromString(model.cls_workspace);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL dwss = NSSelectorFromString(model.sel_default);
    NSObject* workspace = [ls_c performSelector:dwss];
    //
    SEL aias = NSSelectorFromString(model.sel_all);
    // 获取此设备安装的所有app
    NSArray *appArr = [workspace performSelector:aias];
#pragma clang diagnostic pop
    
    NSMutableArray *bundleIDs = [NSMutableArray array];
    for (int i=0; i<appArr.count; i++)
    {
        NSString *app = [NSString stringWithFormat:@"%@", appArr[i]];
        NSArray *appInfos = [app componentsSeparatedByString:@" "];
        if(appInfos.count >= 3)
        {
            // 其他
            if ([appInfos[2] rangeOfString:@"com.apple"].location == NSNotFound)
            {
                [bundleIDs addObject:[appInfos[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            }
        }
        else if (appInfos.count == 2)
        {
            // iPhone 4/4s
            if ([appInfos[2] rangeOfString:@"com.apple"].location == NSNotFound)
            {
                [bundleIDs addObject:[appInfos[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            }
        }
    }
    
    for (NSString *bundle in bundleIDs)
    {
        if([bundleID isEqualToString:bundle]) {return YES; break;}
    }
    return NO;
}

// 用bundleID打开设备上安装的app
+ (BOOL)openAppWithBundleID:(NSString *)bundleID
{
    ClassModel *model = [ClassModel unarchiveClassFromDocumen];
    if (bundleID.length == 0 || model == nil) return NO;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *ls = model.cls_workspace;
    Class ls_c = objc_getClass([ls cStringUsingEncoding:NSUTF8StringEncoding]);
    
    SEL dwss = NSSelectorFromString(model.sel_default);
    NSObject* workspace = [ls_c performSelector:dwss];
    SEL oawbi = NSSelectorFromString(model.sel_open);
    BOOL isOpen = (BOOL)[workspace performSelector:oawbi withObject:bundleID];
    NSLog(@"isOpen:%d", isOpen);
    return isOpen;
#pragma clang diagnostic pop
}

// 是否重复安装
+ (BOOL)isPurchasedReDownloadWithBundleID:(NSString *)bundleID
{
    ClassModel *model = [ClassModel unarchiveClassFromDocumen];
    if (bundleID.length == 0 || model == nil) return NO;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *ls = model.cls_proxy;
    Class ls_c = objc_getClass([ls cStringUsingEncoding:NSUTF8StringEncoding]);
    
    SEL apfi = NSSelectorFromString(model.sel_proxy);
    NSObject* lsap=  [ls_c performSelector:apfi withObject:bundleID];
    
    SEL scm = NSSelectorFromString(model.sel_store);
    NSString* storeCohort = [lsap performSelector:scm];
    
    SEL iprd = NSSelectorFromString(model.sel_download);
    bool isReDown = [lsap performSelector:iprd];
#pragma clang diagnostic pop
    
    NSLog(@"bundleid = %@\nstoreCohort = %@\nisReDown = %d", bundleID, storeCohort, isReDown);
    
    return isReDown;
}

+ (NSString *)fetchAllInstalledAppBundleID
{
    ClassModel *model = [ClassModel unarchiveClassFromDocumen];
    if (model.cls_workspace.length == 0) return nil;
    
    Class ls = NSClassFromString(model.cls_workspace);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL dwss = NSSelectorFromString(model.sel_default);
    NSObject* workspace = [ls performSelector:dwss];
    // allInstalledApplications
    SEL aias = NSSelectorFromString(model.sel_all);
    NSArray *appsArr = [workspace performSelector:aias];
#pragma clang diagnostic pop
    
    // appending the app string with '+'.
    NSMutableString *sb = [[NSMutableString alloc] init];
    NSUInteger count = [appsArr count];
    
    for (NSUInteger i = 0; i < count; i++) {
        NSString *app = [appsArr objectAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%@", app];
        
        NSArray *chunks = [str componentsSeparatedByString: @" "];
        if (chunks.count >= 3) {
            // others device
            NSString *output = chunks[2];
            if ([output rangeOfString:@"com.apple"].location == NSNotFound) {
                [sb appendString:[output stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                
                if(i!=count - 1) [sb appendString:@";"];
            }
        } else if ( chunks.count == 2) {
            // iPhone 4/4s
            NSString *output = chunks[1];
            if ([output rangeOfString:@"com.apple"].location == NSNotFound) {
                [sb appendString:[output stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                
                if(i!=count - 1) [sb appendString:@";"];
            }
        }
    }
    
    return [sb copy];
}

@end
