//
//  FirstViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "FirstViewController.h"
#import "SearchViewController.h"
#import "HomePageController.h"
#import "GlobalDefine.h"
#import "CustomNewsBanner.h"
#import "CustomHorizSlider.h"
#import "CustomVeriSlider.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize label = _label;
@synthesize tableDataArray = _tableDataArray;
@synthesize homeTableView = _homeTableView;

- (id)init{
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    /*
     * 主页搜索框设置
     */
    [self setNaviBarTitle:@"CoolFrame"];
    [self setNaviBarLeftBtn:nil];
    //设置搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(OnSearchBtnClick:) forControlEvents:UIControlEventTouchDragInside];
    [self setNaviBarRightBtn:searchBtn];
    
    /*
     * 主页界面设置，tableview 初始化
     */
    self.tableDataArray = [HomePageController getInstance].getHomePageData;
    
    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.customNavbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.customNavbar.frame.size.height - 40.0f) style:UITableViewStyleGrouped];
    
    [_homeTableView setBackgroundColor:RGB(220, 220, 220)];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    [self.view addSubview:_homeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc] init];
    }
    
    return _label;
}

- (void)OnSearchBtnClick:(id)sender{
    SearchViewController *searchVC = [SearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据 json 模版 决定每个 section 要显示几行数据
    NSMutableDictionary *dic = [_tableDataArray objectAtIndex:section];
    NSString *templateID = [dic objectForKey:@"cTemplateId"];
    int tid = [templateID intValue];
    int rows = 0;
    
    if(tid == 1 || tid == 3 || tid == 6){
        rows = 1;
    }else if(tid == 2 || tid == 4){
        rows = 1;
    }else if(tid == 5){
        rows = 5;
    }
    
    return rows;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     *  default cell pattern
     */
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSMutableDictionary *dic = [_tableDataArray objectAtIndex:indexPath.section];
    NSString *templateID = [dic objectForKey:@"cTemplateId"];
    switch ([templateID intValue]) {
        case 1:{
            NSMutableArray *newsArray = [dic objectForKey:@"NewsBanner"];
            HomePageProducts *productCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageProducts"];
            if(!productCell){
                productCell = [[HomePageProducts alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageProducts"];
            }
            
            [productCell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 180)];
            [productCell setItemsArray:newsArray];
            return productCell;
        }
        case 3:{
            NSMutableArray *tnewsArray = [dic objectForKey:@"FastLook"];
            UITableViewCell* tCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageFastLook"];
            if(!tCell){
                tCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageFastLook"];
            }
            [tCell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
            CustomVeriSlider *veriSlider = [[CustomVeriSlider alloc] initWithFrame:tCell.frame];
            [veriSlider setProductArray:tnewsArray];
            [tCell addSubview:veriSlider];
            return tCell;
        }
        case 6:{
            NSMutableArray *originalArray = [dic objectForKey:@"OriginalTopic"];
            UITableViewCell* originaCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageProducts6"];
            if(!originaCell){
                originaCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageProducts6"];
            }
            [originaCell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 180)];
            CustomHorizSlider *slider = [[CustomHorizSlider alloc] initWithFrame:originaCell.frame];
            [slider setProductArray:originalArray];
            [originaCell addSubview:slider];
            return originaCell;
        }
        case 2:{
            // Menu button loaded
            NSMutableArray *menuArray = [dic objectForKey:@"MenuData"];
            HomePageCollectionPattarnOne *menuCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCubeCell_section4"];
            if(!menuCell){
                menuCell = [[HomePageCollectionPattarnOne alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageCubeCell_section4"];
            }
            
            [menuCell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 170)];
            [menuCell setItemArray:menuArray];
            return menuCell;
        }
        case 4:{
            //goods loaded
            NSMutableArray *pkgArray = [dic objectForKey:@"PkgRecommend"];
            HomePageCollectionPattarnTwo *goodsCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCubeCell_section4"];
            if(!goodsCell){
                goodsCell = [[HomePageCollectionPattarnTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageCubeCell_section4"];
            }

            [goodsCell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 270)];
            [goodsCell setItemArray:pkgArray];
            return goodsCell;
        }
        case 5:{
            // News column
            NSMutableArray *topicArray = [dic objectForKey:@"TodayTopic"];
            NSMutableDictionary *dic = [topicArray objectAtIndex:indexPath.row];
            HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTodayTopicCell"];
            if(!cell){
                cell = [[HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageTodayTopicCell"];
            }
            
            //适配 iPhone 端大小，ipad端需另做设计
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
            NSString *topicTitle = [dic objectForKey:@"Title"];
            NSString *url = [dic objectForKey:@"ImgUrl"];
            
            [cell.textLabel setText:topicTitle];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageProgressiveDownload];
            
            return cell;
        }
        default:{
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
            return cell;
        }
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableDataArray count];
}

#pragma mark -tableViewDelegate

// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self tableView:tableView viewForHeaderInSection:section]){
        return [self tableView:tableView viewForHeaderInSection:section].frame.size.height;
    }else{
        return 0.0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 42.0f)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    headView.layer.borderWidth = 0;
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *headviewTitle = [[UILabel alloc] init];
    [headviewTitle setFont:[UIFont systemFontOfSize:15.0f]];
    headviewTitle.backgroundColor = [UIColor clearColor];
    
    //更多的跳转
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    [moreBtn addTarget:self action:@selector(jumpToSpecficContent) forControlEvents:UIControlEventTouchUpInside];
    
    //添加栏目名称
    [headView addSubview:headviewTitle];
    
    NSMutableDictionary *columnDic = [self.tableDataArray objectAtIndex:section];
    if([[columnDic objectForKey:@"cHeadlineShow"] intValue] < 1){
        return nil;
    }
    
    if([columnDic objectForKey:@"sTitle"]){
        NSString *headTitle = [columnDic objectForKey:@"sTitle"];
        [headviewTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        [headviewTitle setFrame:CGRectMake(20, 12, 80, 20)];
        [headviewTitle setText:headTitle];
    }
    
    if([columnDic objectForKey:@"sSubtitle"]){
        NSString *sSubtitle = [columnDic objectForKey:@"sSubtitle"];
        
        [moreBtn setFrame:CGRectMake(tableView.frame.size.width - 65, 12, 40, 20)];
        [moreBtn setTitle:sSubtitle forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [headView addSubview:moreBtn];
        
        [arrowImage setFrame:CGRectMake(tableView.frame.size.width - 30, 15, 13, 13)];
        [arrowImage setImage:[UIImage imageNamed:@"redarrowRighticon"]];
        [headView addSubview:arrowImage];
    }
    
    return headView;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSMutableDictionary *dic = [_tableDataArray objectAtIndex:section];
    NSString *templateID = [dic objectForKey:@"cTemplateId"];
    int tid = [templateID intValue];
    if(tid == 1 || tid == 2){
        return 0;
    }
    
    return 5;
}

//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    view.backgroundColor = [UIColor clearColor];

    NSMutableDictionary *dic = [_tableDataArray objectAtIndex:section];
    NSString *templateID = [dic objectForKey:@"cTemplateId"];
    int tid = [templateID intValue];
    if(tid == 1 || tid == 2){
        return nil;
    }

    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - more button event

- (void)jumpToSpecficContent{
    NSLog(@"you click the more btn, jumpToSpecficContent");
    
}

#pragma mark - HomePageMenuCell Delegate

- (BOOL)Menu:(HomePageMenuCell *)menu shouldSelectItemAtIndex:(NSInteger)index{
    
    return YES;
}

- (void)Menu:(HomePageMenuCell *)menu didSelectItemAtIndex:(NSInteger)index{
    
    
}


@end
