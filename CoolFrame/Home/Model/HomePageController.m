//
//  HomePageController.m
//  CoolFrame
//
//  Created by silicon on 2017/9/9.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "HomePageController.h"
#import "JSONKit.h"
#import <AFNetworking/AFHTTPSessionManager.h>

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
    
    //初始化 manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //POST 请求
    NSString *url = @"http://172.19.28.27:8080/topic/api";
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功，解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];

        NSLog(@"%@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
    }];
    
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
