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
#import "HomePageCell.h"


@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize label = _label;
@synthesize tableDataArray = _tableDataArray;
@synthesize homeTableView = _homeTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"A";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [[self label] setFrame:CGRectMake(roundf(self.view.frame.size.width - 100)/2, roundf(self.view.frame.size.height - 100)/2, 100, 100)];
//
//    [self.label setTextAlignment:NSTextAlignmentCenter];
//    [self.label setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:40.0f]];
//    [self.label setText:@"A"];
//
//    [self.view addSubview:[self label]];
    
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
    
    self.homeTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.homeTableView setBackgroundColor:[UIColor clearColor]];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self.view addSubview:self.homeTableView];
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
    
    switch ([templateID intValue]) {
        case 1:
        case 3:
        case 6:return 1;    //模板显示一行
            break;
        case 2:
        case 4:return 2;    //模板显示二行
            break;
        case 5:return 5;    //模板显示五行
            break;
        default:return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HomePageCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell"];
//
//    if(!homeCell){
//        homeCell = [[HomePageCell alloc] initWithFrame:<#(CGRect)#>]
//    }
//    return nil;
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableDataArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
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
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
