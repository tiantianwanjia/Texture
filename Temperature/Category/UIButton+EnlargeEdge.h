//
//  UIButton+EnlargeEdge.h
//  飞鱼工程师端
//
//  Created by 候云杰 on 17/3/1.
//  Copyright © 2017年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

//文字在右，图片在左间距10
- (void)setIconInLeftWithSpacing:(CGFloat)Spacing;
//文字在左，图片在右间距10
- (void)setIconInRightWithSpacing:(CGFloat)Spacing;
//文字在下，图片在上间距10
- (void)setIconInTopWithSpacing:(CGFloat)Spacing;
//文字在上，图片在下间距10
- (void)setIconInBottomWithSpacing:(CGFloat)Spacing;


@end
