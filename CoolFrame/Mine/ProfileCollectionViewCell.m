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

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.textlabel = [[UILabel alloc] init];
        self.iconView = [[UIImageView alloc] init];
        
        [self addSubview:self.iconView];
        [self addSubview:self.textlabel];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.frame;
    CGFloat margin = 10.0f;
    
    [self.iconView setFrame:CGRectMake(margin, (rect.size.height - 40)/2, 40, 40)];
    [self.textlabel setFrame:CGRectMake(2*margin + self.iconView.frame.size.width , (rect.size.height - 40)/2, rect.size.width, 40)];
}

@end
