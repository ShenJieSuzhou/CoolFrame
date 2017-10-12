//
//  HeadCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/12.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HeadCollectionViewCell.h"

@implementation HeadCollectionViewCell
@synthesize imgIcon = _imgIcon;
@synthesize name = _name;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.imgIcon = [[UIImageView alloc] init];
        self.name = [[UILabel alloc] init];
        
        self.imgIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self.imgIcon setBackgroundColor:[UIColor blueColor]];
        
        self.name.textAlignment = NSTextAlignmentLeft;
        self.name.font = [UIFont systemFontOfSize:12.0];
        self.name.textColor = [UIColor grayColor];
        [self addSubview:self.imgIcon];
        [self addSubview:self.name];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgIcon setFrame:CGRectMake(30, (self.frame.size.height - 70)/2, 70, 70)];
    CGFloat nameX = self.imgIcon.frame.origin.x + self.imgIcon.frame.size.width + 50.0f;
    CGFloat nameY = (self.frame.size.height - self.frame.size.width/4)/2;
    [self.name setFrame:CGRectMake(nameX, nameY, 150, 20)];
}

@end
