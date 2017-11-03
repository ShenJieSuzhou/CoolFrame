//
//  CustomHorizSlider.m
//  CoolFrame
//
//  Created by silicon on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomHorizSlider.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define PRODUCT_COUNT  [_productArray count]

@implementation ProductPaneView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        _label = [[UILabel alloc] init];
        [_label setTextColor:[UIColor blackColor]];
        [_label setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:_label];
        
        _imageView = [[UIImageView alloc] init];
        [_imageView setBackgroundColor:[UIColor clearColor]];
        [_imageView setContentMode:UIViewContentModeScaleToFill];
        _imageView.layer.cornerRadius = 5.0f;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //两边边距 10 个像素
    CGFloat margin = 10.0f;
    CGRect rcCell = [self bounds];
    
    CGRect rcImg= CGRectMake(margin, 10 , rcCell.size.width - margin*2, rcCell.size.height - 2*margin - 50);
    self.imageView.frame = rcImg;
    
    [self.label sizeToFit];
    self.label.numberOfLines = 0;
    CGRect rcName = self.label.frame;
    rcName.origin.x = margin;
    rcName.origin.y = rcCell.size.height - 60;
    rcName.size.height = 50;
    rcName.size.width = rcCell.size.width - margin*2;
    self.label.frame = rcName;
}

@end


@implementation CustomHorizSlider
@synthesize scrollView = _scrollView;
@synthesize productArray = _productArray;


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
    [self addScrollView];
    [self loadProductView];
}

- (void)loadProductView{
    for(int i = 0; i < PRODUCT_COUNT; i++){
        ProductPaneView *productpane = [[ProductPaneView alloc] initWithFrame:CGRectMake((self.frame.size.width - 150) * i, 0, self.frame.size.width - 150, self.frame.size.height)];
        [_scrollView addSubview:productpane];
        NSDictionary *dic = [_productArray objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:[dic objectForKey:@"ImgUrl"]];
        NSString *text = [dic objectForKey:@"Title"];
        [productpane.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
        [productpane.label setText:text];
    }
}

- (void)addScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake((self.frame.size.width - 150) * PRODUCT_COUNT, self.frame.size.height);
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
}



@end
