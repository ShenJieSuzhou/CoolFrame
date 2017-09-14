//
//  HomePageCell.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/11.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 * 用于主页当中新闻列表显示
 */
@interface HomePageCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *sep;


@end

/*
 * 用于主页当中菜单功能按钮列表显示
 */
@class CustomMenuItem;
@protocol CustomMenuDelegate;
@interface HomePageMenuCell : UITableViewCell
@property (nonatomic, strong) id<CustomMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) CustomMenuItem *selectedItem;
@property (nonatomic) CGFloat itemWidth;
@property (nonatomic) CGFloat miniContentHeight;
@property (nonatomic, strong) UIView *backgroundView;

@end

@protocol CustomMenuDelegate <NSObject>

- (BOOL)Menu:(HomePageMenuCell *)menu shouldSelectItemAtIndex:(NSInteger)index;
- (void)Menu:(HomePageMenuCell *)menu didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * 用于主页当中产品推广显示
 */
@interface HomePageProducts : UIView

@end

/*
 * 自定义菜单按钮
 */
@interface CustomMenuItem : UIControl

@property (nonatomic) CGFloat itemHeight;

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

@end
