//
//  CustomHorizSlider.m
//  CoolFrame
//
//  Created by silicon on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomHorizSlider.h"
#define PRODUCT_COUNT  [_productArray count]

@implementation productPaneView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //两边边距 20 个像素
    CGFloat margin = 10.0f;
    
    CGRect rcCell = [self bounds];
    [self.label sizeToFit];
    self.label.numberOfLines = 0;
    CGRect rcName = self.label.frame;
    rcName.origin.x = margin;
    rcName.origin.y = margin;
    rcName.size.height = 50;
    rcName.size.width = rcCell.size.width - margin*2;
    self.label.frame = rcName;
    
    CGRect rcImg= CGRectMake(margin, margin , rcCell.size.width - margin*2, rcCell.size.height - 3*margin - 50);
    self.imageView.frame = rcImg;
}

@end


@implementation CustomHorizSlider
@synthesize scrollView = _scrollView;
@synthesize productArray = _productArray;
@synthesize productPane = _productPane;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setProductArray:(NSMutableArray *)productArray{
    if(!productArray){
        return;
    }
    
    _productArray = [productArray copy];
}

- (void)loadProductView{
    for(int i = 0; i < PRODUCT_COUNT; i++){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.frame];
        UILabel *label = [[UILabel alloc] ]
    }
}

- (void)addScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * PRODUCT_COUNT, self.frame.size.height);
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    _scrollView.showsHorizontalScrollIndicator = NO;
}



@end
