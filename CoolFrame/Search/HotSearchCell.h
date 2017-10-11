//
//  HotSearchCell.h
//  CoolFrame
//
//  Created by shenjie on 2017/8/10.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotSearchCell : UITableViewCell

@property (assign) CGFloat prev_X;
@property (assign) CGFloat prev_Y;

- (void)initWithHotKeys:(NSArray *)hotKeyArray;

@end
