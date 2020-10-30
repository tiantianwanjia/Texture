//
//  UIImage+MumaImageTools.h
//  Temperature
//
//  Created by muma on 2020/10/27.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MumaImageTools)

/**
 *通过颜色生成图片
 *
 *@param size 生成的图片大小
 */
+ (UIImage*)muma_imageWithColor:(UIColor *)color
size:(CGSize)size;

/**
 *  根据字符串生成指定大小的二维码
 *
 *  @param contenStr 二维码内容
 *  @param size  图片宽度
 *  @param logoStr  中间的logo
 */
+ (UIImage *)muma_createNonInterpolatedUIImageFormContent:(NSString *)contenStr withSize:(CGFloat) size  andIsLoginImage:(NSString *)logoStr;

/**
 *毛玻璃
 */
- (UIImage *)muma_imgWithBlur;

/**
 *新size图片
 */
- (UIImage *)muma_imageFormNewSize:(CGSize)newSize;

@end

NS_ASSUME_NONNULL_END
