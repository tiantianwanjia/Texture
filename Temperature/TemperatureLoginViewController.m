//
//  TemperatureLoginViewController.m
//  Temperature
//
//  Created by muma on 2020/3/2.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "TemperatureLoginViewController.h"
#import "MBProgressHUD+Add.h"
#import "TemperatureMainViewController.h"

@interface TemperatureLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@end

@implementation TemperatureLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入账号"attributes:
//    @{NSForegroundColorAttributeName:RGB(0xFF8464)}];
//    _phoneTextField.attributedPlaceholder = attrString;
//    
//    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入密码"attributes:
//    @{NSForegroundColorAttributeName:RGB(0xFF8464)}];
//    _passTextField.attributedPlaceholder = attrString2;

}

- (IBAction)handleLoginButtonAction:(id)sender {
    //是佛有合并冲突
    //添加了login分支123
    //添加了login分支
    //在此添加了loginTwo分支
    //又修改了
    if (_phoneTextField.text.length == 0) {
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        [MBProgressHUD showError:@"请输入账号" toView:window];
        return;
    }
    if (_phoneTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return;
    }
    
    [NetRequest POST:Login parameters:@{@"username":_phoneTextField.text,@"password":_passTextField.text} success:^(id responseObject) {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:SaveUserToken];
        TemperatureMainViewController *mainVc = [TemperatureMainViewController new];
        mainVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:mainVc animated:YES completion:^{
            
        }];
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark -- UITextfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - ＊＊＊＊＊＊＊＊＊＊＊＊ 基本数据类型操作 ＊＊＊＊＊＊＊＊＊＊＊＊
#pragma mark  ----- 将字典对象转换为 JSON 字符串
- (NSString *)jsonPrettyStringEncodedWithDic:(NSDictionary *)dictionary{
    if ([NSJSONSerialization isValidJSONObject:dictionary ]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }
    }
    return nil;
}
@end
