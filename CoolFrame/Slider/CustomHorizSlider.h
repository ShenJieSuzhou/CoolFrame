//
//  CustomHorizSlider.h
//  CoolFrame
//
//  Created by silicon on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productPaneView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;

@end


@interface CustomHorizSlider : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *productArray;

@property (strong, nonatomic) UIView *productPane;

@end
