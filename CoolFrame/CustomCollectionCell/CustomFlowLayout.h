//
//  CustomFlowLayout.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/30.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFlowLayout : UICollectionViewLayout

@property (assign,nonatomic) CGFloat columnMargin;      //每一列item之间的间距
@property (assign,nonatomic) CGFloat rowMargin;         //每一行item之间的间距
@property (assign,nonatomic) UIEdgeInsets sectionInset; //设置于collectionView边缘的间距
@property (assign,nonatomic) NSInteger columnCount;     //设置每一行排列的个数

/** 这个字典用来存储每一列item的高度 */
@property (strong,nonatomic)NSMutableDictionary *maxYDic;
/** 存放每一个item的布局属性 */
@property (strong,nonatomic)NSMutableArray *attrsArray;
@end
