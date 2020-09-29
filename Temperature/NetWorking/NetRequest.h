//
//  NetRequest.h
//  来趣网
//
//  Created by 张云博 on 15/9/28.
//  Copyright (c) 2015年 何江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NetRequest : NSObject

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parmeters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failue;

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parmeters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failue;

+ (void)GET:(NSString *)url parameterOtherPassString:(id)parmeters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failue;

@property (nonatomic , strong) UIActivityIndicatorView *activityIndicator;

+ (instancetype)shaerManager;



@end
