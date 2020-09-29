//
//  TemperatureMainViewController.m
//  Temperature
//
//  Created by muma on 2020/3/2.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "TemperatureMainViewController.h"
#import "TemperatureScanViewController.h"

@interface TemperatureMainViewController ()

@end

@implementation TemperatureMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}




- (IBAction)handleMainDismisButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)handllToSanButtonAction:(id)sender {
    TemperatureScanViewController *scanVc = [TemperatureScanViewController new];
    scanVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:scanVc animated:YES completion:^{
        
    }];
}

@end
