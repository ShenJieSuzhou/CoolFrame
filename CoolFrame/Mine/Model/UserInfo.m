//
//  UserInfo.m
//  CoolFrame
//
//  Created by shenjie on 2017/10/17.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize name = _name;
@synthesize iconImg = _iconImg;
@synthesize levelName = _levelName;
@synthesize CFType = _CFType;
@synthesize itemArray = _itemArray;
@synthesize services = _services;

- (id)init{
    self = [super init];
    
    return self;
}

- (void)initWithParams:(NSString *)name
                  icon:(NSString *)iconImg
                 level:(NSString *)levelName
                  type:(CFUserVerifyType)type
                 menus:(NSArray *)itemArray
              services:(NSArray *)services{
    
    self.name = name;
    self.iconImg = iconImg;
    self.levelName = levelName;
    self.CFType = type;
    self.itemArray = [[NSMutableArray alloc] initWithArray:itemArray];
    self.services = [[NSMutableArray alloc] initWithArray:services];
}

@end
