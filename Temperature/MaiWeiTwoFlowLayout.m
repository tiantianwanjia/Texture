//
//  MaiWeiTwoFlowLayout.m
//  Temperature
//
//  Created by muma on 2020/11/23.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "MaiWeiTwoFlowLayout.h"

@implementation MaiWeiTwoFlowLayout


 //设置每个cell的frame,即在collectionview里的xy坐标和宽高

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath

{

    UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

  
    

    return attr;

}





@end
