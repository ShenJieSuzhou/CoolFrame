//
//  CustomNavigationController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/27.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 使导航条有效
    [self setNavigationBarHidden:NO];
    // 隐藏导航条，但由于导航条有效，系统的返回按钮页有效，所以可以使用系统的右滑返回手势。
    [self.navigationBar setHidden:YES];
    
    self.delegate = self;
}


- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


#pragma mark - delegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

}

@end
