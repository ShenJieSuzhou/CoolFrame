//
//  CustomViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/8/3.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomViewController.h"
#import "GlobalDefine.h"
@interface CustomViewController ()

@end

@implementation CustomViewController

@synthesize customNavbar = _customNavbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _customNavbar = [[CustomNaviBarView alloc] initWithFrame:Rect(0, 0, [CustomNaviBarView barSize].width, [CustomNaviBarView barSize].height)];
    _customNavbar.m_viewCtrlParent = self;
    
    [self.view addSubview:_customNavbar];
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_customNavbar && !_customNavbar.hidden){
        [self.view bringSubviewToFront:self.customNavbar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bringNaviBarToTopmost
{
    if (_customNavbar)
    {
        [self.view bringSubviewToFront:_customNavbar];
    }
}

- (void)setNaviBarTitle:(NSString *)strTitle{
    if(_customNavbar){
        [_customNavbar setTitle:strTitle];
    }
}

- (void)setNaviBarLeftBtn:(UIButton *)leftBtn{
    if(_customNavbar){
        [_customNavbar setLeftBtn:leftBtn];
    }
}

- (void)setNaviBarRightBtn:(UIButton *)rightBtn{
    if(_customNavbar){
        [_customNavbar setRightBtn:rightBtn];
    }
}

- (void)naviBarAddCoverView:(UIView *)view{
    if(_customNavbar && view){
        [_customNavbar showCoverView:view animation:YES];
    }
}

- (void)naviBarAddCoverViewOnTitleView:(UIView *)view{
    if(_customNavbar && view){
        [_customNavbar showCoverViewOnTitleView:view];
    }
}

- (void)naviBarRemoveCoverView:(UIView *)view{
    if(_customNavbar){
        [_customNavbar hideCoverView:view];
    }
}

- (void)setNavigationCanDragBack:(BOOL)bCanDragBack{

    
}

@end
