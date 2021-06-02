//
//  UIViewController+MumaNavegation.h
//  Temperature
//
//  Created by muma on 2020/10/29.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MumaNavegationItem)

/**
 *导航栏左侧添加按钮
 *
 *@param title 按钮名称
 */
- (void)muma_setLeftItemWithTitle:(NSString*)title;

/**
 *导航栏左侧添加按钮
 *
 *@param title 按钮名称
 *@param titleColor 文字颜色
 */
- (void)muma_setLeftItemWithTitle:(NSString *)title titleColor:(UIColor*)titleColor;

/**
 *导航栏左侧添加按钮
 *
 *@param image 图片名称
*/
- (void)muma_setLeftItemWithImage:(UIImage *)image;

/**
 *导航栏左侧添加按钮
 *
 *@param image 图片名称
 *@param title 按钮名称
 *@param titleColor 文字颜色
*/
- (void)muma_setLeftItemWithImage:(UIImage *)image andwithTitle:(NSString *)title  titleColor:(UIColor*)titleColor;

/**
 *导航栏左侧添加按钮
 *
 *@param view view视图
 */
- (void)muma_setLeftItemWithView:(UIView*)view;

/**
 *导航栏右侧添加按钮
 *
 *@param title 按钮名称
 */
- (void)muma_setRightItemWithTitle:(NSString*)title;

/**
 *导航栏右侧添加按钮
 *
 *@param title 按钮名称
 *@param titleColor 文字颜色
 */
- (void)muma_setRightItemWithTitle:(NSString *)title titleColor:(UIColor*)titleColor;

/**
 *导航栏右侧添加按钮
 *
 *@param image 图片名称
 */
- (void)muma_setRightItemWithImage:(UIImage*)image;

/**
 *导航栏右侧添加按钮
 *
 *@param image 图片名称
 *@param title 按钮名称
 *@param titleColor 文字颜色
 */
- (void)muma_setRightItemWithImage:(UIImage*)image andwithTitle:(NSString *)title titleColor:(UIColor*)titleColor;

/**
 *导航栏右侧添加按钮
 *
 *@param view view视图
 */
- (void)muma_setRightItemWithView:(UIView*)view;

/**
 *左侧按钮点击事件
 *
 *@param sender 点击按钮
 */
- (void)muma_rightBarAction:(UIButton *)sender;

/**
 *右侧按钮点击事件
 *
 *@param sender 点击按钮
*/
- (void)muma_leftBarAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
