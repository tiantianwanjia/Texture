//
//  MaiWeiFlowLayout.h
//  Yuliao
//
//  Created by muma on 2020/11/20.
//  Copyright © 2020 HK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaiWeiFlowLayout : UICollectionViewFlowLayout
 //中心

@property (nonatomic, assign) CGPoint center;


//cell数量

@property (nonatomic, assign) NSInteger cellCount;

@end

NS_ASSUME_NONNULL_END
