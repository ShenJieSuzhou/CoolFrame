//
//  FouthViewController.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "UserInfo.h"
@interface FouthViewController : CustomViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UICollectionView *mineCollection;
@property (nonatomic, strong) UserInfo *userInfo;

@end
