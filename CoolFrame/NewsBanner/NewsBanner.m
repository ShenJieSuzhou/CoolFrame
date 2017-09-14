//
//  NewsBanner.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/14.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "NewsBanner.h"

@implementation NewsBanner

@synthesize newsView = _newsView;
@synthesize productsArray = _productsArray;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

+ (NewsBanner *)getInstance{
    static NewsBanner *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NewsBanner alloc] init];
    });
    
    return _instance;
}

- (void)initUIWithFrame:(CGRect)rect{
    _newsView = [[UIView alloc] initWithFrame:rect];
    
    //1.创建 UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 50, 314, 500)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(rect.size.width, rect.size.height);
    _scrollView.scrollEnabled = YES;
    _scrollView.contentOffset = CGPointMake(rect.size.width / 2, rect.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    //2.创建 UIPageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(50, 600, 314, 34)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = [_productsArray count];
    _pageControl.currentPage = 0;  //当前页
    //只有一页的时候隐藏
    _pageControl.hidesForSinglePage = YES;
    //设置当前页指示器的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    //设置指示器的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    //3.添加到视图
    [_newsView addSubview:_scrollView];
    [_newsView addSubview:_pageControl];
    
}

- (void)setProductsArray:(NSMutableArray *)productsArray{
    _productsArray = [productsArray copy];
    
    for (int i = 0; i < [_productsArray count]; i++) {
        NSString *url = [_productsArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_newsView.frame];
        [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
        //添加 UIImageView 的响应事件
        
        [_newsView addSubview:imageView];
    }
    
}

@end
