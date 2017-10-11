//
//  CustomUISearchBar.m
//  CoolFrame
//
//  Created by shenjie on 2017/8/7.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomUISearchBar.h"
#define kBgTextFieldImageName @"search_bar_bg"
@implementation CustomUISearchBar

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){

    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
    }
    return self;
}

- (void)changeBarTextfieldWithColor:(UIColor *)color bgImageName:(NSString *)bgImageName{
    self.tintColor = color;
    
    UITextField *textField;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.1f)
    {
        for (UIView *subv in self.subviews)
        {
            for (UIView* view in subv.subviews)
            {
                if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")])
                {
                    textField = (UITextField*)view;
                    break;
                }
            }
        }
    }
    
    textField.textColor = [UIColor whiteColor];
}

- (void)changeBarCancelButtonWithColor:(UIColor *)textColor bgImageName:(NSString *)bgImageName{
    
}

@end
