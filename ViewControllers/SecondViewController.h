//
//  SecondViewController.h
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadUtil.h"

@interface SecondViewController : UIViewController<DownloadDelegate>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *downloadView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *controlBtn;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIProgressView *processView;

@property (nonatomic, strong) UILabel *progressLabel;

@property (assign) BOOL flag;
@end
