//
//  CustomNavBar.m
//  CoolFrame
//
//  Created by silicon on 2017/7/27.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar{
    CGSize _previousSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)sizeThatFits:(CGSize)size{
    size = [super sizeThatFits:size];
    if([UIApplication sharedApplication].statusBarHidden){
        size.height = 64;
    }
    
    return size;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if(CGSizeEqualToSize(self.bounds.size, _previousSize)){
        _previousSize = self.bounds.size;
        [self.layer removeAllAnimations];
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeAllAnimations)];
    }
    
}

@end
