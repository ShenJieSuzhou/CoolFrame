//
//  FirstViewController.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "SearchViewController.h"

@interface FirstViewController : CustomViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) UILabel *label;

@end
