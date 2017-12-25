//
//  ClassModel.h
//  DailyRecord
//
//  Created by zhao on 2017/10/14.
//  Copyright © 2017年 chuangqish. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 私有api模型类
 */
@interface ClassModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *cls_network;
@property (nonatomic, copy) NSString *cls_workspace;
@property (nonatomic, copy) NSString *cls_proxy;

@property (nonatomic, copy) NSString *sel_default;
@property (nonatomic, copy) NSString *sel_all;
@property (nonatomic, copy) NSString *sel_open;
@property (nonatomic, copy) NSString *sel_proxy;
@property (nonatomic, copy) NSString *sel_store;
@property (nonatomic, copy) NSString *sel_download;

/**
 * 将用户信息存到本地 归档
 */
- (BOOL)classWriteToDocume;

/**
 *  解归档 读取用户信息
 */
+ (instancetype)unarchiveClassFromDocumen;

@end
