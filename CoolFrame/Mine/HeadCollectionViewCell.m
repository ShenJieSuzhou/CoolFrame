//
//  HeadCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/12.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HeadCollectionViewCell.h"

@implementation PersionInfoView
@synthesize imgIcon = _imgIcon;
@synthesize levelIcon = _levelIcon;
@synthesize name = _name;
@synthesize level = _level;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.imgIcon];
        [self addSubview:self.name];
        [self addSubview:self.levelIcon];
        [self addSubview:self.level];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgIcon setFrame:CGRectMake(30, (self.frame.size.height - 70)/2, 70, 70)];
    CGFloat nameX = self.imgIcon.frame.origin.x + self.imgIcon.frame.size.width + 50.0f;
    CGFloat nameY = self.imgIcon.frame.origin.x;
    [self.name setFrame:CGRectMake(nameX, nameY, 150, 20)];
    
    CGFloat leveliconX = self.name.frame.origin.x + self.name.frame.size.width + 10.0f;
    CGFloat leveliconY = self.name.frame.origin.y;
    [self.levelIcon setFrame:CGRectMake(leveliconX, leveliconY, 30, 30)];
    
    [self.level setFrame:CGRectMake(nameX, nameY + 25, 150, 20)];
}

/**
 * 类成员懒加载
 */

- (UIImageView *)imgIcon{
    if(!_imgIcon){
        _imgIcon = [[UIImageView alloc] init];
    }
    return _imgIcon;
}

- (void)setImgIcon:(UIImageView *)imgIcon{
    _imgIcon = imgIcon;
}

- (UIImageView *)levelIcon{
    if(!_levelIcon){
        _levelIcon = [[UIImageView alloc] init];
    }
    return _levelIcon;
}

- (void)setLevelIcon:(UIImageView *)levelIcon{
    _levelIcon = levelIcon;
}

- (UILabel *)name{
    if(!_name){
        _name = [[UILabel alloc] init];
    }
    return _name;
}

- (void)setName:(UILabel *)name{
    _name = name;
}

- (UILabel *)level{
    if(!_level){
        _level = [[UILabel alloc] init];
    }
    return _level;
}

@end

@implementation HeadCollectionViewCell

@synthesize persionInfoV = _persionInfoV;
@synthesize collectionV = _collectionV;
@synthesize itemArray = _itemArray;
@synthesize flowlayout = _flowlayout;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.persionInfoV];
        [self addSubview:self.collectionV];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.bounds;
    CGFloat margin = 10.0f;
    [_persionInfoV setFrame:CGRectMake(0, 0, rect.size.width, (rect.size.height - 60) /2 )];
    [_collectionV setFrame:CGRectMake(0, margin + rect.origin.y + rect.size.height /2, rect.size.width, rect.size.height /2)];
    
    CGFloat itemWH = _collectionV.frame.size.width / 3;
    _flowlayout.itemSize = CGSizeMake(itemWH, itemWH);
    _collectionV.pagingEnabled = YES;
    _collectionV.scrollEnabled = NO;
    _flowlayout.minimumLineSpacing = 0;
    _flowlayout.minimumInteritemSpacing = 0;
}

/**
 * 类成员懒加载
 */

- (PersionInfoView *)persionInfoV{
    if(!_persionInfoV){
        _persionInfoV = [[PersionInfoView alloc] init];
    }
    return _persionInfoV;
}

- (UICollectionView *)collectionV{
    if(!_collectionV){
        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowlayout];
        //注册cell
        [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ProfileMenuCell"];
        _collectionV.dataSource = self;
        _collectionV.delegate = self;
        
    }
    return _collectionV;
}

- (void)setItemArray:(NSMutableArray *)itemArray{
    if(!itemArray) return;
    
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
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileMenuCell" forIndexPath:indexPath];
    UIImageView *menuView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [menuView setImage:[UIImage imageNamed:[_itemArray objectAtIndex:indexPath.row]]];
    [cell addSubview:menuView];
    
    return cell;
}

@end
