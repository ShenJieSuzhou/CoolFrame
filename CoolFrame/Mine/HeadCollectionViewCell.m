//
//  HeadCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/12.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HeadCollectionViewCell.h"
#import "MineViewFuncCell.h"

@implementation PersionInfoView
@synthesize imgIcon = _imgIcon;
@synthesize levelIcon = _levelIcon;
@synthesize name = _name;
@synthesize level = _level;
@synthesize settingBtn = _settingBtn;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.imgIcon];
        [self addSubview:self.name];
        [self addSubview:self.levelIcon];
        [self addSubview:self.level];
        [self addSubview:self.settingBtn];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgIcon setFrame:CGRectMake(20, 40, 80, 80)];
    _imgIcon.layer.cornerRadius = _imgIcon.frame.size.width/2;      //裁成圆角
    _imgIcon.layer.masksToBounds = YES;                             //隐藏裁剪掉的部分
    _imgIcon.layer.borderWidth = 1.5f;                              //边框宽度
    _imgIcon.layer.borderColor = [UIColor whiteColor].CGColor;      //边框颜色
    
    CGFloat nameX = self.imgIcon.frame.origin.x + self.imgIcon.frame.size.width + 10.0f;
    CGFloat nameY = self.imgIcon.frame.origin.y + 10.0f;
    [self.name setFrame:CGRectMake(nameX, nameY, 100, 20)];
    
    CGFloat leveliconX = self.imgIcon.frame.origin.x + self.imgIcon.frame.size.width - 20.0f;
    CGFloat leveliconY = self.imgIcon.frame.origin.y;
    [self.levelIcon setFrame:CGRectMake(leveliconX, leveliconY, 15, 15)];
    
    [self.level setFrame:CGRectMake(nameX, nameY + 25, 100, 20)];
    
    [self.settingBtn setFrame:CGRectMake(self.frame.size.width - 80, nameY, 50, 25)];
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
        [_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [_name setTextColor:[UIColor whiteColor]];
    }
    return _name;
}

- (void)setName:(UILabel *)name{
    _name = name;
}

- (UILabel *)level{
    if(!_level){
        _level = [[UILabel alloc] init];
        [_level setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
        [_level setTextColor:[UIColor whiteColor]];
    }
    return _level;
}

- (UIButton *)settingBtn{
    if(!_settingBtn){
        _settingBtn = [[UIButton alloc] init];
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_settingBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [_settingBtn setTintColor:[UIColor whiteColor]];
    }
    
    return _settingBtn;
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

    [_persionInfoV setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height * 0.45 )];
    [_collectionV setFrame:CGRectMake(0, _persionInfoV.frame.size.height, rect.size.width, rect.size.height *0.55)];
    
    CGFloat itemW = _collectionV.frame.size.width / 3;
    CGFloat itemH = _collectionV.frame.size.height / 2;
    _flowlayout.itemSize = CGSizeMake(itemW, itemH);
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
        [_collectionV registerClass:[MineViewFuncCell class] forCellWithReuseIdentifier:@"MineViewFuncCell"];
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

    MineViewFuncCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineViewFuncCell" forIndexPath:indexPath];
    
    NSDictionary *dic = [_itemArray objectAtIndex:indexPath.row];
    UIImage *icon = [UIImage imageNamed:[dic objectForKey:@"title_icon"]];
    NSString *menuName = [dic objectForKey:@"titleText"];
    
    [cell.imgIcon setImage:icon];
    [cell.menuName setText:menuName];
    
    return cell;
}

@end
