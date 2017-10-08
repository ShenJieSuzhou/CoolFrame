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

@synthesize delegate = _delegate;
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
        //1.创建 UIScrollView
        _scrollView = [[UIScrollView alloc] init];
        
        _imgVLeft = [[UIImageView alloc] init];
        _imgVLeft.userInteractionEnabled = YES;
        [_scrollView addSubview:_imgVLeft];
        
        _imgVCenter = [[UIImageView alloc] init];
        _imgVCenter.userInteractionEnabled = YES;
        [_scrollView addSubview:_imgVCenter];
        
        _imgVRight = [[UIImageView alloc] init];
        _imgVRight.userInteractionEnabled = YES;
        [_scrollView addSubview:_imgVRight];
        
        //2.创建 UIPageControl
        _pageControl = [[UIPageControl alloc] init];
        
        //3.添加到视图
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
        //4.添加点击事件
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:tapGestureRecognize];
    }
    return self;
}


- (void)setProductsArray:(NSMutableArray *)productsArray{
    if(!productsArray){
        return;
    }
    
    _productsArray = [productsArray copy];
    _currentIndex = 0;
    [self setDefaultImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.bounds;
    [self initUIWithFrame:rect];
}

- (void)initUIWithFrame:(CGRect) frame{
    CGRect rect = frame;
    
    //scrollView 样式设置
    [_scrollView setFrame:rect];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(rect.size.width, 0) animated:NO];
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    //图片视图；左边
    [_imgVLeft setFrame:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
    _imgVLeft.contentMode = UIViewContentModeScaleAspectFill;
    
    //图片视图；中间
    [_imgVCenter setFrame:CGRectMake(rect.size.width, 0.0, rect.size.width, rect.size.height)];
    _imgVCenter.contentMode = UIViewContentModeScaleAspectFill;
    
    //图片视图；右边
    [_imgVRight setFrame:CGRectMake(rect.size.width * 2, 0.0, rect.size.width, rect.size.height)];
    _imgVRight.contentMode = UIViewContentModeScaleAspectFill;
    
    //pageControl 样式设置
    CGSize size= [_pageControl sizeForNumberOfPages:[_productsArray count]];
    _pageControl.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    _pageControl.center = CGPointMake(rect.size.width / 2.0, rect.size.height - 20.0);
    _pageControl.numberOfPages = [_productsArray count];
    
    //设置当前页指示器的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    //设置指示器的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
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

#pragma mark - click callback
- (void)singleTapGestureRecognizer:(UITapGestureRecognizer *)tapGesture {
    if([[self delegate] respondsToSelector:@selector(newsBanner:shouldSelectItemAtIndex:)]){
        if(![[self delegate] newsBanner:self shouldSelectItemAtIndex:_currentIndex]){
            return;
        }
    }
    
    if([[self delegate] respondsToSelector:@selector(newsBanner:didSelectItemAtIndex:)]){
        [_delegate newsBanner:self didSelectItemAtIndex:_currentIndex];
    }
//    [_delegate newsBanner:self didSelectItemAtIndex:_currentIndex];

}

@end
