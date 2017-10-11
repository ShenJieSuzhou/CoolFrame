//
//  AppDelegate.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "AppDelegate.h"

#import "CustomNavigationController.h"
#import "CustomNavBar.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"

#define NQFONT(v) [UIFont fontWithName:@"HiraKakuProN-W3" size:v]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
@interface AppDelegate ()

@property (nonatomic, strong) FirstViewController *firstViewController;
@property (nonatomic, strong) SecondViewController *secondViewController;
@property (nonatomic, strong) ThirdViewController *thirdViewController;
@property (nonatomic, strong) FouthViewController *fouthViewController;
@property (nonatomic, strong) CustomTabBarController *tabBarController;

@property (nonatomic, strong) CustomNavigationController *navController;

@end


@implementation AppDelegate

- (void)setupViewControllers{
    if(!self.firstViewController){
        self.firstViewController = [[FirstViewController alloc] init];
    }
    
    if(!self.secondViewController){
        self.secondViewController = [[SecondViewController alloc] init];
    }
    
    if(!self.thirdViewController){
        self.thirdViewController = [[ThirdViewController alloc] init];
    }
    
    if(!self.fouthViewController){
        self.fouthViewController = [[FouthViewController alloc] init];
    }
    
    self.tabBarController = [[CustomTabBarController alloc] init];
    NSMutableArray *viewsArray = [[NSMutableArray alloc] initWithObjects:self.firstViewController,
                                  self.secondViewController,
                                  self.thirdViewController,
                                  self.fouthViewController, nil];
    
    [self.tabBarController setViewControllers:viewsArray];
    self.tabBarController.delegate = self;
    [self customizeTabBarForController:_tabBarController];
    
    if(!_navController){
//        _navController  = [[CustomNavigationController new] initWithNavigationBarClass:[CustomNavBar class] toolbarClass:[UIToolbar class]];
//        [_navController pushViewController:_tabBarController animated:NO];
        
        
        _navController = [[CustomNavigationController alloc] initWithRootViewController:_tabBarController];
    }
}

- (void)customizeTabBarForController:(CustomTabBarController *)tabBarController{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_back_selected"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_back_normal"];
    NSArray *tabBarItemImages = @[@"latest",@"rank", @"contest", @"me"];
    NSArray *tabBarItemTitles = @[NSLocalizedString(@"微信", nil),NSLocalizedString(@"通信录", nil),NSLocalizedString(@"发现", nil), NSLocalizedString(@"我", nil)];
    NSInteger index = 0;
    for (CustomTabBarItem *item in [[tabBarController customTarbar] items])
    {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];

        item.unselectedTitleAttributes= @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(255, 255, 255),};
        
        item.selectedTitleAttributes = @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(255, 255, 255),};

        index++;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    [self setupViewControllers];
    
    [self.window setRootViewController:_navController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
