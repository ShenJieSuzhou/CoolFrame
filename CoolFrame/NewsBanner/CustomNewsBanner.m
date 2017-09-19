//
//  CustomNewsBanner.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNewsBanner.h"

@implementation CustomNewsBanner

@synthesize productsArray = _productsArray;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentIndex = _currentIndex;
@synthesize imgVLeft = _imgVLeft;
@synthesize imgVRight = _imgVRight;
@synthesize imgVCenter = _imgVCenter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setNewsBannerInfo:(NSMutableArray *)products{
    if(!products){
        return;
    }
    
    _productsArray = [products copy];
    
    _currentIndex = 0;
    [self initUIWithFrame];
    [self setDefaultImage];
}

- (void)initUIWithFrame{
    CGRect rect = self.frame;
    
    //1.创建 UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(rect.size.width, 0) animated:NO];
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    //图片视图；左边
    _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
    _imgVLeft.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imgVLeft];
    
    //图片视图；中间
    _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width, 0.0, rect.size.width, rect.size.height)];
    _imgVCenter.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imgVCenter];
    
    //图片视图；右边
    _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width * 2, 0.0, rect.size.width, rect.size.height)];
    _imgVRight.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imgVRight];
    
    //2.创建 UIPageControl
    _pageControl = [[UIPageControl alloc] init];
    CGSize size= [_pageControl sizeForNumberOfPages:[_productsArray count]];
    _pageControl.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    _pageControl.center = CGPointMake(rect.size.width / 2.0, rect.size.height - 20.0);
    _pageControl.numberOfPages = [_productsArray count];
    
    //设置当前页指示器的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    //设置指示器的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    //3.添加到视图
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}

- (void)reloadImage{
    int leftImageIndex, rightImageIndex;
    NSInteger imageCount = [_productsArray count];
    
    CGPoint contentOffset = [_scrollView contentOffset];
    
    //向右滑动
    if(contentOffset.x > self.frame.size.width){
        _currentIndex = (int)(_currentIndex + 1) % imageCount;
    }else if(contentOffset.x < self.frame.size.width){
        _currentIndex = (int)(_currentIndex - 1 + imageCount) % imageCount;
    }
    
    NSString *url = [_productsArray objectAtIndex:_currentIndex];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    _imgVCenter.image = [UIImage imageWithData:imgData];
    
    //重新设置左右图片
    leftImageIndex = (int)(_currentIndex+imageCount-1)%imageCount;
    rightImageIndex = (int)(_currentIndex+1)%imageCount;
    
    NSString *url1 = [_productsArray objectAtIndex:leftImageIndex];
    NSData *imgData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url1]];
     _imgVLeft.image=[UIImage imageWithData:imgData1];
    
    NSString *url2 = [_productsArray objectAtIndex:rightImageIndex];
    NSData *imgData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url2]];
    _imgVRight.image=[UIImage imageWithData:imgData2];
}

- (void)setDefaultImage{
    int count = (int)[_productsArray count];
    NSString *url = [_productsArray objectAtIndex:count - 1];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    _imgVLeft.image = [UIImage imageWithData:imgData];
    
    NSString *url1 = [_productsArray objectAtIndex:0];
    NSData *imgData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url1]];
    _imgVCenter.image = [UIImage imageWithData:imgData1];
    
    NSString *url2 = [_productsArray objectAtIndex:1];
    NSData *imgData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url2]];
    _imgVRight.image = [UIImage imageWithData:imgData2];
    
    _currentIndex = 0;
    _pageControl.currentPage = _currentIndex;
}

#pragma mark - UIScrollViewDelegate

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    //页码设置
    _pageControl.currentPage = _currentIndex;
}

@end
