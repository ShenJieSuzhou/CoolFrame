//
//  NaviBarSearchController.h
//  CoolFrame
//
//  Created by shenjie on 2017/8/6.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomUISearchBar.h"
#import "CustomViewController.h"

@class NaviBarSearchController;
@protocol NaviBarSearchControllerDelegate <NSObject>

- (void)naviBarSearchCtrl:(NaviBarSearchController *)ctrl searchKeyword:(NSString *)strKeyword;
- (void)naviBarSearchCtrlCancel:(NaviBarSearchController *)ctrl;

@optional
- (void)naviBarSearchCtrlClearKeywordRecord:(NaviBarSearchController *)ctrl;
- (void)naviBarSearchCtrlStartSearch:(NaviBarSearchController *)ctrl;
- (void)naviBarSearchCtrl:(NaviBarSearchController *)ctrl clickHotSearchKey:(NSString*)searchKey;
- (void)naviBarSearchCtrlRefreshHotSearchKey:(NaviBarSearchController *)ctrl;
- (void)naviBarSearchCtrl:(NaviBarSearchController *)ctrl RemoveSearchRecord:(NSString*)searchRecord;

@end


@interface NaviBarSearchController : NSObject<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (strong, nonatomic) id<NaviBarSearchControllerDelegate> delegate;
@property (strong, nonatomic) CustomViewController *m_viewCtrlParent;
@property (strong, nonatomic) CustomUISearchBar *m_searchBar;
@property (strong, nonatomic) UIView *m_viewNaviBar;
@property (strong, nonatomic) UIImageView *m_viewBlackCover;
@property (strong, nonatomic) UIButton *m_btnCancel;
@property (strong, nonatomic) UITableView *m_tableView;

@property (assign) BOOL m_bIsFixation;
@property (assign) BOOL m_bIsCoverTitleView;
@property (assign) BOOL m_bIsWorking;

@property (strong, nonatomic) NSArray *m_arrRecent;
@property (strong, nonatomic) NSArray *m_arrHot;

@property (strong, nonatomic) UIImage *m_imgBlurBg;

- (id)initWithParentViewCtrl:(CustomViewController *)viewCtrl;

- (void)resetPlaceHolder:(NSString *)holderStr;

- (void)showTempSearchCtrl;
- (void)startSearch;
- (void)removeSearchCtrl;

- (void)showFixationSearchCtrl;
- (void)showFixationSearchCtrlOnTitleView;

- (void)setRecentKeyword:(NSArray *)arrRecentKeyword;
- (void)setKeyword:(NSString *)strKeyowrd;

- (void)setHotSearchKeys:(NSArray *)arrSearchKeys;


@end
