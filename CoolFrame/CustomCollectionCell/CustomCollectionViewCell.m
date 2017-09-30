//
//  CustomCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/29.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

@synthesize menuItem = _menuItem;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [_menuItem setFrame:frame];
        [self addSubview:_menuItem];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
