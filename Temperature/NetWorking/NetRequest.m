//
//  NetRequest.m
//  来趣网
//
//  Created by 张云博 on 15/9/28.
//  Copyright (c) 2015年 何江. All rights reserved.
//

#import "NetRequest.h"
#import "AFNetworking.h"
#import "TomatoCache.h"



@implementation NetRequest

+ (instancetype)shaerManager{
    static NetRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [NetRequest new];
    });
    return manager;
}

+ (void)activityIndicatorer{
    if (![NetRequest shaerManager].activityIndicator) {
        [NetRequest shaerManager].activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
           [[UIApplication sharedApplication].keyWindow addSubview:[NetRequest shaerManager].activityIndicator];
           //设置小菊花的frame
           [NetRequest shaerManager].activityIndicator.frame= CGRectMake((SCREEN_WIDTH - 100) / 2, (SCREEN_HEIGHT - 100) / 2, 100, 100);
           //设置小菊花颜色
           [NetRequest shaerManager].activityIndicator.color = [UIColor blackColor];
           //设置背景颜色
           [NetRequest shaerManager].activityIndicator.backgroundColor = [UIColor clearColor];
           //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
           [NetRequest shaerManager].activityIndicator.hidesWhenStopped = YES;
        [[NetRequest shaerManager].activityIndicator startAnimating];
    }
}


+ (void)GET:(NSString *)url parameterOtherPassString:(id)parmeters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failue{
    [self activityIndicatorer];
    NSString *completeURL = [NSString stringWithFormat:@"%@%@%@",BASEURL,url,parmeters];
    //初始化网络请求类
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //配置网络请求超时间
        manager.requestSerializer.timeoutInterval = 10;
        //加上https ssl验证
    //    [manager setSecurityPolicy:[NetRequest customSecurityPolicy]];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SaveUserToken]) {
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:SaveUserToken] forHTTPHeaderField:@"token"];
    }

    //去除返回数据<null>
    AFJSONResponseSerializer *repost = [AFJSONResponseSerializer serializer];
    repost.removesKeysWithNullValues = YES;
    manager.responseSerializer = repost;
    
    WeakMySelf
    [manager GET:completeURL parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[NetRequest shaerManager].activityIndicator stopAnimating];
        [NetRequest shaerManager].activityIndicator = nil;
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode == 200) {
            if ([responseObject[@"code"] intValue] == 0) {
                if (success) {
                    success(responseObject);
                }
            }else{
                [MBProgressHUD showError:responseObject[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            }

        }else{
            NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:[responseObject[@"status"] integerValue] userInfo:(NSDictionary *)responseObject];
            if (failue) {
                failue(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

       [[NetRequest shaerManager].activityIndicator stopAnimating];
       [NetRequest shaerManager].activityIndicator = nil;
        if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
            [MBProgressHUD showError:@"请检查网络设置" toView:[UIApplication sharedApplication].keyWindow];
            return ;
        }else {
            [MBProgressHUD showError:error.localizedDescription toView:[UIApplication sharedApplication].keyWindow];
            return ;
            
        }
        NSLog(@"%@",error.localizedDescription);
        if (error) {
            failue(error);
        }
        
    }];
}


//接口，请求参数，成功返回，失败返回
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parmeters success:(void (^)(id))success failure:(void (^)(NSError *))failue
{
    [self activityIndicatorer];
    NSString *completeURL = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    //初始化网络请求类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //配置网络请求超时间
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //去除返回数据<null>
      NSMutableDictionary *addss = [NSMutableDictionary dictionaryWithDictionary:parmeters];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SaveUserToken]) {
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:SaveUserToken] forHTTPHeaderField:@"token"];
    }

    
    AFJSONResponseSerializer *repost = [AFJSONResponseSerializer serializer];
    repost.removesKeysWithNullValues = YES;
    manager.responseSerializer = repost;
    // 打印请求URL地址
    NSString * urls = [TomatoCache urlDictToStringWithUrlStr:completeURL WithDict:parmeters];
    NSLog(@"-----requestUrl  %@\n\n",urls);
    [manager POST:completeURL parameters:addss progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[NetRequest shaerManager].activityIndicator stopAnimating];
        [NetRequest shaerManager].activityIndicator = nil;
        if ([responseObject[@"code"] intValue] ==0) {
            if (success) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
//             NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:[responseObject[@"status"] integerValue] userInfo:(NSDictionary *)responseObject];
//            if (failue) {
//                failue(error);
//            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[NetRequest shaerManager].activityIndicator stopAnimating];
        [NetRequest shaerManager].activityIndicator = nil;
        if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
            [MBProgressHUD showError:@"请检查网络" toView:[UIApplication sharedApplication].keyWindow];
        }else {
            [MBProgressHUD showError:error.localizedDescription toView:[UIApplication sharedApplication].keyWindow];
            
        }
        NSLog(@"%@",error.localizedDescription);
        if (error) {
            failue(error);
        }
        
    }];

}


+ (void)GET:(NSString *)url parameters:(NSDictionary *)parmeters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failue
{
    
    [self activityIndicatorer];
    NSString *completeURL = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    //初始化网络请求类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //加上https ssl验证
//    [manager setSecurityPolicy:[NetRequest customSecurityPolicy]];
    //配置网络请求超时间
    manager.requestSerializer.timeoutInterval = 8;
    //设置MIME类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //去除返回数据<null>
        AFJSONResponseSerializer *repost = [AFJSONResponseSerializer serializer];
        repost.removesKeysWithNullValues = YES;
        manager.responseSerializer = repost;
    
    // 打印请求URL地址
    NSString * urls = [TomatoCache urlDictToStringWithUrlStr:completeURL WithDict:parmeters];
    NSLog(@"-----requestUrl  %@\n\n",urls);
    
    [manager GET:completeURL parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NetRequest shaerManager].activityIndicator stopAnimating];
        [NetRequest shaerManager].activityIndicator = nil;
         if ([responseObject[@"code"] intValue] ==0) {
                    if (success) {
                        success(responseObject);
                    }
                }else{
                    [MBProgressHUD showError:responseObject[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        //             NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:[responseObject[@"status"] integerValue] userInfo:(NSDictionary *)responseObject];
        //            if (failue) {
        //                failue(error);
        //            }
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[NetRequest shaerManager].activityIndicator stopAnimating];
        [NetRequest shaerManager].activityIndicator = nil;
        if (failue) {
            failue(error);
        }
    }];

}




@end
