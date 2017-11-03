//
//  GoodsCollectionView.h
//  CoolFrame
//
//  Created by shenjie on 2017/10/11.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//datasource
@property (strong,nonatomic) NSMutableArray *itemArray;
//UICollectionView
@property (strong, nonatomic) UICollectionView *collectionView;
//UICollectionViewFlowLayout
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end
