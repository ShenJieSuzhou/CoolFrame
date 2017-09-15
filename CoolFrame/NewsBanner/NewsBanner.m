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
@synthesize currentIndex = _currentIndex;
@synthesize imgVLeft = _imgVLeft;
@synthesize imgVRight = _imgVRight;
@synthesize imgVCenter = _imgVCenter;

+ (NewsBanner *)getInstance{
    static NewsBanner *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NewsBanner alloc] init];
    });
    
    return _instance;
}

- (void)createNewsBanner:(NSMutableArray *)products frame:(CGRect)rect{
    _currentIndex = 0;
    [self setProductsArray:products];
    [self initUIWithFrame:rect];
    [self setDefaultImage];
}

- (void)setNewsBannerFrame:(CGRect)rect;

- (void)setNewsBannerInfo:(NSMutableArray *)products；


- (UIView *)getNewsBanner{
    return _newsView;
}

- (void)initUIWithFrame:(CGRect)rect{
    _newsView = [[UIView alloc] initWithFrame:rect];
    
    //1.创建 UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
//    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentOffset = CGPointMake(rect.size.width, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    
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
//    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = [_productsArray count];
    //只有一页的时候隐藏
//    _pageControl.hidesForSinglePage = YES;
    //设置当前页指示器的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    //设置指示器的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    //3.添加到视图
    [_newsView addSubview:_scrollView];
    [_newsView addSubview:_pageControl];
}

- (void)setProductsArray:(NSMutableArray *)productsArray{
    if(!productsArray) return;
    
    _productsArray = [productsArray copy];
}

- (void)reloadImage{
    CGPoint contentOffset = [_scrollView contentOffset];
    NSInteger imageCount = [_productsArray count];
    int leftImageIndex, rightImageIndex;
    
    //向右滑动
    if(contentOffset.x > _newsView.frame.size.width){
        _currentIndex = (int)(_currentIndex + 1) % imageCount;
    }else if(contentOffset.x < _newsView.frame.size.width){
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
    
    NSString *url2 = [_productsArray objectAtIndex:rightImageIndex];
    NSData *imgData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url2]];
    
    _imgVLeft.image=[UIImage imageWithData:imgData1];
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"%f", scrollView.contentOffset.x);
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f", scrollView.contentOffset.x);
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [_scrollView setContentOffset:CGPointMake(_newsView.frame.size.width, 0) animated:NO];
    //设置分页
    _pageControl.currentPage = _currentIndex;
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

@end
