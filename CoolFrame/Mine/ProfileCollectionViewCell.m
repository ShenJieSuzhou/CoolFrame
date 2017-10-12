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

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.textlabel = [[UILabel alloc] init];
        
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
    [self.textlabel setFrame:CGRectMake(30, (rect.size.height - 40)/2, rect.size.width, 40)];
}

@end
