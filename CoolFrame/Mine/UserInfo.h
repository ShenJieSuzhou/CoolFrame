//
//  UserInfo.h
//  CoolFrame
//
//  Created by shenjie on 2017/10/17.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CFUserVerifyTypeNone = 0,     ///< 没有认证
    CFUserVerifyTypeStandard,     ///< 个人认证，黄V
    CFUserVerifyTypeOrganization, ///< 官方认证，蓝V
    CFUserVerifyTypeClub,         ///< 达人认证，红星
} CFUserVerifyType;


@interface UserInfo : NSObject

@property (strong, nonatomic) NSString *name;               //用户名
@property (strong, nonatomic) NSString *iconImg;            //头像
@property (strong, nonatomic) NSString *levelName;          //名号
@property (nonatomic, assign) CFUserVerifyType CFType;      //等级icon
@property (nonatomic, strong) NSMutableArray *itemArray;    //可用功能
@property (nonatomic, strong) NSMutableArray *services;     //我的服务

- (void)initWithParams:(NSString *)name
                  icon:(NSString *)iconImg
                 level:(NSString *)levelName
                  type:(CFUserVerifyType)type
                 menus:(NSMutableArray *)itemArray
              services:(NSArray *)services;

@end
