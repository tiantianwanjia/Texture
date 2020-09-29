//
//  TemperatureUserInterfaceViewController.m
//  Temperature
//
//  Created by muma on 2020/3/2.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "TemperatureUserInterfaceViewController.h"
#import "TemperPickerView.h"

@interface TemperatureUserInterfaceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *comperLabel;
@property (weak, nonatomic) IBOutlet UILabel *zuLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *chuNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *statueLabel;
@property (weak, nonatomic) IBOutlet UILabel *reseLabel;
@property (weak, nonatomic) IBOutlet UIButton *temperButton;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end

@implementation TemperatureUserInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_temperButton setIconInRightWithSpacing:5];
    
    _nameLabel.text = _userInfoerDic[@"name"];
    _comperLabel.text = _userInfoerDic[@"corporateName"];
    _zuLabel.text = _userInfoerDic[@"tenantName"];
    _numberLabel.text = _userInfoerDic[@"jobNumber"];
    _chuNumberLabel.text = _userInfoerDic[@"importAndExportCard"];
    if ([_userInfoerDic[@"state"] intValue] == 1) {
        _statueLabel.text = @"正常";
    }else{
        _statueLabel.text = @"停用";
        _statueLabel.textColor = [UIColor redColor];
    }
    _reseLabel.text = _userInfoerDic[@"remarks"] ? _userInfoerDic[@"remarks"] : @"无";
    NSString * imageUrl = [_userInfoerDic[@"photoUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
}

- (IBAction)handleTemperChouseButtonAction:(id)sender {
    [[TemperPickerView shaerManager] showTemperPickerViewWithView:self.view chousViewWithTem:^(NSString *temStr) {
        [self.temperButton setTitle:temStr forState:0];
        [self.temperButton setIconInRightWithSpacing:5];
    }];
}

- (IBAction)handleSenderButtonAction:(id)sender {
    if ([_temperButton.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择体温" toView:self.view];
        return;
    }
    if ([_userInfoerDic[@"state"] intValue] == 1) {
        _userInfoerDic[@"temperature"] = @([self getTemViewTe:_temperButton.titleLabel.text]);
        [NetRequest POST:SenderTem parameters:_userInfoerDic success:^(id responseObject) {
            [MBProgressHUD showError:@"提交成功" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            });
        } failure:^(NSError *error) {
            
        }];
    }else{
        [MBProgressHUD showError:@"该账号已经停用！" toView:self.view];
    }

}
- (IBAction)handleBackButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)getTemViewTe:(NSString *)temFloat{
    if ([temFloat isEqualToString:@"36.7以下"]) {
        return 1;
    }else if ([temFloat isEqualToString:@"36.8~67.2"]){
        return 2;
    }else if ([temFloat isEqualToString:@"37.3~38.4"]){
        return 3;
    }else{
        return 4;
    }
}

@end
