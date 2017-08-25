//
//  CustomTabBarController.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTarbar.h"

@protocol CustomTarBarControllerDelegate;

@interface CustomTabBarController : UIViewController<CustomTabbarDelegate>
@property (nonatomic, strong) id<CustomTarBarControllerDelegate> delegate;
@property (nonatomic, strong) CustomTarbar *customTarbar;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic) NSUInteger selectIndex;
@property (nonatomic) BOOL tabbarHidden;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

@protocol CustomTarBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(CustomTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

- (void)tabBarController:(CustomTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;


@end
