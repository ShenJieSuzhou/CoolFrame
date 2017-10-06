//
//  CustomCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/29.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

//@synthesize menuItem = _menuItem;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        _menuItem = [[CustomMenuItem alloc] init];
        [self.contentView addSubview:_menuItem];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_menuItem setFrame:self.bounds];
}

- (void)setMenuItem:(CustomMenuItem *)menuItem{
    if(!menuItem){
        return;
    }
    _menuItem = menuItem;
    [self.contentView addSubview:menuItem];
}

@end
