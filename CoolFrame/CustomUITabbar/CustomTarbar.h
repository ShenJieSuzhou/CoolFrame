//
//  CustomTarbar.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "CustomTabBarItem.h"
@protocol CustomTabbarDelegate;

@interface CustomTarbar : UIView
@property (nonatomic, strong) id<CustomTabbarDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) CustomTabBarItem *selectedItem;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic) CGFloat itemWidth;
@property (nonatomic) CGFloat miniContentHeight;

@end

@protocol CustomTabbarDelegate <NSObject>

- (BOOL)tabBar:(CustomTarbar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;
- (void)tabBar:(CustomTarbar *)tabBar didSelectItemAtIndex:(NSInteger)index;

@end
