//
//  GTcontent.m
//  去旅行
//
//  Created by rimi on 15/8/18.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import "JLBGTcontent.h"
#import <SystemConfiguration/SystemConfiguration.h>
@implementation JLBGTcontent
+ (BOOL)connectedToNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    
    struct sockaddr_storage zeroAddress;//IP地址
    
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
    
    /*
     1、sockaddr_storage
     This structure stores socket address information. Because this structure is large enough to store IPv4 or IPv6 address information, its use promotes protocol-family and protocol-version independence, and simplifies cross-platform development. Use this structure in place of the sockaddr structure.
     
     2、
     extern void bzero（void *s, int n）;
     用法：#include <string.h>
     功能：置字节字符串s的前n个字节为零且包括‘\0’。
     说明：bzero无返回值，并且使用string.h头文件，string.h曾经是posix标准的一部分，但是在POSIX.1-2001标准里面，
     这些函数被标记为了遗留函数而不推荐使用。在POSIX.1-2008标准里已经没有这些函数了。推荐使用memset替代bzero。
     
     bzero( &tt, sizeof( tt ) );      //等价于memset(&tt,0,sizeof(tt));
     bzero( s, 20 );                  //等价于memset(s,0,20);
     
     */
}
@end
