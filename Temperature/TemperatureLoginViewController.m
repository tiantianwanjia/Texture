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
#import <MacroDefinition.h>

#import "CollectionViewController.h"


@interface TemperatureLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *minImageView;

@end

@implementation TemperatureLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
    NSLog(@"%lfgggggggg",SCREEN_HEIGHT);
    
    //NSLog(@"%@",@[@""][9]);234234234234
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入账号"attributes:
//    @{NSForegroundColorAttributeName:RGB(0xFF8464)}];
//    _phoneTextField.attributedPlaceholder = attrString;
//    
//    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入密码"attributes:
//    @{NSForegroundColorAttributeName:RGB(0xFF8464)}];
//    _passTextField.attributedPlaceholder = attrString2;

}

- (IBAction)handleLoginButtonAction:(id)sender {
    

    //添加了login分支123234234234
    //添加了login分支wewef
    //在此添加了loginTwo分支
    //又修改了
//ddddddfgggggggggggg微风微风微风微风
    //ffwdfwefwefwfwefwefwef
    //添加了login分支123fffffff
    //添加了login分支ffffff
    //在此添加了loginTwo分支ffffff

    //又修改了ffffffff
    //fwefwefwefw234234234234234

    //又修改了ffffffffffffff
    //反反复复发烧
    //想要和定login分支的单个文件
//    if (_phoneTextField.text.length == 0) {
//        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//        [MBProgressHUD showError:@"请输入账号" toView:window];
//        return;
//    }
//    if (_phoneTextField.text.length == 0) {
//        [MBProgressHUD showError:@"请输入密码" toView:self.view];
//        return;
//    }
//
//    NSString *gg = nil;
//    [NetRequest POST:Login parameters:@{@"username":gg,@"password":_passTextField.text} success:^(id responseObject) {
//        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:SaveUserToken];
//        TemperatureMainViewController *mainVc = [TemperatureMainViewController new];
//        mainVc.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self presentViewController:mainVc animated:YES completion:^{
//
//        }];
//    } failure:^(NSError *error) {
//
//    }];
    
    CollectionViewController *col = [CollectionViewController new];
    col.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:col animated:YES completion:^{
        
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
