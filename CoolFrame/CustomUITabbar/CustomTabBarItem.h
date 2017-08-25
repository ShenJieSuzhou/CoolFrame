//
//  CustomTabBarItem.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarItem : UIControl

@property (nonatomic) CGFloat itemHeight;

#pragma mark - Title configuration
@property (nonatomic, strong) NSString *title;
@property (nonatomic) UIOffset titlePositionAdjustment;
@property (nonatomic, strong) NSDictionary *unselectedTitleAttributes;
@property (nonatomic, strong) NSDictionary *selectedTitleAttributes;

#pragma mark - Image configuration
@property (nonatomic) UIOffset imagePositionAdjustment;
@property (nonatomic, strong) UIImage *unselectedImage;
@property (nonatomic, strong) UIImage *selectedImage;

- (UIImage *)finishedSelectedImage;
- (UIImage *)finishedUnselectedImage;
- (void)setFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage;


#pragma mark - Background configuration

- (UIImage *)backgroundSelectedImage;
- (UIImage *)backgroundUnselectedImage;
- (void)setBackgroundSelectedImage:(UIImage *)selectedImage withUnselectedImage:(UIImage *)unselectedImage;
@property (nonatomic, strong) UIImage *unselectedBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;

#pragma mark - Badge configuration
@property (nonatomic, strong) NSString *badgeValue;
@property (nonatomic, strong) UIImage *badgeBackgroundImage;
@property (nonatomic, strong) UIColor *badgeBackgroundColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic) UIOffset badgePositionAdjustment;
@property (nonatomic) UIFont *badgeTextFont;

@end
