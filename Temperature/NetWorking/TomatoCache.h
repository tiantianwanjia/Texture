//
//  TomatoCache.h
//  HttpRequestDemo
//
//  Created by MiniC on 15/7/11.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Helper.h"
/**
 *  缓存时间的类型     提供集常用的  缓存时间     也可以 自己添加结构体内容，同样也可以自己   定义时间（可不用结构体）
 */

typedef NS_ENUM(NSInteger, TimeType ){
    /**
     *  没有缓存
     */
    TimeTypeNOCache = 0,
    /**
     *  一小时
     */
    TimeTypeOneHour =  60*60,
    /**
     *  一天
     */
    TimeTypeOneDay  = 60*60*24,
    /**
     *  一周
     */
    TimeTypeOneWeak =60*60*24* 7,
    
    /**
     *  永久缓存  MAXFLOAT   在这里不能用  所以设置了一个自认为很遥远的是时间值   1000周
     */
    TimeTypeCache =  60*60*24* 7 * 1000,
    
    /**
     *  可以自己设置时间   TimeTypeCacheTime = ?
     */
    TimeTypeCacheTime
};



@interface TomatoCache : NSObject

/**
 *  判断缓存的文件是否已经失效
 *
 *  @param path 存取文件的路径
 *  @param time 设置缓存文件保存的时间
 *
 *  @return 返回值为文件是否失效的状态值
 */
+(BOOL)isTimeOutWhthPath:(NSString *)path time:(NSTimeInterval)time;



#pragma -mark - customMethods
/**
 *  通过请求地址 ，返回请求地址的对应的文件在程序沙盒中的路径
 *
 *  @param
 *
 *  @return 返回值为存取文件的路径
 */
//
+(NSString *)filePathWithString:(NSString *)str;


#pragma -mark - #pragma -mark - customMethods
/**
 *  在document文件夹下创建一个文件夹
 *
 *  @param aFolderPath 文件夹的名字
 */
+ (void)createFolder:(NSString*)aFolderPath;


/**
 *   把字典中的value 的中文转换为URL可用的编码格式
 *
 *  @param parameters 可能含有中文字符串的字典
 *
 *  @return 已经转换好的字典
 */
+ (NSDictionary *)dictEncodingToUrlWithdict:(NSDictionary *)parameters;
#pragma mark -- 使用缓存的文件
/**
 *  使用缓存的文件
 *  @param filePath 文件名称，
 *  @return 字典
 */
+(NSData *)reldCacheFileData:(NSString *)filePath;



#pragma mark -- 拼接 post 请求的网址
+ (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters;

 

#pragma mark ---
#pragma mark ---   计算一共缓存的数据的大小
+ (NSString *)cacheSize;


#pragma mark ---
#pragma mark ---   清空缓存的数据
+ (void)deleateCache;


/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path;




@end
