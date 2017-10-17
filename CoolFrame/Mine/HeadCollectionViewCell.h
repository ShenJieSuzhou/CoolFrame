//
//  HeadCollectionViewCell.h
//  CoolFrame
//
//  Created by shenjie on 2017/10/12.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersionInfoView: UIView

@property (strong, nonatomic) UIImageView *imgIcon; //头像图片

@property (strong, nonatomic) UILabel *name;        //用户名

@property (strong, nonatomic) UILabel *level;       //级别

@property (strong, nonatomic) UIImageView *levelIcon; //级别icon

@end

@interface HeadCollectionViewCell : UICollectionReusableView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) PersionInfoView *persionInfoV;
@property (strong, nonatomic) UICollectionView *collectionV;
@property (strong, nonatomic) NSMutableArray *itemArray;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowlayout


@end
