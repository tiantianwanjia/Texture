//
//  MBProgressHUD+MumaHUD.h
//  Temperature
//
//  Created by muma on 2020/10/27.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//


#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (MumaHUD)

/**
 *没有图片的提示信息 默认添加到window上
 */
+ (void)muma_showMessage:(NSString *)messageString;

/**
 *没有图片的提示信息 加载在指定的view上
 *
 *@param messageString 提示信息
 *@param toView 需要加载的view
 */
+ (void)muma_showMessage:(NSString *)messageString andToView:(UIView *)toView;

/**
 *带图片的提示信息 默认加载在window上
 *
 *@param messageString 提示信息
 *@param imageNameString 图片名称
 */
+ (void)muma_showMessage:(NSString *)messageString andImageNameString:(NSString *)imageNameString;

/**
 *带图片的提示信息 加载在指定的view上
 *
 *@param messageString 提示信息
 *@param imageNameString 图片名称
 *@param toView 需要加载的view
 */
+ (void)muma_showMessage:(NSString *)messageString andImageNameString:(NSString *)imageNameString andToView:(UIView *)toView;


@end

NS_ASSUME_NONNULL_END
