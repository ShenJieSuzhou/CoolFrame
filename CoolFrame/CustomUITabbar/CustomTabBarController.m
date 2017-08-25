//
//  CustomTabBarController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomTabBarController.h"
#import <objc/runtime.h>

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController
@synthesize delegate = _delegate;
@synthesize viewControllers = _viewControllers;
@synthesize selectIndex = _selectIndex;
@synthesize contentView = _contentView;
@synthesize customTarbar = _customTarbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"CoolFrame";
    [self.view addSubview:[self contentView]];
    [self.view addSubview:[self customTarbar]];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setSelectIndex:0];
    [[self customTarbar] setSelectedItem:[[self.customTarbar items] objectAtIndex:0]];
    [self setTabBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -meathod

- (void)setViewControllers:(NSMutableArray *)viewControllers{
    if(viewControllers && [viewControllers isKindOfClass:[NSMutableArray class]]){
        _viewControllers = viewControllers;
        
        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        
        for (UIViewController *viewController in viewControllers) {
            CustomTabBarItem *tabBarItem = [[CustomTabBarItem alloc] init];
            [tabBarItem setTitle:viewController.title];
            [tabBarItems addObject:tabBarItem];
        }
        
        [[self customTarbar] setItems:tabBarItems];
    }
}

- (UIViewController *)selectedViewController{
    return [self.viewControllers objectAtIndex:self.selectIndex];
}

- (void)setSelectIndex:(NSUInteger)selectIndex{
    if(selectIndex > [self.viewControllers count]){
        return;
    }
    
    _selectIndex = selectIndex;
    if(_selectedViewController){
        [_selectedViewController willMoveToParentViewController:nil];
        [_selectedViewController.view removeFromSuperview];
        [_selectedViewController removeFromParentViewController];
    }
    
    [self setSelectedViewController:[self.viewControllers objectAtIndex:_selectIndex]];
    [self addChildViewController:self.selectedViewController];
    [[self selectedViewController].view setFrame:self.contentView.bounds];
    [self.contentView addSubview:self.selectedViewController.view];
    [self.selectedViewController didMoveToParentViewController:self];
}


- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    
    return _contentView;
}

- (CustomTarbar *)customTarbar{
    if(!_customTarbar){
        _customTarbar = [[CustomTarbar alloc] init];
        [_customTarbar setBackgroundColor:[UIColor clearColor]];
        [_customTarbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        _customTarbar.delegate = self;
    }
    
    return _customTarbar;
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated{
    
    _tabbarHidden = hidden;
    CGSize viewSize = self.view.frame.size;
    CGFloat tabBarHeight = 49.0f;
    CGFloat tabBarY = viewSize.height;
    
    if(!hidden){
        tabBarY = viewSize.height - tabBarHeight;
        [[self customTarbar] setFrame:CGRectMake(0, tabBarY, viewSize.width, tabBarHeight)];
        [[self contentView] setFrame:CGRectMake(0, 0, viewSize.width, viewSize.height - tabBarHeight)];
    }
    
}

- (void)setTabbarHidden:(BOOL)tabbarHidden{
    [self setTabBarHidden:tabbarHidden animated:NO];
}

#pragma -CustomTabbarDelegate

- (BOOL)tabBar:(CustomTarbar *)tabBar shouldSelectItemAtIndex:(NSInteger)index{
    if (index > [self viewControllers].count) {
        return NO;
    }
    
    if([[self delegate] respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]){
        if(![[self delegate] tabBarController:self shouldSelectViewController:[self viewControllers][index]]){
            return NO;
        }
    }
    
    if([self selectedViewController] == [self viewControllers][index]){
        if([[self selectedViewController] isKindOfClass:[UINavigationController class]]){
            UINavigationController *selectController = (UINavigationController *)[self selectedViewController];
            
            if([selectController topViewController] != [selectController viewControllers][0]){
                [selectController popToRootViewControllerAnimated:YES];
                return NO;
            }
        }
    
        return NO;
    }
    
    return YES;
}

- (void)tabBar:(CustomTarbar *)tabBar didSelectItemAtIndex:(NSInteger)index{
    if(index < 0 || index >= [self viewControllers].count){
        return;
    }
    
    [self setSelectIndex:index];
}


@end
