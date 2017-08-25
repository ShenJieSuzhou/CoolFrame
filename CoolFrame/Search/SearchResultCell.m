//
//  SearchResultCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/8/10.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "SearchResultCell.h"
#import "GlobalDefine.h"

@implementation SearchResultCell
@synthesize result = _result;
@synthesize sep = _sep;

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
        self.result = [[UILabel alloc] init];
        [self.result setTextColor:[UIColor whiteColor]];
        [self.result setFont:[UIFont systemFontOfSize:17]];
        [self.contentView addSubview:self.result];
        
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
    
    CGRect rcCell = [self bounds];
    [self.result sizeToFit];
    CGRect rcName = self.result.frame;
    rcName.origin.x = 20;
    rcName.origin.y = 15;
    self.result.frame = rcName;
    
    CGRect rcSep = CGRectMake(20, 50 , rcCell.size.width - 40, 4);
    self.sep.frame = rcSep;
}



@end
