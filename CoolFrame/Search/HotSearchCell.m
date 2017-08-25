//
//  HotSearchCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/8/10.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HotSearchCell.h"
#import "GlobalDefine.h"

@implementation HotSearchCell
@synthesize prev_X = _prev_X;
@synthesize prev_Y = _prev_Y;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithHotKeys:(NSArray *)hotKeyArray{
    _prev_X = 0.0f;
    _prev_Y = 20.0f;
    
    for (int i = 0; i < [hotKeyArray count]; i++){
        NSString *hotStr = [hotKeyArray objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:hotStr forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if(i == 3){
            _prev_X = 0.0f;
            _prev_Y = _prev_Y + 40 + 10;
        }
        
        [self addButtonWithTag:btn Index:i Tag:i+100];
    }
}

- (void)addButtonWithTag:(UIButton *)btn Index:(int)index Tag:(int)tag{

    [btn setFrame:CGRectMake(_prev_X + 10 + 10*ScreenScale, _prev_Y, 70, 40)];
    _prev_X = _prev_X + 10 + 70;
    
    [self addSubview:btn];
}



@end
