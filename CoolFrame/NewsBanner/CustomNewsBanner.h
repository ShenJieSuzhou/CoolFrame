//
//  CustomNewsBanner.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNewsBanner : UIView<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *datasourceImages;
@property (assign, nonatomic) NSUInteger currentSelectedPage;

@end

