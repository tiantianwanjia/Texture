//
//  MacroDefinition.h
//  BannerVideo
//
//  Created by muma on 2020/10/27.
//  Copyright © 2020 stoneobs. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

/**
 *屏幕尺寸
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *屏幕适配比例
 */
#define SCREENAPPLY(x, y) CGSizeMake(SCREEN_WIDTH / 375.0 * (x), SCREEN_HEIGHT / 667.0 * (y))
#define SCREENAPPLYSPACE(x) SCREEN_WIDTH / 375.0 * (x)
#define SCREENAPPLYHEIGHT(x) SCREEN_HEIGHT / 667.0 * (x)

/**
 *KeyWindow
 */
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

/**
 *判断iphone x系列
 */
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/**
 *获取系统版本
 */
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *状态栏高度
 */
#define kStatusBarHeight (CGFloat)(IPHONE_X?(44.0):(20.0))

/**
 *导航栏高度
 */
#define kNavBarHeight (44)

/**
 *状态栏和导航栏总高度
 */
#define kNavBarAndStatusBarHeight (CGFloat)(IPHONE_X?(88.0):(64.0))

/**
 *TabBar高度
 */
#define kTabBarHeight (CGFloat)(IPHONE_X?(49.0 + 34.0):(49.0))

/**
 *顶部安全区域远离高度
 */
#define kTopBarSafeHeight (CGFloat)(IPHONE_X?(44.0):(0))

/**
 *底部安全区域远离高度
 */
#define kBottomSafeHeight (CGFloat)(IPHONE_X?(34.0):(0))

/**
 *导航条和Tabbar总高度
 */
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

/**
 *判断是真机还是模拟器
 */
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

/**
 *随机RGB颜色
 */
#define LFPRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/**
 *设置RGB颜色
 */
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/**
 *设置RGBA颜色可以设置透明度
 */
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

/**
 *rgb颜色转换（16进制->10进制）
 */
#define RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *rgb颜色转换（16进制->10进制可以设置透明度
 */
#define RGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/**
 *常用颜色
 */
#define MainColor RGB(0x09ad85)
#define ThreeColor RGB(0x333333)
#define WhiteColor RGB(0xFFFFFF)
#define GrayColor RGB(0x666666)

/**
 *默认字体设置大小
 */
#define Font(F)             [UIFont systemFontOfSize:(F)]

/**
 *Medium字体设置大小
 */
#define FONTMedium(font) [UIFont fontWithName:@"PingFangSC-Medium" size:font]

/**
 *Semibold字体设置大小
 */
#define FONTSemibold(font) [UIFont fontWithName:@"PingFangSC-Semibold" size:font]

/**
 *黑体字体设置大小
 */
#define FONT_HEITI_TC(fontSize) [UIFont fontWithName:@"Heiti TC" size:fontSize]

/**
 *黑体简体字体设置大小
 */
#define FONT_HEITI_SC(fontSize) [UIFont fontWithName:@"Heiti SC" size:fontSize]

/**
 *常用字体大小
 */
#define UIFont_10 ([UIFont systemFontOfSize:10])
#define UIFont_11 ([UIFont systemFontOfSize:11])
#define UIFont_12 ([UIFont systemFontOfSize:12])
#define UIFont_13 ([UIFont systemFontOfSize:13])
#define UIFont_14 ([UIFont systemFontOfSize:14])
#define UIFont_15 ([UIFont systemFontOfSize:15])
#define UIFont_16 ([UIFont systemFontOfSize:16])
#define UIFont_17 ([UIFont systemFontOfSize:17])
#define UIFont_18 ([UIFont systemFontOfSize:18])
#define UIFont_19 ([UIFont systemFontOfSize:19])
#define UIFont_20 ([UIFont systemFontOfSize:20])
#define UIFont_21 ([UIFont systemFontOfSize:21])
#define UIFont_22 ([UIFont systemFontOfSize:22])
#define UIFont_23 ([UIFont systemFontOfSize:23])
#define UIFont_24 ([UIFont systemFontOfSize:24])
#define UIFont_25 ([UIFont systemFontOfSize:25])

/**
 *NSUserDefaults 实例化取值
 */
#define USERDEFAULT_value(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

#define USERDEFAULT_BOOL(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]

/**
 *NSUserDefaults 实例化存值
 */
#define USERDEFAULT_SET_value(_value_,_key_) [[NSUserDefaults standardUserDefaults] setValue:_value_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define USERDEFAULT_SET_bool(_bool_,_key_) [[NSUserDefaults standardUserDefaults] setBool:_bool_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

/**
 *NSUserDefaults 实例化删除
 */
#define USERDEFAULT_REMOVE(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]

/**
 *判断字符串是否为空
 */
#define NULLString(string) ([string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]])

/**
 *自定义输出logo
 */
#if DEBUG
#define NSLog(FORMAT, ...) NSLog((@"** 函数名:%s\t\t" "--[行号:%d] \n" FORMAT "\n "), __FUNCTION__, __LINE__, ##__VA_ARGS__);  // "[文件名:%s]\n"   __FILE__,    会打印文件路径

#else
#define NSLog(FORMAT, ...) nil
#endif

/**
 *弱引用强引用
 */
#define WeakSelf(type)    __weak typeof(type) weak##type = type;
#define WeakMySelf    __weak typeof(self) weakSelf = self;

/**
 *强引用
 */
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

/**
 *设置 view  边框，阴影
 */
#define ViewBorderRadiusB(View, BorderRadius, Width, BorderColor, ShadowColor, ShadowOpacity ,ShadowOffset)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setBorderWidth:(BorderRadius)];\
[View.layer setBorderColor:BorderColor];\
[View.layer setShadowColor:ShadowColor];\
[View.layer setShadowOffset:ShadowOffset];\
[View.layer setShadowOpacity:ShadowOpacity]

/**
 *由角度转换弧度
 */
#define DegreesToRadian(x) (M_PI * (x) / 180.0)

/**
 *由弧度转换角度
 */
#define RadianToDegrees(radian) (radian*180.0)/(M_PI)

/**
 * 通过地址路径获取图片
 */
#define File_imageName(name, type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]

/**
 *直接通过名称加载图片
 */
#define IMAGNAME(name) [UIImage imageNamed:name]

/**
 *默认图片
 */
#define PlanceImage IMAGNAME(@"logo_seizeASea")


#endif /* MacroDefinition_h */
