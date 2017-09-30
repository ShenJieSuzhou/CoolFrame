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
        self.columnMargin = 0;
        self.rowMargin = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.columnCount = 4;
    }
    return self;
}

/** 懒加载 */
-(NSMutableDictionary *)maxYDic
{
    if (!_maxYDic)
    {
        _maxYDic = [NSMutableDictionary dictionary];
    }
    return _maxYDic;
}

/** 懒加载 */
-(NSMutableArray *)attrsArray
{
    if (!_attrsArray)
    {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

//每一次布局前的准备工作
-(void)prepareLayout
{
    [super prepareLayout];
    
    //清空最大的y值
    for (int i =0; i < self.columnCount; i++)
    {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDic[column] = @(self.sectionInset.top);
    }
    
    //计算所有item的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++)
    {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attrsArray addObject:attrs];
    }
}

//设置collectionView滚动区域
-(CGSize)collectionViewContentSize
{
    //假设最长的那一列为第0列
    __block NSString *maxColumn = @"0";
    
    //遍历字典,找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if ([maxY floatValue] > [self.maxYDic[maxColumn] floatValue])
        {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDic[maxColumn]floatValue]+self.sectionInset.bottom);
}

//允许每一次重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//布局每一个属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的那一列为第0列
    __block NSString *minColumn = @"0";
    
    //遍历字典,找出最短的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if ([maxY floatValue] < [self.maxYDic[minColumn] floatValue])
        {
            minColumn = column;
        }
    }];
    
    //计算每一个item的宽度和高度
    CGFloat width = (self.collectionView.frame.size.width - self.columnMargin*(self.columnCount - 1) - self.sectionInset.left - self.sectionInset.right) / self.columnCount;
    
//    CGFloat height = [self.delegate waterFlowLayout:self heightForWidth:width andIndexPath:indexPath] ;
    CGFloat height = width;
    
    //计算每一个item的位置
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn floatValue];
    CGFloat y = [self.maxYDic[minColumn] floatValue] + self.rowMargin;
    
    
    //更新这一列的y值
    self.maxYDic[minColumn] = @(y + height);
    
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置item的frame
    attrs.frame = CGRectMake(x, y, width, height);
    
    return attrs;
}

//布局所有item的属性,包括header、footer
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.attrsArray copy];
}


@end
