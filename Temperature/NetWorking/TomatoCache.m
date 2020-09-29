//
//  TomatoCache.m
//  HttpRequestDemo
//
//  Created by MiniC on 15/7/11.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import "TomatoCache.h"

@implementation TomatoCache


/**
 *  判断缓存的文件是否已经失效    默认为永久保存 缓存的数据
 *
 *  @param path 存取文件的路径
 *  @param time 设置缓存文件保存的时间
 *
 *  @return 返回值为文件是否失效的状态值
 */
+(BOOL)isTimeOutWhthPath:(NSString *)path time:(NSTimeInterval)time{
    NSDictionary * info = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSDate * createDate = [info objectForKey:NSFileCreationDate];
    NSDate * date = [NSDate date];
    NSTimeInterval currentTime  =  [date timeIntervalSinceDate:createDate];
    
    //  如果超时了 将不使用缓存的文件
    if (currentTime > time) {
        // 并且 删除这个超时文件
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == YES) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        return YES;
    }
    return NO;
}


#pragma -mark - customMethods
/**
 *  通过请求地址 ，返回请求地址的对应的文件在程序沙盒中的路径
 *
 *  @param
 *
 *  @return 返回值为存取文件的路径
 */
//
+(NSString *)filePathWithString:(NSString *)str{
    //    [self createFolder:@"datacache"];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 存入 Documents 文件夹中得数据
    //    return [NSHomeDirectory() stringByAppendingFormat:@"/Documents/cache/%@",[str MD5Hash]];
    return [NSString stringWithFormat:@"%@/%@",cachePath,[str MD5]];
}
#pragma -mark - 
#pragma -mark - customMethods
/**
 *  在document文件夹下创建一个文件夹
 *
 *  @param aFolderPath 文件夹的名字
 */
+ (void)createFolder:(NSString*)aFolderPath{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [NSString stringWithFormat:@"%@/%@",[documentPaths objectAtIndex:0],aFolderPath];
    NSFileManager *filesManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [filesManager fileExistsAtPath:docDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ){
        [filesManager createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


 /**
 *   把字典中的value 的中文转换为URL可用的编码格式
 *
 *  @param parameters 可能含有中文字符串的字典
 *
 *  @return 已经转换好的字典
 */
+ (NSDictionary *)dictEncodingToUrlWithdict:(NSDictionary *)parameters{
    NSDictionary * dict = [NSDictionary dictionaryWithDictionary:parameters];
    NSMutableArray * valueArr = [NSMutableArray array];
    for (NSString * value in [dict allValues]) {
        NSString *  uTF8Value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [valueArr addObject:uTF8Value];
    }
    NSMutableDictionary * mDict ;
    NSArray * keyArr = parameters.allKeys;
    for (int i = 0; i < valueArr.count; i ++) {
        mDict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:valueArr[i],keyArr[i], nil];
    }
    parameters = [NSDictionary dictionaryWithDictionary:mDict];
    return parameters;
}


#pragma mark -- 拼接 post 请求的网址
+ (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters{
    if(parameters.count == 0){
        return urlStr;
    }
    
    
//    NSArray * keyArr = [parameters allKeys];
//    NSMutableString * paramsSyring = [NSMutableString string];
//    for (int i = 0; i < parameters.count; i ++) {
//        NSString * key = keyArr[i];
//        id value = [parameters objectForKey:key];
//        [paramsSyring appendFormat:@"%@=%@",key,value];
//        if (i < parameters.count - 1) {
//            [paramsSyring appendString:@"&"];
//        }
//    }
//    NSMutableString * urlll = [NSMutableString stringWithString:urlStr];
//    NSString * pathStr =[NSString stringWithFormat:@"%@?",urlStr];
//    if (paramsSyring.length > 0) {
//        pathStr = [urlll stringByAppendingFormat:@"&%@",paramsSyring];
//    }
//    pathStr =[NSString stringWithFormat:@"%@?%@",urlStr,paramsSyring];
//    return pathStr;
    
    
    NSMutableArray *parts = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id<NSObject> obj, BOOL *stop) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *encodedValue = [obj.description stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject: part];
    }];
    
    NSString *queryString = [parts componentsJoinedByString: @"&"];
    
//    queryString =  queryString ? [NSString stringWithFormat:@"?%@", queryString] : @"";
    
    NSString * pathStr =[NSString stringWithFormat:@"%@?%@",urlStr,queryString];
    return pathStr;

}




#pragma mark -- 使用缓存的文件
/**
 *  使用缓存的文件
 *  @param filePath 文件名称，
 *  @return 字典
 */
+(NSData *)reldCacheFileData:(NSString *)filePath{
    // 使用缓存文件
    // 读取 path 中的 data
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    
    
    
//    if (data) {
//        id myResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        if ([myResult isKindOfClass:[NSDictionary  class]]) {
//            NSDictionary * dic = (NSDictionary *)myResult;
//            return dic;
//        }
//    }
    return  data;
}

#pragma mark ---
#pragma mark ---   计算一共缓存的数据的大小
+ (NSString *)cacheSize{
   
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    //计算缓存文件夹的大小
    NSArray *subpaths = [mgr subpathsAtPath:cachePath];
    long long ttotalSize = 0;
    for (NSString *subpath in subpaths) {
        NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
        BOOL dir = NO;
        [mgr fileExistsAtPath:fullpath isDirectory:&dir];
        if (dir == NO) {// 文件
            ttotalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] longLongValue];
        }
    }//  M
    ttotalSize = ttotalSize/1024;
    return ttotalSize<1024?[NSString stringWithFormat:@"%.2lld KB",ttotalSize]:[NSString stringWithFormat:@"%.2lld MB",ttotalSize/1024];
}

/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path {
    
    signed long long fileSize = 0;
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSError *error = nil;
        
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        
        if (!error && fileDict) {
            
            fileSize = [fileDict fileSize];
        }
    }
    
    return fileSize;
}






#pragma mark ---
#pragma mark ---   清空缓存的数据
+ (void)deleateCache{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [mgr removeItemAtPath:cachePath error:nil];
}




@end
