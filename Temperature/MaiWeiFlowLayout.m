//
//  MaiWeiFlowLayout.m
//  Yuliao
//
//  Created by muma on 2020/11/20.
//  Copyright © 2020 HK. All rights reserved.
//

#import "MaiWeiFlowLayout.h"

#define ITEM_SIZE (50.0f)

@interface MaiWeiFlowLayout ()

 @property (nonatomic, strong) NSMutableArray *deleteIndexPaths;

@property (nonatomic, strong) NSMutableArray *insertIndexPaths;

@end

@implementation MaiWeiFlowLayout

-(void)prepareLayout{

    [super prepareLayout];

    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    _center = CGPointMake(SCREEN_WIDTH / 2, 0);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath

{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    if (indexPath.row == 0) {
        attributes.center = CGPointMake(self.center.x - 30, 0);
    }else if (indexPath.row == 1){
        attributes.center = CGPointMake(self.center.x + 30, 0);
    }else if (indexPath.row == 2){
        attributes.center = CGPointMake(self.center.x - 70, 40);
    }else if (indexPath.row == 3){
        attributes.center = CGPointMake(self.center.x + 70, 40);
    }else if (indexPath.row == 4){
        attributes.center = CGPointMake(self.center.x - 110, 80);
    }else if (indexPath.row == 5){
        attributes.center = CGPointMake(self.center.x + 110, 80);
    }else if (indexPath.row == 6){
        attributes.center = CGPointMake(self.center.x - 150, 120);
    }else if (indexPath.row == 7){
        attributes.center = CGPointMake(self.center.x + 150, 120);
    }else if (indexPath.row == 8){
        attributes.center = CGPointMake(self.center.x - 30, 120);
    }else if (indexPath.row == 9){
        attributes.center = CGPointMake(self.center.x + 30, 120);
    }

    return attributes;

}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect

{
    NSMutableArray *attributes = [NSMutableArray array];

    for(NSInteger i = 0; i < _cellCount; i++)

    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];

    }
    return attributes;

}

@end


