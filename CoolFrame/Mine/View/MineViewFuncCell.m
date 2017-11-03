//
//  MineViewFuncCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/20.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "MineViewFuncCell.h"

@implementation MineViewFuncCell

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
        self.menuName.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0f];
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
    [self.imgIcon setFrame:CGRectMake((self.frame.size.width - self.frame.size.width/3)/2, 10, self.frame.size.width/3, self.frame.size.width/3)];
    self.menuName.frame = CGRectMake((self.frame.size.width - self.frame.size.width/2)/2, self.frame.size.height - 20, self.frame.size.width/2, 13);
}

@end
