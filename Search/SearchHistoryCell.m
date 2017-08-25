//
//  SearchHistoryCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/8/10.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "SearchHistoryCell.h"
#import "GlobalDefine.h"

@implementation SearchHistoryCell
@synthesize sep = _sep;
@synthesize clear = _clear;
@synthesize history = _history;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        self.history = [[UILabel alloc] init];
        [self.history setTextColor:[UIColor whiteColor]];
        [self.history setFont:[UIFont systemFontOfSize:17]];
        [self.contentView addSubview:self.history];
        
        self.clear = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.clear setBackgroundColor:[UIColor clearColor]];
        [self.clear setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.clear];
        
        self.sep = [[UIImageView alloc] init];
        [self.sep setBackgroundColor:[UIColor clearColor]];
        [self.sep setContentMode:UIViewContentModeBottom];
        [self.sep setImage:[UIImage imageNamed:@"separator_line"]];
        self.sep.clipsToBounds = YES;
        [self.contentView addSubview:self.sep];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rcView = [self bounds];
    CGRect rcTitle= CGRectMake(10*ScreenScale, (rcView.size.height -20)/2, rcView.size.width/2 - 15, 20);
    self.history.frame = rcTitle;
    
    CGRect rcBtn = CGRectMake(rcView.size.width - 10*ScreenScale - 18, (rcView.size.height -20)/2, 18, 18);
    self.clear.frame = rcBtn;
    
    CGRect rcSep = CGRectMake(10*ScreenScale, rcView.size.height -4, rcView.size.width - 20*ScreenScale, 4);
    self.sep.frame = rcSep;
}


@end
