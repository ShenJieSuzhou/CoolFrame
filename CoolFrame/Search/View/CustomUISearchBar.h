//
//  CustomUISearchBar.h
//  CoolFrame
//
//  Created by shenjie on 2017/8/7.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUISearchBar : UISearchBar<UISearchBarDelegate>

- (void)changeBarTextfieldWithColor:(UIColor *)color bgImageName:(NSString *)bgImageName;
- (void)changeBarCancelButtonWithColor:(UIColor *)textColor bgImageName:(NSString *)bgImageName;

@end
