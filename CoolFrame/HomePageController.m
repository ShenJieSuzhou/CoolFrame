//
//  HomePageController.m
//  CoolFrame
//
//  Created by silicon on 2017/9/9.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HomePageController.h"
#import "JSONKit.h"

@interface HomePageController()

@property (strong, nonatomic) NSMutableArray *mainPageConfigArray;

@property (strong, nonatomic) NSMutableArray *packageArray;

@end

@implementation HomePageController
@synthesize mainPageConfigArray = _mainPageConfigArray;

+ (HomePageController *)getInstance{
    static HomePageController *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HomePageController alloc] init];
    });
    
    return _instance;
}

- (id)init{
    self = [super init];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeData" ofType:@"json"]];
    _mainPageConfigArray = [data objectFromJSONData];
    NSLog(@"%@", _mainPageConfigArray);
    return self;
}

- (NSMutableArray *)getHomePageData{
    return self.mainPageConfigArray;
}

- (NSMutableArray *)mainPageConfigDic{
    if(!_mainPageConfigArray){
        _mainPageConfigArray = [[NSMutableArray alloc] init];
    }
    
    return _mainPageConfigArray;
}

- (NSMutableArray *)getPackageData{

//    PkgRecommend
    return nil;
}
@end
