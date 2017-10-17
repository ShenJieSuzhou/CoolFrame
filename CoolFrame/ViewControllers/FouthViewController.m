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
    
    [self.view addSubview:[self mineCollection]];
}

- (void)viewWillAppear:(BOOL)animated{
    /*
     * 初始化 用户信息
     */
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:@"realname.png",
                             @"task.png",
                             @"gift.png",
                             @"reservation.png",
                             @"order.png",
                             @"address.png", nil];
    
    NSDictionary *question = @{@"titleText":@"我的问答",@"title_icon":@"question.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *releation = @{@"titleText":@"我的圈子",@"title_icon":@"releations.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *share = @{@"titleText":@"我的评价",@"title_icon":@"share.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *sign = @{@"titleText":@"我的等分享",@"title_icon":@"sign.png",@"arrow_icon":@"arrow_icon"};
    NSDictionary *dazhong = @{@"titleText":@"大招评审",@"title_icon":@"dazhong.png",@"arrow_icon":@"arrow_icon"};
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
        _mineCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 40) collectionViewLayout:[[HeadCollectionViewFlowLayout alloc] init]];
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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 260); // 设置headerView的宽高
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *dic = [_userInfo.services objectAtIndex:indexPath.row];
    NSString *iconName = [dic objectForKey:@"icon"];
    NSString *tlabel = [dic objectForKey:@"cellname"];
    
    [cell.textlabel setText:tlabel];
    [cell.iconView setImage:[UIImage imageNamed:iconName]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HeadCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0); //设置collectionView的cell上、左、下、右的间距
}
@end
