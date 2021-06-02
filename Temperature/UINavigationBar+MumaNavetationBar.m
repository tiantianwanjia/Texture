//
//  UINavigationBar+MumaNavetationBar.m
//  Temperature
//
//  Created by muma on 2020/10/30.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "UINavigationBar+MumaNavetationBar.h"
#import <objc/runtime.h>
#import "sys/utsname.h"

@implementation MumaNavetationBar

static char kVMUMADefaultNavBarBarTintColorKey;
static char kVMUMADefaultNavBarTintColorKey;
static char kVMUMADefaultNavBarTitleColorKey;
static char kVMUMADefaultNavBarShadowImageHiddenKey;
static char kVMUMADefaultStatusBarStyleKey;
static char kVMUMADefaultStatusBarHeightKey;

/** 全局设置导航栏背景颜色 */
+ (void)muma_setDefaultNavBackgroundColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kVMUMADefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBackgroundColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kVMUMADefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}

/** 全局设置导航栏按钮颜色 */
+ (void)muma_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kVMUMADefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kVMUMADefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}

/** 全局设置导航栏标题颜色 */
+ (void)muma_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kVMUMADefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kVMUMADefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}

/** 全局设置导航栏黑色分割线是否隐藏*/
+ (void)muma_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kVMUMADefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kVMUMADefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}

/** 全局设置状态栏样式*/
+ (void)muma_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kVMUMADefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &kVMUMADefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}

+ (void)muma_setDefaultStatusBarHeight:(CGFloat)height {
    objc_setAssociatedObject(self, &kVMUMADefaultStatusBarHeightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultStatusBarHeight {
    id style = objc_getAssociatedObject(self, &kVMUMADefaultStatusBarHeightKey);
    return (style != nil) ? [style floatValue] : 0.0;
}



@end


@implementation UINavigationBar (MumaNavetationBar)

static char kVHLBackgroundViewKey;
static char kVHLBackgroundImageViewKey;


- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kVHLBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &kVHLBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kVHLBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kVHLBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// -> 设置导航栏背景View
- (void)muma_setBackgroundView:(UIView *)view {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    // 这里需要将系统添加的模糊层隐藏，不然会在自己添加的背景层再添加一层模糊层
    if ([self.subviews.firstObject subviews].count > 1) {
        UIView *backgroundEffectView = [[self.subviews.firstObject subviews] objectAtIndex:1];// UIVisualEffectView
        if (backgroundEffectView != nil) {
            backgroundEffectView.alpha = 0.0;
        }
    }
    
    self.backgroundView = view;
    self.backgroundView.frame = self.subviews.firstObject.bounds;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    /** iOS11下导航栏不显示问题 */
    if (self.subviews.count > 0) {
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    } else {
        [self insertSubview:self.backgroundView atIndex:0];
    }
}
// -> 设置导航栏背景图片
- (void)muma_setBackgroundImage:(UIImage *)image {
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    if (!self.backgroundImageView) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.subviews.firstObject.bounds];
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;  // ****
        // _UIBarBackground is first subView for navigationBar
        /** iOS11下导航栏不显示问题 */
        if (self.subviews.count > 0) {
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        } else {
            [self insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImageView.image = image;
}

// -> 设置导航栏背景颜色
- (void)muma_setBackgroundColor:(UIColor *)color {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    if (!self.backgroundView) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:self.subviews.firstObject.bounds];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;  // ****
        // _UIBarBackground is first subView for navigationBar
        /** iOS11下导航栏不显示问题 */
        if (self.subviews.count > 0) {
            [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
        } else {
            [self insertSubview:self.backgroundView atIndex:0];
        }
    }
    self.backgroundView.backgroundColor = color;
}
#pragma mark - public method
/** 设置当前 NavigationBar 背景透明度*/
- (void)muma_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    barBackgroundView.alpha = alpha;
    
    if (@available(iOS 11.0, *)) {  // iOS11 下 UIBarBackground -> UIView/UIImageViwe
        for (UIView *view in self.subviews) {
            if ([NSStringFromClass([view class]) containsString:@"UIbarBackGround"]) {
                view.alpha = 0;
            }
        }
        // iOS11 下如果不设置 UIBarBackground 下的UIView的透明度，会显示一个白色图层
        if (barBackgroundView.subviews.firstObject) {
            barBackgroundView.subviews.firstObject.alpha = alpha;
        }
    }
    if (self.isTranslucent) {
        if ([barBackgroundView subviews].count > 1) {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    }
}

/** 设置当前 NavigationBar 底部分割线是否隐藏*/
- (void)muma_setShadowImageHidden:(BOOL)hidden {
    self.shadowImage = hidden ? [UIImage new] : nil;
}

/** 设置当前 NavigationBar _UINavigationBarBackIndicatorView (默认的返回箭头)是否隐藏*/
- (void)muma_setBarBackIndicatorViewHidden:(BOOL)hidden {
    for (UIView *view in self.subviews) {
        Class _UINavigationBarBackIndicatorViewClass = NSClassFromString(@"_UINavigationBarBackIndicatorView");
        if (_UINavigationBarBackIndicatorViewClass != nil) {
            if ([view isKindOfClass:_UINavigationBarBackIndicatorViewClass]) {
                view.hidden = hidden;
            }
        }
    }
}

/** 设置导航栏所有 barButtonItem 的透明度*/
- (void)muma_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES) {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if (![view isKindOfClass:_UIBarBackgroundClass]) {
                    view.alpha = alpha;
                }
            }
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if (![view isKindOfClass:_UINavigationBarBackground]) {
                    view.alpha = alpha;
                }
            }
        } else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if (![view isKindOfClass:_UIBarBackgroundClass]) {
                        view.alpha = alpha;
                    }
                }
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if (![view isKindOfClass:_UINavigationBarBackground]) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

/** 设置当前 NavigationBar 垂直方向上的平移距离*/
- (void)muma_setTranslationY:(CGFloat)translationY {
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (CGFloat)muma_getTranslationY {
    return self.transform.ty;
}










@end
