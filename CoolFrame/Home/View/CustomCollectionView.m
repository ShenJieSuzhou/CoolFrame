//
//  CustomCollectionView.m
//  CoolFrame
//
//  Created by silicon on 2017/10/2.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CustomFlowLayout.h"
#import "CustomCollectionViewCell.h"
#import "GlobalDefine.h"

@implementation CustomCollectionView
@synthesize delegate = _delegate;

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
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //自动网格布局
        CustomFlowLayout * flowLayout = [[CustomFlowLayout alloc] init];
        //网格布局
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomMenuCell"];

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
   
    if([[self delegate] respondsToSelector:@selector(collectionView:didSelectItemAtIndex:)]){
        [_delegate collectionView:self didSelectItemAtIndex:indexPath.item];
    }
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomMenuCell" forIndexPath:indexPath];
    
    for (int i = 0; i < [_itemArray count]; i++) {
        NSDictionary *dic = [_itemArray objectAtIndex:indexPath.row];
        UIImage *icon = [UIImage imageNamed:[dic objectForKey:@"ImgUrl"]];
        NSString *menuName = [dic objectForKey:@"name"];
        
        [cell.imgIcon setImage:icon];
        [cell.menuName setText:menuName];
    }
   
    return cell;
}

@end
