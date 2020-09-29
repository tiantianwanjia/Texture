//
//  TemperPickerView.m
//  Temperature
//
//  Created by muma on 2020/3/2.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "TemperPickerView.h"

@implementation TemperPickerView

+ (instancetype)shaerManager{
  static TemperPickerView *man = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        man = [TemperPickerView new];
    });
    return man;
}

- (void)showTemperPickerViewWithView:(UIView *)superView chousViewWithTem:(TemperPickerViewBlock)temBlock{
    
    
//    UIWindow *window = nil;
//    if (@available(iOS 13.0, *))
//    {
//        window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    }else{
//        window = [UIApplication sharedApplication].keyWindow;
//    }
    
    self.frame = superView.frame;
    self.backgroundColor = RGBA(0x000000, 0.16);
    [superView addSubview:self];
       
       for (UIView *view in self.subviews) {
           [view removeFromSuperview];
       }
    CGFloat scrWidth = self.bounds.size.width;
       UIView *bcView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 251, scrWidth, 251)];
       bcView.backgroundColor = WhiteColor;
       [self addSubview:bcView];
    
    for (int i = 0; i < 2; i ++) {
        UIButton *returenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        returenButton.frame = CGRectMake(0 + i * (scrWidth - 50), 0, 50, 43);
        [returenButton setTitle:@[@"取消",@"确定"][i] forState:0];
        [returenButton setTitleColor:RGBA(0x333333, 1) forState:0];
        [returenButton addTarget:self action:@selector(handlTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        returenButton.tag = i;
        [bcView addSubview:returenButton];
    }

    self.dataArray =  @[@"36.7以下",@"36.8~67.2",@"37.3~38.4",@"38以上"];
    _temStr = self.dataArray[0];
    
   UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, scrWidth, 207)];
   pickerView.delegate = self;
   pickerView.dataSource = self;
   [bcView addSubview:pickerView];
    
    self.temBlock = temBlock;
}

#pragma mark - UIPickerView DataSource and Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
 return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
 return self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
 return 46;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _temStr = self.dataArray[row];
}

- (void)handlTypeButtonAction:(UIButton *)sender{
    
    if (sender.tag == 1) {
        self.temBlock(_temStr);
    }
    [self removeFromSuperview];
}

@end
