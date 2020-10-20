//
//  STCrashManger.m
//  ligenyun
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 stoneobs@icloud.com. All rights reserved.
//

#import "MuMaClassRoomCrashManger.h"
#import <sys/utsname.h>
void st_uncaughtExceptionHandler(NSException *exception) {
    NSArray *callStackSymbols = [exception callStackSymbols];//当前调用栈
    NSString *reason = [exception reason];//崩溃原因
    NSString *name = [exception name];//异常类型

    NSArray * array = [NSArray arrayWithContentsOfFile:[MuMaClassRoomCrashManger defult].currentCashPath];
    NSMutableArray * fecthArray = [array mutableCopy];
    if (!fecthArray.count) {
        fecthArray = [NSMutableArray new];
    }
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSString* phoneModel = [[MuMaClassRoomCrashManger defult] iphoneType];
     [UIDevice currentDevice].batteryMonitoringEnabled = YES; 
    CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
    batteryLevel = batteryLevel * 100;
    NSString * deviceStatus = [NSString stringWithFormat:@"\n设备信息:\n手机系统版本:\n%@\n手机机型:\n%@\n当前电池电量:\n%0.2f%@\n",phoneVersion,phoneModel,batteryLevel,@"%"];
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString * crashDes = [NSString stringWithFormat:@"\n-----------------------------------------------------------------------------------------------%@\n崩溃时间:\n%@\n崩溃函数调用栈:\n%@\n崩溃原因:\n%@\n崩溃类型:\n%@\n",
                           deviceStatus,
                           localeDate.description,
                           callStackSymbols.description,
                           reason,
                           name];
    [fecthArray insertObject:crashDes atIndex:0];
    BOOL isWrite =  [fecthArray writeToFile:[MuMaClassRoomCrashManger defult].currentCashPath atomically:YES];
    NSLog(@"写入状态%d",isWrite);
    
}
@interface MuMaClassRoomCrashManger()

@end
@implementation MuMaClassRoomCrashManger
+ (MuMaClassRoomCrashManger *)defult{
    static MuMaClassRoomCrashManger * defult = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defult = [MuMaClassRoomCrashManger new];
    });
    return defult;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createCurrentVersionFolder];
        NSSetUncaughtExceptionHandler (&st_uncaughtExceptionHandler);
    }
    return self;
}
- (void)createCurrentVersionFolder{
    NSString * displayName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleBundleName"];
    NSString * version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];;
    
    NSString * floderPath = [NSString stringWithFormat:@"%@崩溃日志",displayName];
    NSString * currentVersionName = [NSString stringWithFormat:@"%@_%@_crashLog.txt",displayName,version];
    
    NSString *documentDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    self.currentCashPath = [NSString stringWithFormat:@"%@/%@/%@",documentDirectoryPath,floderPath,currentVersionName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:floderPath]) {
        [self st_createFolderFormDocumentWithFatherPath:nil folderName:floderPath];
    }
    
}
- (NSString*)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}
- (BOOL)st_createFolderFormDocumentWithFatherPath:(NSString *)fatherPath folderName:(NSString *)folderName{
    
    NSFileManager* fileManager= [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    if(fatherPath.length){
        NSString * realFatherPath = [NSString stringWithFormat:@"%@/%@",documentPath,fatherPath];
        BOOL isDir = NO;
        // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
        BOOL existed = [fileManager fileExistsAtPath:realFatherPath isDirectory:&isDir];
        if(existed && isDir){
            NSString * finshUrl = [NSString stringWithFormat:@"%@/%@",realFatherPath,folderName];
            [fileManager createDirectoryAtPath:finshUrl withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"创建目录成功:%@",finshUrl);
            return YES;
        }else{
            NSLog(@"fatherPath 不存在或者不是一个目录%@",realFatherPath);
            return NO;
        }
        
    }else{
        NSString * realPath = [NSString stringWithFormat:@"%@/%@",documentPath,folderName];
        BOOL isDir = NO;
        // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
        BOOL existed = [fileManager fileExistsAtPath:realPath isDirectory:&isDir];
        if(!existed && !isDir){
            NSString * finshUrl = realPath;
            [fileManager createDirectoryAtPath:finshUrl withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"创建目录成功:%@",finshUrl);
            return YES;
        }else{
            NSLog(@"\n%@该目录已经存在:\n%@",realPath,folderName);
            return NO;
        }
    }
    return NO;
}
- (NSArray<NSString *> *)crashArray{
    NSArray * array = [NSArray arrayWithContentsOfFile:[MuMaClassRoomCrashManger defult].currentCashPath];
    NSMutableArray * fecthArray = [array mutableCopy];
    if (!fecthArray.count) {
        fecthArray = [NSMutableArray new];
    }
    return fecthArray;
}
@end

