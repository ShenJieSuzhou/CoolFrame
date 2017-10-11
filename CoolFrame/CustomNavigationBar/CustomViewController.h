//
//  CustomViewController.h
//  CoolFrame
//
//  Created by silicon on 2017/8/3.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNaviBarView.h"

@interface CustomViewController : UIViewController

@property (nonatomic, strong) CustomNaviBarView *customNavbar;

- (void)bringNaviBarToTopmost;

- (void)setNaviBarTitle:(NSString *)strTitle;
- (void)setNaviBarLeftBtn:(UIButton *)leftBtn;
- (void)setNaviBarRightBtn:(UIButton *)rightBtn;

- (void)naviBarAddCoverView:(UIView *)view;
- (void)naviBarAddCoverViewOnTitleView:(UIView *)view;
- (void)naviBarRemoveCoverView:(UIView *)view;

- (void)setNavigationCanDragBack:(BOOL)bCanDragBack;

@end
