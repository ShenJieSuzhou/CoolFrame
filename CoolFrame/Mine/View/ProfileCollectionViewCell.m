//
//  ProfileCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/12.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell

@synthesize textlabel = _textlabel;
@synthesize iconView = _iconView;
@synthesize arrow = _arrow;
@synthesize sep = _sep;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.textlabel = [[UILabel alloc] init];
        [self.textlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [self.textlabel setTextColor:[UIColor blackColor]];
        
        self.iconView = [[UIImageView alloc] init];
        self.arrow = [[UIImageView alloc] init];
        self.sep = [[UIImageView alloc] init];
        [self.sep setContentMode:UIViewContentModeBottom];
        self.sep.clipsToBounds = YES;
        
        [self addSubview:self.iconView];
        [self addSubview:self.textlabel];
        [self addSubview:self.arrow];
        [self addSubview:self.sep];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.bounds;
    CGFloat margin = 10.0f;
    
    [self.iconView setFrame:CGRectMake(2*margin, (rect.size.height - 25)/2, 25, 25)];
    [self.textlabel setFrame:CGRectMake(3*margin + self.iconView.frame.size.width , (rect.size.height - 20)/2, rect.size.width, 20)];
    [_arrow setFrame:CGRectMake(rect.size.width - 40, (rect.size.height - 20)/2, 20, 20)];
    [_sep setFrame:CGRectMake(20, rect.size.height - 1 , rect.size.width - 40, 1)];
}

@end
