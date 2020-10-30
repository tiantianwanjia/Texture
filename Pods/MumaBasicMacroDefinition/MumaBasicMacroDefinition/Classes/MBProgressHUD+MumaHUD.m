//
//  MBProgressHUD+MumaHUD.m
//  Temperature
//
//  Created by muma on 2020/10/27.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "MBProgressHUD+MumaHUD.h"
#import "MacroDefinition.h"


@implementation MBProgressHUD (MumaHUD)

/**
 *没有图片的提示信息 默认添加到window上
 */
+ (void)muma_showMessage:(NSString *)messageString{
    [self muma_show:messageString icon:nil view:[UIApplication sharedApplication].keyWindow];
}

/**
 *没有图片的提示信息 加载在指定的view上
 *
 *@param messageString 提示信息
 *@param toView 需要加载的view
 */
+ (void)muma_showMessage:(NSString *)messageString andToView:(UIView *)toView{
    [self muma_show:messageString icon:nil view:toView];
}

/**
 *带图片的提示信息 默认加载在window上
 *
 *@param messageString 提示信息
 *@param imageNameString 图片名称
 */
+ (void)muma_showMessage:(NSString *)messageString andImageNameString:(NSString *)imageNameString{
    [self muma_show:messageString icon:imageNameString view:[UIApplication sharedApplication].keyWindow];
}

/**
 *带图片的提示信息 加载在指定的view上
 *
 *@param messageString 提示信息
 *@param imageNameString 图片名称
 *@param toView 需要加载的view
 */
+ (void)muma_showMessage:(NSString *)messageString andImageNameString:(NSString *)imageNameString andToView:(UIView *)toView{
    [self muma_show:messageString icon:imageNameString view:toView];
}

+ (void)muma_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
     if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
     hud.mode = MBProgressHUDModeCustomView;
     hud.label.superview.backgroundColor = RGB(0x000000);
     hud.label.text = text;
     if (icon) {
         UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
         hud.customView = imgView;
     }
     hud.label.textColor = WhiteColor;
     hud.label.font = Font(13);
     hud.label.numberOfLines = 0;
     hud.removeFromSuperViewOnHide = YES;
     [hud hideAnimated:YES afterDelay:1.5];
}

@end
