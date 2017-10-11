//
//  SearchViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/8/4.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomNaviBarView.h"
#import "GlobalDefine.h"
#import "JSONKit.h"
#import "SearchResultCell.h"

static NSArray *data;
static NSArray *hotSearch;

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize searchController = _searchController;
@synthesize searchResultTableView = _searchResultTableView;
@synthesize searchResultDataSource = _searchResultDataSource;
@synthesize recentSearchKeys = _recentSearchKeys;
@synthesize noSearchResultView = _noSearchResultView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    data = @[@"习近平对四川九寨沟7.0级地震作出重要指示",
             @"五年深改成绩单  不畏深水  砥砺奋进  治国理政",
             @"俞正声观看庆内蒙古自治区成立70周年文艺晚会",
             @"微电影：哪怕当裤子也要打狗棍  专题",
             @"九寨沟地震已致13人死亡 轻伤180人重伤37人",
             @"中央气象台发布震区未来三天天气预报：阴有雨",
             @"新疆精河县6.6级地震 已致32伤其中2人重伤",
             @"销量低迷的锤子手机还值得投资吗？",
             @"田径世锦赛官方酒店爆发食物中毒：30人受影响"];
    
    hotSearch = @[@"习近平", @"四川", @"九寨沟", @"地震", @"指示", @"天气预报"];
    
    [self.view setBackgroundColor:RGBA(31, 27, 38, 1)];

    self.searchController = [[NaviBarSearchController alloc] initWithParentViewCtrl:self];
    self.searchController.delegate = self;
    [self.searchController resetPlaceHolder:@"搜索关键字"];
    [self.searchController showFixationSearchCtrl];
    self.recentSearchKeys = [NSMutableArray new];
    
    [self initRecentKeywords];
    [self.searchController setRecentKeyword:_recentSearchKeys];

    CGRect bound = CGRectMake(0, [CustomNaviBarView barSize].height, ScreenWidth, ScreenHeight - [CustomNaviBarView barSize].height);
    self.searchResultDataSource = [NSMutableArray new];
    self.searchResultTableView = [[UITableView alloc] initWithFrame:bound style:UITableViewStylePlain];
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    [self.searchResultTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.searchResultTableView.hidden = YES;
    [self.searchResultTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.searchResultTableView];
    
    self.noSearchResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    [self.noSearchResultView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *noResultIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_searchresult"]];
    [self.noSearchResultView addSubview:noResultIcon];
    noResultIcon.center = CGPointMake(60, 48);
    
    UILabel *noSearchResultTip = [[UILabel alloc] init];
    [noSearchResultTip setBackgroundColor:[UIColor whiteColor]];
    [noSearchResultTip setTextAlignment:NSTextAlignmentCenter];
    [noSearchResultTip setText:@"抱歉，好像什么都没有..."];
    [noSearchResultTip setTextColor:[UIColor whiteColor]];
    [self.noSearchResultView addSubview:noSearchResultTip];
    noSearchResultTip.center = CGPointMake(60, 108);
    [self.searchResultTableView addSubview:self.noSearchResultView];
    self.noSearchResultView.center = CGPointMake(ScreenWidth/2, 150);
    self.noSearchResultView.hidden = YES;
    
    //初始化热搜榜
    [self.searchController setHotSearchKeys:hotSearch];
}

- (void)viewWillAppear:(BOOL)animated{
    [_searchController startSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initRecentKeywords{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [Paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"recentkeywords.json"];
    
    if(![fileManager fileExistsAtPath:path]){
        [self.recentSearchKeys addObjectsFromArray:@[]];
        NSData *jsonData = [self.recentSearchKeys JSONData];
        if(jsonData){
            [jsonData writeToFile:path atomically:YES];
        }
    }
    
    NSData *jsonData = [[NSFileManager defaultManager] contentsAtPath:path];
    NSArray *list = [jsonData objectFromJSONData];
    [self.recentSearchKeys addObjectsFromArray:list];
}


#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _searchResultTableView){
        if(_searchResultDataSource){
            return _searchResultDataSource.count;
        }
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if(!cell){
        cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if(!_searchResultDataSource || [_searchResultDataSource count] == 0) return cell;
    
    NSString *strResult = [_searchResultDataSource objectAtIndex:indexPath.row];
    [cell.result setText:strResult];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到指定页面
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 55.0f;
}


#pragma mark -NaviBarSearchControllerDelegate
- (void)naviBarSearchCtrl:(NaviBarSearchController *)ctrl searchKeyword:(NSString *)strKeyword{
    if (strKeyword && strKeyword.length > 0) {
        if(![_recentSearchKeys containsObject:strKeyword]){
            [_recentSearchKeys addObject:strKeyword];
        }
        
        [_searchController setRecentKeyword:_recentSearchKeys];
    
        [_searchResultDataSource removeAllObjects];
        [_searchResultTableView reloadData];
        
        for (int index = 0; index < [data count]; index++) {
            NSString *strValue = [data objectAtIndex:index];
            if([strValue containsString:strKeyword]){
                [_searchResultDataSource addObject:strValue];
            }
        }
        
        [_searchResultTableView setHidden:NO];
        if([_searchResultDataSource count] > 0){
            [_noSearchResultView setHidden:YES];
        }else{
            [_noSearchResultView setHidden:NO];
        }
        [_searchResultTableView reloadData];
        
        NSData *jsonData = [_recentSearchKeys JSONData];
        NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString*documentsDirectory =[paths objectAtIndex:0];
        
        NSString*path =[documentsDirectory stringByAppendingPathComponent:@"recentkeywords.json"];
        [jsonData writeToFile:path atomically:YES];
    }
}

- (void)naviBarSearchCtrlCancel:(NaviBarSearchController *)ctrl{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)naviBarSearchCtrlClearKeywordRecord:(NaviBarSearchController *)ctrl{
    [_searchController setRecentKeyword:nil];
    [_recentSearchKeys removeAllObjects];
    
    NSData *jsonData = [_recentSearchKeys JSONData];
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    
    NSString*path =[documentsDirectory stringByAppendingPathComponent:@"recentkeywords.json"];
    [jsonData writeToFile:path atomically:YES];
}

- (void)naviBarSearchCtrlStartSearch:(NaviBarSearchController *)ctrl{
    [_searchResultTableView setHidden:YES];
}

- (void)naviBarSearchCtrl:(NaviBarSearchController *)ctrl clickHotSearchKey:(NSString*)searchKey{

}

- (void)naviBarSearchCtrlRefreshHotSearchKey:(NaviBarSearchController *)ctrl{

}

- (void)naviBarSearchCtrl:(NaviBarSearchController *)ctrl RemoveSearchRecord:(NSString*)searchRecord{
    [_recentSearchKeys removeObject:searchRecord];
    [_searchController setRecentKeyword:_recentSearchKeys];
    
    NSData *jsonData = [_recentSearchKeys JSONData];
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    
    NSString*path =[documentsDirectory stringByAppendingPathComponent:@"recentkeywords.json"];
    [jsonData writeToFile:path atomically:YES];
}



@end
