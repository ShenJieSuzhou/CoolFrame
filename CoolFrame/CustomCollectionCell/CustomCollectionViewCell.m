//
//  CustomCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/29.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "GlobalDefine.h"

@implementation CustomCollectionViewCell

@synthesize menuName = _menuName;
@synthesize iconImgV = _iconImgV;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self iconImgV]];
        [self.contentView addSubview:[self menuName]];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.frame;
    [_menuName setFrame:CGRectMake(15, rect.size.height - 15, rect.size.width - 30, 15)];
    
    [_iconImgV setFrame:CGRectMake(15 , 10, rect.size.width - 30, rect.size.width - 30)];
}

- (UILabel *)menuName{
    if(!_menuName){
        _menuName = [[UILabel alloc] init];
        [_menuName setTextAlignment:NSTextAlignmentCenter];
        [_menuName setTextColor:RGB(0, 0, 0)];
        [_menuName setFont:NQFONT(10)];
    }
    
    return _menuName;
}

- (UIImageView *)iconImgV{
    if(!_iconImgV){
        _iconImgV = [[UIImageView alloc] init];
    }
    
    return _iconImgV;
}

@end
