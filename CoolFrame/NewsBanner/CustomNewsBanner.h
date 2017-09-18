//
//  CustomNewsBanner.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNewsBanner : UIView<UIScrollViewDelegate>

//存储待显示产品的数组
@property (strong, nonatomic) NSMutableArray *productsArray;

//左右滑动
@property (strong, nonatomic) UIScrollView *scrollView;

//页面控制
@property (strong, nonatomic) UIPageControl *pageControl;

//当前页索引标记
@property (assign, nonatomic) int currentIndex;

@property (strong, nonatomic) UIImageView *imgVLeft;
@property (strong, nonatomic) UIImageView *imgVCenter;
@property (strong, nonatomic) UIImageView *imgVRight;

- (void)setNewsBannerInfo:(NSMutableArray *)products;

@end

