//
//  CustomNewsBanner.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNewsBanner.h"


@implementation CustomNewsBanner

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSArray *subViews = self.subviews;
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self initialize];
}

- (void)setDatasourceImages:(NSArray *)datasourceImages{
    _datasourceImages = [datasourceImages copy];
}

- (void)initialize {
    self.clipsToBounds = YES;
    
    [self initializeScrollView];
    [self initializePageControl];
    
    [self loadData];
}

- (void)initializeScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.autoresizingMask = self.autoresizingMask;
    _scrollView.autoresizesSubviews = NO;
    [self addSubview:_scrollView];
}

- (void)initializePageControl {
    CGRect pageControlFrame = CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), 30);
    _pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    _pageControl.center = CGPointMake(CGRectGetWidth(_scrollView.frame)*0.5, CGRectGetHeight(_scrollView.frame) - 12.);
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}

- (void)loadData {
    if (_datasourceImages.count == 0) {
        //显示默认页，无数据页面
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:imageView];
        return;
    }
    
    _pageControl.numberOfPages = _datasourceImages.count;
    _pageControl.currentPage = 0;
    CGSize realSize = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
    _pageControl.bounds = CGRectMake(0.0, 0.0, realSize.width, realSize.height);
    _pageControl.center = CGPointMake(_scrollView.frame.size.width / 2.0, _scrollView.frame.size.height - 20.0);
    
    CGFloat contentWidth = CGRectGetWidth(_scrollView.frame);
    CGFloat contentHeight = CGRectGetHeight(_scrollView.frame);
    
    _scrollView.contentSize = CGSizeMake(contentWidth * _datasourceImages.count, contentHeight);
    
    for (NSInteger i = 0; i < _datasourceImages.count; i++) {
        CGRect imgRect = CGRectMake(contentWidth * i, 0, contentWidth, contentHeight);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgRect];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.clipsToBounds = YES;
        id imageSource = [_datasourceImages objectAtIndex:i];
        if ([imageSource isKindOfClass:[NSString class]]) {
            imageView.image = [UIImage imageNamed:imageSource];
        }

        [_scrollView addSubview:imageView];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = currentPage - 1;// 分页控制当前页数，跟scrollView当前显示的图片的页数同步.
    
    if (currentPage == _datasourceImages.count) { // 到第6张的时候返回0页
        _pageControl.currentPage = 0;
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0); // scrollView偏移量
        
    }else if (currentPage == 0) {   // 到0张的时候返回5页
        _pageControl.currentPage = _datasourceImages.count;
        scrollView.contentOffset = CGPointMake(_pageControl.currentPage * self.frame.size.width, 0);
    }
}

@end
