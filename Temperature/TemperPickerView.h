//
//  TemperPickerView.h
//  Temperature
//
//  Created by muma on 2020/3/2.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TemperPickerViewBlock)(NSString *temStr);

NS_ASSUME_NONNULL_BEGIN

@interface TemperPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

+ (instancetype)shaerManager;

@property (nonatomic , copy) TemperPickerViewBlock temBlock;

- (void)showTemperPickerViewWithView:(UIView *)superView chousViewWithTem:(TemperPickerViewBlock)temBlock;

@property (nonatomic , strong) NSString *temStr;
@property (nonatomic , strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
