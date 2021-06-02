//
//  CollectionViewController.m
//  Temperature
//
//  Created by muma on 2020/11/23.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "CollectionViewController.h"
#import "ZhaoCollectionViewCell.h"


#import "MaiWeiFlowLayout.h"
#import "MaiWeiTwoFlowLayout.h"


static NSString * const ZhaoCollectionViewCellIdentfier = @"ZhaoCollectionViewCell";

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic , strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    MaiWeiFlowLayout *flowLayout = [[MaiWeiFlowLayout alloc] init];
    flowLayout.cellCount = 10;
//    MaiWeiTwoFlowLayout *flowLayout = [[MaiWeiTwoFlowLayout alloc] init];
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZhaoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ZhaoCollectionViewCellIdentfier];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZhaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZhaoCollectionViewCellIdentfier forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0  );
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.row);
}

@end
