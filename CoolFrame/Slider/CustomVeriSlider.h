//
//  CustomVeriSlider.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewsPaneView : UIView

@property (strong, nonatomic) UIView *newsView;
@property (strong, nonatomic) UILabel *newsText;

@end

@interface CustomVeriSlider : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *productArray;

@end
