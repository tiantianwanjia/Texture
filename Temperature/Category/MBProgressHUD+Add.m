//
//  MBProgressHUD+Add.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
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

+ (void)showError:(NSString *)error andErrorMessage:(NSString *)imageName andToView:(UIView *)view{
    [self show:error icon:imageName view:view];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self show:error icon:@"error.png" view:view];
    });
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.dimBackground = YES;
    return hud;
}
@end
