//
//  NaviBarSearchController.m
//  CoolFrame
//
//  Created by shenjie on 2017/8/6.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "NaviBarSearchController.h"
#import "GlobalDefine.h"
#import "CustomNaviBarView.h"
#import "HotSearchCell.h"
#import "SearchHistoryCell.h"

#define RECT_NaviBar                            Rect(0.0f, StatusBarHeight, ScreenWidth, 44.0f)
#define RECT_SearchBarFrame                     Rect(0.0f, 0.0f, [CustomNaviBarView rightBtnFrame].origin.x + 10, 44.0f)
#define RECT_SearchBarCoverCancelBtnFrame       Rect(0.0f, 0.0f, ScreenWidth, NaviBarHeight)
#define RECT_CancelBtnFrame                     Rect([CustomNaviBarView rightBtnFrame].origin.x, 0.0f, [CustomNaviBarView rightBtnFrame].size.width, NaviBarHeight)

@interface SearchTableHeaderView : UIView

@property (strong, nonatomic) UIImageView *sep_line;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *btnOp;

@end

@implementation SearchTableHeaderView

@synthesize sep_line = _sep_line;
@synthesize titleLabel = _titleLabel;
@synthesize btnOp = _btnOp;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.titleLabel setTextColor:RGBA(255, 255, 255, 0.5)];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.titleLabel];
        
        self.btnOp = [[UIButton alloc] init];
        [self.btnOp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self.btnOp.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.btnOp setTitleColor:RGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
        [self.btnOp setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.btnOp];
        
        self.sep_line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator_line"]];
        [self.sep_line setContentMode:UIViewContentModeBottom];
        self.sep_line.clipsToBounds = YES;
        [self addSubview:self.sep_line];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rcView = [self bounds];
    CGRect rcTitle= CGRectMake(10*ScreenScale, (rcView.size.height -20)/2, rcView.size.width/2 - 15, 20);
    self.titleLabel.frame = rcTitle;
    
    CGRect rcBtn = CGRectMake(rcView.size.width - 10*ScreenScale - 50, (rcView.size.height -20)/2, 50, 20);
    self.btnOp.frame = rcBtn;
    
    CGRect rcSep = CGRectMake(10*ScreenScale, rcView.size.height -4, rcView.size.width - 20*ScreenScale, 4);
    self.sep_line.frame = rcSep;
}

@end


@implementation NaviBarSearchController

@synthesize delegate = _delegate;
@synthesize m_viewCtrlParent = _m_viewCtrlParent;
@synthesize m_viewNaviBar = _m_viewNaviBar;
@synthesize m_searchBar = _m_searchBar;
@synthesize m_btnCancel = _m_btnCancel;
@synthesize m_tableView = _m_tableView;
@synthesize m_arrRecent = _m_arrRecent;
@synthesize m_arrHot = _m_arrHot;
@synthesize m_viewBlackCover = _m_viewBlackCover;
@synthesize m_imgBlurBg = _m_imgBlurBg;
@synthesize m_bIsWorking = _m_bIsWorking;
@synthesize m_bIsFixation = _m_bIsFixation;
@synthesize m_bIsCoverTitleView = _m_bIsCoverTitleView;


- (id)initWithParentViewCtrl:(CustomViewController *)viewCtrl{

    self = [super init];
    if(self){
        self.m_viewCtrlParent = viewCtrl;
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.m_viewNaviBar = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44.0f)];
    
    //设置自定义的搜索栏
    self.m_searchBar = [[CustomUISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44.0f)];
    self.m_searchBar.placeholder = @"mo reng";
    self.m_searchBar.translucent = YES;
    self.m_searchBar.backgroundColor = [UIColor clearColor];
    self.m_searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UIColor *color = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.m_searchBar changeBarTextfieldWithColor:color bgImageName:nil];
    self.m_searchBar.delegate = self;
    
    self.m_btnCancel = [[UIButton alloc] init];
    [self.m_btnCancel setFrame:CGRectMake([CustomNaviBarView rightBtnFrame].origin.x, 0.0f, [CustomNaviBarView rightBtnFrame].size.width, 44.0f)];
    [self.m_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.m_btnCancel.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.m_btnCancel addTarget:self action:@selector(clickBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_btnCancel setTintColor:[UIColor whiteColor]];
    self.m_btnCancel.hidden = YES;
    
    [self.m_viewNaviBar addSubview:self.m_searchBar];
    [self.m_viewNaviBar addSubview:self.m_btnCancel];
    
    self.m_viewBlackCover = [[UIImageView alloc] initWithFrame:self.m_viewCtrlParent.view.bounds];
    [self.m_viewBlackCover setBackgroundColor:[UIColor clearColor]];
    self.m_viewBlackCover.userInteractionEnabled = YES;
    self.m_viewBlackCover.backgroundColor = RGBA(0.0f, 0.0f, 0.0f, 0.0f);
    
    UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToClose:)];
    [self.m_viewBlackCover addGestureRecognizer:tapToClose];
}

- (void)resetPlaceHolder:(NSString *)holderStr{
    self.m_searchBar.placeholder = holderStr;
}

//- (void)showTempSearchCtrl{
//    [self.m_viewCtrlParent naviBarAddCoverView:self.m_viewNaviBar];
//    self.m_bIsFixation = NO;
//    self.m_bIsCoverTitleView = NO;
//    
//    [self startSearch];
//}

- (void)startSearch{
    if(_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrlStartSearch:)]){
        [_delegate naviBarSearchCtrlStartSearch:self];
    }
    
    [self startWorking];
}

- (void)removeSearchCtrl{
    if([self.m_searchBar isFirstResponder]){
        [self.m_searchBar resignFirstResponder];
    }
    
    [_m_viewCtrlParent naviBarRemoveCoverView:self.m_viewNaviBar];
    [_m_viewBlackCover removeFromSuperview];
}

- (void)showFixationSearchCtrl{
    [self.m_viewCtrlParent naviBarAddCoverView:self.m_viewNaviBar];
    
    self.m_bIsFixation = YES;
    self.m_bIsCoverTitleView = NO;
}

//- (void)showFixationSearchCtrlOnTitleView{
//    [self.m_viewNaviBar setFrame:[CustomNaviBarView titleViewFrame]];
//    [self.m_searchBar setFrame:self.m_viewNaviBar.bounds];
//    
//    [self.m_viewCtrlParent naviBarAddCoverViewOnTitleView:self.m_viewNaviBar];
//    
//    self.m_bIsFixation = YES;
//    self.m_bIsCoverTitleView = YES;
//}

- (void)setRecentKeyword:(NSArray *)arrRecentKeyword{
    if(arrRecentKeyword){
        self.m_arrRecent = [NSArray arrayWithArray:arrRecentKeyword];
    }else{
        self.m_arrRecent = nil;
    }
    
    if(self.m_tableView){
        [self.m_tableView reloadData];
    }
}

- (void)setKeyword:(NSString *)strKeyowrd{
    if(self.m_searchBar){
        [self.m_searchBar setText:strKeyowrd];
    }
}

- (void)setHotSearchKeys:(NSArray *)arrSearchKeys{
    if(arrSearchKeys){
        self.m_arrHot = [NSArray arrayWithArray:arrSearchKeys];
    }else{
        self.m_arrHot = nil;
    }
    
    if(self.m_tableView){
        [self.m_tableView reloadData];
    }
}

#pragma mark -click event
- (void)clickBtnCancel:(id)sender{
    _m_searchBar.text = @"";
    [self endWorking];
    
    if(_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrlCancel:)]){
        [_delegate naviBarSearchCtrlCancel:self];
    }
}

- (void)handleTapToClose:(UIGestureRecognizer *)gesture{
    [self endWorking];
    
    if (_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrlCancel:)])
    {
        [_delegate naviBarSearchCtrlCancel:self];
    }
}

#pragma mark -start search
- (void)startWorking{
    _m_btnCancel.hidden = NO;
    if (_m_bIsCoverTitleView)
    {
        _m_viewNaviBar.frame = RECT_NaviBar;
        _m_searchBar.frame = RECT_SearchBarFrame;
    }
    else
    {
        _m_searchBar.frame = RECT_SearchBarFrame;
    }
    
    _m_viewBlackCover.alpha = 0.0f;
    [_m_viewCtrlParent.view addSubview:_m_viewBlackCover];
    
    if (![_m_searchBar isFirstResponder])
    {
        [_m_searchBar becomeFirstResponder];
    }else{}
    
    [self showRecentTable:YES];
    
    [_m_viewCtrlParent bringNaviBarToTopmost];
    
    _m_bIsWorking = YES;
}

- (void)endWorking{
    _m_btnCancel.hidden = NO;
    if (_m_bIsCoverTitleView)
    {
        _m_viewNaviBar.frame = [CustomNaviBarView titleViewFrame];
        _m_searchBar.frame = RECT_SearchBarFrame;
    }
    else
    {
        _m_searchBar.frame = RECT_SearchBarFrame;
    }
    
    if ([_m_searchBar isFirstResponder])
    {
        [_m_searchBar resignFirstResponder];
    }else{}
    [_m_viewBlackCover removeFromSuperview];
    
    [self showRecentTable:NO];
    
    _m_bIsWorking = NO;
}

- (void)showRecentTable:(BOOL)bIsShow{
    if(bIsShow){
        if(!self.m_tableView){
            self.m_tableView = [[UITableView alloc] initWithFrame:_m_viewCtrlParent.view.bounds style:UITableViewStylePlain];
            [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            [_m_viewCtrlParent.view addSubview:_m_tableView];
            
            UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToClose:)];
            tapToClose.delegate = self;
            [self.m_tableView addGestureRecognizer:tapToClose];
            [self.m_tableView setBackgroundColor:[UIColor clearColor]];
            
            self.m_tableView.delegate = self;
            self.m_tableView.dataSource = self;
        }
        
        self.m_tableView.hidden = NO;
        self.m_tableView.frame = Rect(_m_tableView.frame.origin.x, _m_tableView.frame.origin.y+_m_tableView.frame.size.height, _m_tableView.frame.size.width, _m_tableView.frame.size.height);
        [UIView animateWithDuration:0.3f animations:^()
         {
             _m_tableView.frame = CGRectMake(0,[CustomNaviBarView barSize].height, CGRectGetWidth(_m_viewCtrlParent.view.bounds), CGRectGetHeight(_m_viewCtrlParent.view.bounds) - [CustomNaviBarView barSize].height);
         }];
    }else{
        if(_m_tableView){
            [_m_tableView removeFromSuperview];
            _m_tableView = nil;
        }
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(searchBar.text){
        NSString *strKeyword = [[searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] copy];
        
        if(strKeyword.length > 0){
            searchBar.text = @"";
            [self endWorking];
            
            if (_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrl:searchKeyword:)]) {
                [_delegate naviBarSearchCtrl:self searchKeyword:strKeyword];
            }
        }else{
            searchBar.text = @"";
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self startSearch];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 1;
    }else if(section == 1){
        NSInteger iCount = self.m_arrRecent ? self.m_arrRecent.count : 0;
        return iCount;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        HotSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotsearchcell"];
        if(!cell){
            cell = [[HotSearchCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell initWithHotKeys:self.m_arrHot];
        }
        return cell;
    }else if(indexPath.section == 1){
        SearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"histroysearchcell"];
        if(!cell){
            cell = [[SearchHistoryCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        }

        [cell.history setText:[_m_arrRecent objectAtIndex:indexPath.row]];
        [cell.clear addTarget:self action:@selector(btnRemoveSearchRecord:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return nil;
}


#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strKeyword = [self.m_arrRecent objectAtIndex:indexPath.row];
    [self.m_searchBar setText:strKeyword];
    
    [self searchBarSearchButtonClicked:self.m_searchBar];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 120.0f;
    }else if(indexPath.section == 1){
        return 45.0f;
    }
    
    return 35.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SearchTableHeaderView *view = [[SearchTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    if(section == 0){
        [view.titleLabel setText:@"热搜"];
        [view.btnOp setTitle:@"换一批" forState:UIControlStateNormal];
        [view.btnOp addTarget:self action:@selector(btnNewHotSearchKeys:) forControlEvents:UIControlEventTouchUpInside];
    }else if(section == 1){
        [view.titleLabel setText:@"搜索历史"];
        [view.btnOp setTitle:@"清除" forState:UIControlStateNormal];
        [view.btnOp addTarget:self action:@selector(btnClearSearchRecord:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}

- (void)btnNewHotSearchKeys:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrlRefreshHotSearchKey:)]){
        [_delegate naviBarSearchCtrlRefreshHotSearchKey:self];
    }
}

- (void)btnClearSearchRecord:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrlClearKeywordRecord:)]){
        [_delegate naviBarSearchCtrlClearKeywordRecord:self];
    }
}

- (void)btnRemoveSearchRecord:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(naviBarSearchCtrl:RemoveSearchRecord:)]){
        SearchHistoryCell *cell = (SearchHistoryCell *)[[sender superview] superview];
        if(cell){
            NSIndexPath* indexPath = [_m_tableView indexPathForCell:cell];
            if(nil == indexPath) return;
            NSString *strKeyword = _m_arrRecent[indexPath.row];
            [_delegate naviBarSearchCtrl:self RemoveSearchRecord:strKeyword];
        }
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return YES;
}

































@end
