//
//  GoodsCollectionView.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/11.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "GoodsCollectionView.h"

@implementation GoodsCollectionView

@synthesize itemArray = _itemArray;
@synthesize collectionView = _collectionView;
@synthesize flowLayout = _flowLayout;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _itemArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:[self collectionView]];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_collectionView setFrame:self.bounds];
    CGFloat itemWH = (_collectionView.frame.size.width-1) / 2;
    _flowLayout.itemSize = CGSizeMake(itemWH, itemWH * 0.4);
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollEnabled = NO;
    _flowLayout.minimumLineSpacing = 1;
    _flowLayout.minimumInteritemSpacing = 1;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //自动网格布局
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        //网格布局
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:_flowLayout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"RecomendCell"];
        
        //设置数据源代理
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

- (void)setItemArray:(NSMutableArray *)itemArray{
    _itemArray = [itemArray copy];
    
}

#pragma mark - collectionViewDelegate

//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_itemArray count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecomendCell" forIndexPath:indexPath];
    UIImageView *goodsView = [[UIImageView alloc] initWithFrame:cell.bounds];
    goodsView.contentMode = UIViewContentModeScaleAspectFit;
    [goodsView setImage:[UIImage imageNamed:[_itemArray objectAtIndex:indexPath.row]]];
    [cell addSubview:goodsView];
    
    return cell;
}

@end
