//
//  SearchViewController.h
//  CoolFrame
//
//  Created by silicon on 2017/8/4.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "NaviBarSearchController.h"


@interface SearchViewController : CustomViewController<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,NaviBarSearchControllerDelegate>

@property (strong, nonatomic) NaviBarSearchController *searchController;
@property (strong, nonatomic) UITableView *searchResultTableView;
@property (strong, nonatomic) NSMutableArray *searchResultDataSource;
@property (strong, nonatomic) NSMutableArray *recentSearchKeys;
@property (strong, nonatomic) UIView *noSearchResultView;
@end
