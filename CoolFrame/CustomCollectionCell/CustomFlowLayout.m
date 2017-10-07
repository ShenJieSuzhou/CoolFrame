//
//  CustomFlowLayout.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/30.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

//初始化
-(instancetype)init
{
    if (self = [super init]){

    }
    return self;
}


//每一次布局前的准备工作
-(void)prepareLayout
{
    [super prepareLayout];
    //计算所有item的属性
    CGFloat itemWH = self.collectionView.frame.size.width / 5;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置滚动方向
    self.collectionView.pagingEnabled = YES;    // 设置分页
    self.minimumLineSpacing = 0;                // 设置最小行间距
    self.minimumInteritemSpacing = 0;           // 设置最小item间距
}


@end
