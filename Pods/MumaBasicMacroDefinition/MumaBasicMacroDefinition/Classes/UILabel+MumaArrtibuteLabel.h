//
//  UILabel+MumaArrtibuteLabel.h
//  Temperature
//
//  Created by muma on 2020/10/27.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol MumaAttributeTapActionDelegate <NSObject>
@optional
/**
 *  MumaAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)muma_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface MumaAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (MumaArrtibuteLabel)

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)muma_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)muma_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <MumaAttributeTapActionDelegate> )delegate;

@end

NS_ASSUME_NONNULL_END
