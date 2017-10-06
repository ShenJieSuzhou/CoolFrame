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
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomPkgCell"];

        //设置数据源代理
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }

    return _collectionView;
}

- (void)setItemArray:(NSMutableArray *)itemArray{
    [_itemArray removeAllObjects];
    for (int i = 0; i < [itemArray count]; i++) {
        NSDictionary *dic = [itemArray objectAtIndex:i];
        
        CustomMenuItem *item = [[CustomMenuItem alloc] init];
        UIImage *finishedImage = [UIImage imageNamed:[dic objectForKey:@"ImgUrl"]];
        UIImage *unfinishedImage = [UIImage imageNamed:[dic objectForKey:@"ImgUrl"]];
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        [item setFinishedSelectedImage:finishedImage withFinishedUnselectedImage:unfinishedImage];
        [item setTitle:[dic objectForKey:@"name"]];
        item.unselectedTitleAttributes= @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(0, 0, 0),};
        item.selectedTitleAttributes = @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(0, 0, 0),};
        
        [_itemArray addObject:item];
    }
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
    NSLog(@"%@", indexPath);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomPkgCell" forIndexPath:indexPath];
    [cell setMenuItem:[_itemArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
