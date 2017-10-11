//
//  CustomVeriSlider.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomVeriSlider.h"
#define PRODUCT_COUNT  [_productArray count]

@implementation NewsPaneView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];

        _newsView = [[UIView alloc] init];
        [_newsView setBackgroundColor:[UIColor clearColor]];
        [_newsView setContentMode:UIViewContentModeScaleToFill];
        _newsView.clipsToBounds = YES;
        [self addSubview:_newsView];
        
        _newsText = [[UILabel alloc] init];
        [_newsText setTextColor:[UIColor blackColor]];
        [_newsText setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:_newsText];
        
        [_newsView addSubview:_newsText];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rcCell = [self bounds];
    _newsView.frame = [self bounds];
    
    [_newsText sizeToFit];
    _newsText.numberOfLines = 0;
    CGRect rcName = _newsText.frame;
    rcName.origin.x = 20;
    rcName.origin.y = 10;
    rcName.size.height = 20;
    rcName.size.width = rcCell.size.width - 40;
    _newsText.frame = rcName;
}

@end


@implementation CustomVeriSlider

@synthesize scrollView = _scrollView;
@synthesize productArray = _productArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_scrollView setFrame:self.bounds];
    _scrollView.contentSize = CGSizeMake(self.bounds.size.height * PRODUCT_COUNT, self.bounds.size.width);
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

}

- (void)setProductArray:(NSMutableArray *)productArray{
    if(!productArray){
        return;
    }
    
    _productArray = [productArray copy];
    [self loadProductView];
}

- (void)loadProductView{
    for(int i = 0; i < PRODUCT_COUNT; i++){

        NewsPaneView *productpane = [[NewsPaneView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * i, self.frame.size.width, self.frame.size.height)];
        [_scrollView addSubview:productpane];
        NSString *text = [_productArray objectAtIndex:i];
        [productpane.newsText setText:text];
    }
}

@end
