//
//  ClassModel.m
//  DailyRecord
//
//  Created by zhao on 2017/10/14.
//  Copyright © 2017年 chuangqish. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel

// encoder
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.cls_network forKey:@"cls_network"];
    [enCoder encodeObject:self.cls_workspace forKey:@"cls_workspace"];
    [enCoder encodeObject:self.cls_proxy forKey:@"cls_proxy"];
    
    [enCoder encodeObject:self.sel_default forKey:@"sel_default"];
    [enCoder encodeObject:self.sel_all forKey:@"sel_all"];
    [enCoder encodeObject:self.sel_open forKey:@"sel_open"];
    [enCoder encodeObject:self.sel_proxy forKey:@"sel_proxy"];
    [enCoder encodeObject:self.sel_store forKey:@"sel_store"];
    [enCoder encodeObject:self.sel_download forKey:@"sel_download"];
}

// decoder
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if ([super init])
    {
        self.cls_network = [decoder decodeObjectForKey:@"cls_network"];
        self.cls_workspace = [decoder decodeObjectForKey:@"cls_workspace"];
        self.cls_proxy = [decoder decodeObjectForKey:@"cls_proxy"];
        
        self.sel_default = [decoder decodeObjectForKey:@"sel_default"];
        self.sel_all = [decoder decodeObjectForKey:@"sel_all"];
        self.sel_open = [decoder decodeObjectForKey:@"sel_open"];
        self.sel_proxy = [decoder decodeObjectForKey:@"sel_proxy"];
        self.sel_store = [decoder decodeObjectForKey:@"sel_store"];
        self.sel_download = [decoder decodeObjectForKey:@"sel_download"];
    }
    return self;
}

/**
 * 将用户信息存到本地 归档
 */
- (BOOL)classWriteToDocume
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [filePath stringByAppendingPathComponent:@"class.data"];
    return [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}

/**
 *  解归档 读取用户信息
 */
+ (instancetype)unarchiveClassFromDocumen
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];;
    filePath = [filePath stringByAppendingPathComponent:@"class.data"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

@end
