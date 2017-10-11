//
//  CustomNewsBanner.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNewsBanner.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CustomNewsBanner

@synthesize productsArray = _productsArray;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentIndex = _currentIndex;
@synthesize imgVLeft = _imgVLeft;
@synthesize imgVRight = _imgVRight;
@synthesize imgVCenter = _imgVCenter;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.创建 UIScrollView
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        //图片视图；左边
        _imgVLeft = [[UIImageView alloc] init];
        _imgVLeft.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imgVLeft];
        
        //图片视图；中间
        _imgVCenter = [[UIImageView alloc] init];
        _imgVCenter.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imgVCenter];
        
        //图片视图；右边
        _imgVRight = [[UIImageView alloc] init];
        _imgVRight.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imgVRight];
        
        //2.创建 UIPageControl
        _pageControl = [[UIPageControl alloc] init];
        //设置当前页指示器的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        //设置指示器的颜色
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        
        //3.添加到视图
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
        //4.添加点击响应
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_scrollView addGestureRecognizer:tap];
        [_scrollView setUserInteractionEnabled:YES];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    [_scrollView setFrame:rect];
    _scrollView.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
    [_scrollView setContentOffset:CGPointMake(rect.size.width, 0) animated:NO];
    
    //图片视图；左边
    [_imgVLeft setFrame:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
    
    //图片视图；中间
    [_imgVCenter setFrame:CGRectMake(rect.size.width, 0.0, rect.size.width, rect.size.height)];
    
    //图片视图；右边
     [_imgVRight setFrame:CGRectMake(rect.size.width * 2, 0.0, rect.size.width, rect.size.height)];
    
    //2.创建 UIPageControl
    CGSize size= [_pageControl sizeForNumberOfPages:[_productsArray count]];
    _pageControl.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    _pageControl.center = CGPointMake(rect.size.width / 2.0, rect.size.height - 20.0);
    _pageControl.numberOfPages = [_productsArray count];
}

- (void)setProductsArray:(NSMutableArray *)productsArray{
    if(!productsArray){
        return;
    }
    
    _productsArray = [productsArray copy];
    _currentIndex = 0;
    [self setDefaultImage];
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
    [_imgVCenter sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
    
    //重新设置左右图片
    leftImageIndex = (int)(_currentIndex+imageCount-1)%imageCount;
    rightImageIndex = (int)(_currentIndex+1)%imageCount;
    
    NSString *url1 = [_productsArray objectAtIndex:leftImageIndex];
    [_imgVLeft sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
    
    NSString *url2 = [_productsArray objectAtIndex:rightImageIndex];
    [_imgVRight sd_setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
}

- (void)setDefaultImage{
    int count = (int)[_productsArray count];
    NSString *url = [_productsArray objectAtIndex:count - 1];
    [_imgVLeft sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
    
    NSString *url1 = [_productsArray objectAtIndex:0];
    [_imgVCenter sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
    
    NSString *url2 = [_productsArray objectAtIndex:1];
    [_imgVRight sd_setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
    
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

#pragma mark - UITapGestureRecognizer
-(void)handleTap:(id)sender{
    if([[self delegate] respondsToSelector:@selector(newsbanner:didSelectItemAtIndex:)]){
        [_delegate newsbanner:self didSelectItemAtIndex:_currentIndex];
    }
}

@end
