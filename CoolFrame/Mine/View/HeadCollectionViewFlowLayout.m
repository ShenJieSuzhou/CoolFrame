//
//  HeadCollectionViewFlowLayout.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/12.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HeadCollectionViewFlowLayout.h"

@implementation HeadCollectionViewFlowLayout

#pragma mark: 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    CGFloat itemWH = self.collectionView.frame.size.width;
    self.itemSize = CGSizeMake(itemWH, 50);
    self.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向
    self.minimumLineSpacing = 1;        // 设置最小行间距
    self.minimumInteritemSpacing = 1;   // 设置最小item间距
}

@end
