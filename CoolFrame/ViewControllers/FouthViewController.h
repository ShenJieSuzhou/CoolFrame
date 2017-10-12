//
//  FouthViewController.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
@interface FouthViewController : CustomViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mineTableView;

@property (nonatomic, strong) NSArray *itemArray;

@end
