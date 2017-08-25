//
//  CustomNaviBarView.h
//  CoolFrame
//
//  Created by silicon on 2017/8/3.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNaviBarView : UIView

@property (nonatomic, strong) UIViewController *m_viewCtrlParent;
@property (nonatomic, strong) UIImage *m_background;

@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *imgViewBg;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;

//创建一个导航条按钮:自定义按钮样式
+ (UIButton *)createNavBarImageBtn:(NSString *)imgStr
                       Highligthed:(NSString *)imgHighStr
                            Target:(id)target
                            Action:(SEL)action;

//设置按钮与标题
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)titleStr;

// 在导航条上覆盖一层自定义视图。比如：输入搜索关键字时，覆盖一个输入框在上面。
- (void)showCoverView:(UIView *)view;
- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation;
- (void)showCoverViewOnTitleView:(UIView *)view;
- (void)hideCoverView:(UIView *)view;


+ (CGRect)leftBtnFrame;
+ (CGRect)rightBtnFrame;
+ (CGSize)barBtnSize;
+ (CGSize)barSize;
+ (CGRect)titleViewFrame;


@end
