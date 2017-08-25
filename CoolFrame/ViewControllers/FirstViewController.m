//
//  FirstViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "FirstViewController.h"
#import "SearchViewController.h"



@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize label = _label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"A";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[self label] setFrame:CGRectMake(roundf(self.view.frame.size.width - 100)/2, roundf(self.view.frame.size.height - 100)/2, 100, 100)];
    
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:40.0f]];
    [self.label setText:@"A"];
    
    [self.view addSubview:[self label]];
    
    
    [self setNaviBarTitle:@"CoolFrame"];
    [self setNaviBarLeftBtn:nil];
    //设置搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(OnSearchBtnClick:) forControlEvents:UIControlEventTouchDragInside];
    [self setNaviBarRightBtn:searchBtn];
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

@end
