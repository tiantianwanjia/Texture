//
//  UINavigationBar+MumaNavetationBar.h
//  Temperature
//
//  Created by muma on 2020/10/30.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MumaNavetationBar : NSObject


/**
 *全局设置导航栏背景颜色
 */
+ (void)muma_setDefaultNavBackgroundColor:(UIColor *)color;

/**
 *全局设置导航栏按钮颜色
 */
+ (void)muma_setDefaultNavBarTintColor:(UIColor *)color;

/**
 *全局设置导航栏标题颜色
 */
+ (void)muma_setDefaultNavBarTitleColor:(UIColor *)color;

/**
 *全局设置导航栏黑色分割线是否隐藏
 */
+ (void)muma_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

/**
 *全局设置状态栏样式
 */
+ (void)muma_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

@end


@interface UINavigationBar (MumaNavetationBar)

/**
 *设置当前 NavigationBar 背景 View
 */
- (void)muma_setBackgroundView:(UIView *)view;

/**
 *设置当前 NavigationBar 背景图片
 */
- (void)muma_setBackgroundImage:(UIImage *)image;

/**
 *设置当前 NavigationBar 背景颜色
 */
- (void)muma_setBackgroundColor:(UIColor *)color;

/**
 *设置当前 NavigationBar 背景透明度
 */
- (void)muma_setBackgroundAlpha:(CGFloat)alpha;

/**
 *设置当前 NavigationBar 底部分割线是否隐藏
 */
- (void)muma_setShadowImageHidden:(BOOL)hidden;

/**
 *设置当前 NavigationBar _UINavigationBarBackIndicatorView (默认的返回箭头)是否隐藏
 */
- (void)muma_setBarBackIndicatorViewHidden:(BOOL)hidden;

/**
 *设置导航栏所有 barButtonItem 的透明度
 */
- (void)muma_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/**
 *设置当前 NavigationBar 垂直方向上的平移距离
 */
- (void)muma_setTranslationY:(CGFloat)translationY;

/**
 *获取当前导航栏垂直方向上偏移了多少
 */
- (CGFloat)muma_getTranslationY;


@end

NS_ASSUME_NONNULL_END
