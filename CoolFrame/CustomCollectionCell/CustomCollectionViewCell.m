//
//  CustomCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/29.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

@synthesize imgIcon = _imgIcon;
@synthesize menuName = _menuName;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.imgIcon = [[UIImageView alloc] init];
        self.menuName = [[UILabel alloc] init];
        
        self.imgIcon.contentMode = UIViewContentModeScaleAspectFit;
        
        self.menuName.textAlignment = NSTextAlignmentCenter;
        self.menuName.font = [UIFont systemFontOfSize:12.0];
        self.menuName.textColor = [UIColor grayColor];
        [self addSubview:self.imgIcon];
        [self addSubview:self.menuName];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgIcon setFrame:CGRectMake(15, 10, self.frame.size.width - 30, self.frame.size.width - 30)];
    self.menuName.frame = CGRectMake(15, self.frame.size.height - 12, self.frame.size.width - 30, 12);
}

@end
