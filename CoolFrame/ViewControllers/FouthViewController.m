//
//  FouthViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "FouthViewController.h"
#import "HeadCollectionViewFlowLayout.h"
#import "HeadCollectionViewCell.h"
#import "ProfileCollectionViewCell.h"
#import "GlobalDefine.h"
#import <MJRefresh/MJRefresh.h>

@interface FouthViewController ()

@end

@implementation FouthViewController
@synthesize mineCollection = _mineCollection;
@synthesize itemArray = _itemArray;
@synthesize userInfo = _userInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
        
    //头部刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dataRefreshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = NO;
    self.mineCollection.mj_header = header;
    
    [self.view addSubview:[self mineCollection]];
    //开始第一次数据拉取
    [self.mineCollection.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    /*
     * 初始化 用户信息
     */
    NSDictionary *realname = @{@"titleText":@"实名认证",@"title_icon":@"realname.png"};
    NSDictionary *task = @{@"titleText":@"我的任务",@"title_icon":@"task.png"};
    NSDictionary *gift = @{@"titleText":@"我的礼包",@"title_icon":@"gift.png"};
    NSDictionary *reservation = @{@"titleText":@"我的预约",@"title_icon":@"reservation.png"};
    NSDictionary *order = @{@"titleText":@"我的订单",@"title_icon":@"order.png"};
    NSDictionary *address = @{@"titleText":@"收货地址",@"title_icon":@"address.png"};
    
    NSArray *items = @[realname, task, gift, reservation, order, address];
    
    NSDictionary *question = @{@"titleText":@"我的问答",@"title_icon":@"question.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *releation = @{@"titleText":@"我的圈子",@"title_icon":@"releations.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *share = @{@"titleText":@"我的分享",@"title_icon":@"share.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *sign = @{@"titleText":@"我的打卡",@"title_icon":@"sign.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *dazhong = @{@"titleText":@"大众评审",@"title_icon":@"dazhong.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *taobizhong = @{@"titleText":@"淘必中",@"title_icon":@"taobizhong.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *xiaomi = @{@"titleText":@"我的小蜜",@"title_icon":@"xiaomi.png",@"arrow_icon":@"arrow_icon"};
    
    NSArray *services = @[question, releation, share, sign, dazhong, taobizhong, xiaomi];
    _userInfo = [UserInfo new];
    [_userInfo initWithParams:@"金属小子" icon:@"pugongy.png" level:@"钻石用户" type:CFUserVerifyTypeStandard menus:items services:services];
}

/**
 * UICollectionView 懒加载
 */
- (UICollectionView *)mineCollection{
    if(!_mineCollection){
        _mineCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:[[HeadCollectionViewFlowLayout alloc] init]];
        _mineCollection.alwaysBounceVertical = YES;
        _mineCollection.backgroundColor = [UIColor clearColor];
        // 注册cell
        [_mineCollection registerClass:[ProfileCollectionViewCell class] forCellWithReuseIdentifier:@"ProfileCollectionViewCell"];
        [_mineCollection registerClass:[HeadCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionViewCell"];
        
        _mineCollection.delegate = self;
        _mineCollection.dataSource = self;
    }

    return _mineCollection;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 350); // 设置headerView的宽高
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_userInfo.services count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *dic = [_userInfo.services objectAtIndex:indexPath.row];
    NSString *iconName = [dic objectForKey:@"title_icon"];
    NSString *tlabel = [dic objectForKey:@"titleText"];
    
    [cell.textlabel setText:tlabel];
    [cell.iconView setImage:[UIImage imageNamed:iconName]];
    [cell.sep setBackgroundColor:RGB(220, 220, 220)];
    [cell.arrow setImage:[UIImage imageNamed:@"arrow_icon"]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HeadCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionViewCell" forIndexPath:indexPath];
    
    [cell.persionInfoV.imgIcon setImage:[UIImage imageNamed:_userInfo.iconImg]];
    
    if(_userInfo.CFType == CFUserVerifyTypeNone){
        [cell.persionInfoV.levelIcon setImage:[UIImage imageNamed:@"avatar_grassroot.png"]];
    }else if(_userInfo.CFType == CFUserVerifyTypeStandard){
        [cell.persionInfoV.levelIcon setImage:[UIImage imageNamed:@"avatar_enterprise_vip.png"]];
    }else if(_userInfo.CFType == CFUserVerifyTypeOrganization){
        [cell.persionInfoV.levelIcon setImage:[UIImage imageNamed:@"avatar_vip.png"]];
    }else if(_userInfo.CFType == CFUserVerifyTypeClub){
        [cell.persionInfoV.levelIcon setImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    }
    
    [cell.persionInfoV.name setText:_userInfo.name];
    [cell.persionInfoV.level setText:_userInfo.levelName];
    
    [cell setItemArray:_userInfo.itemArray];
    
    return cell;
}

//————— 下拉刷新 —————
-(void)dataRefreshing{
    NSLog(@"开始刷新数据");
    [self.mineCollection.mj_header endRefreshing];
}

@end
