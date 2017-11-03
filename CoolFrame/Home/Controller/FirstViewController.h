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
#import "HomePageCell.h"

@interface FirstViewController : CustomViewController<UITableViewDataSource, UITableViewDelegate, CustomMenuDelegate>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSMutableArray *tableDataArray;

@end
