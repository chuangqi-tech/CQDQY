//
//  NSString+Encrypt.h
//  SoundRecord
//
//  Created by chuangqi on 2017/5/10.
//  Copyright © 2017年 chuangqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)


/**
 * MD5加密
 *
 * @return 32位
 */
- (NSString *)MD5Encrypt;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)sha256String;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;


#define FileHashDefaultChunkSizeForReadingData 4096
/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)fileSHA256Hash;


#pragma mark -- base64



@end
