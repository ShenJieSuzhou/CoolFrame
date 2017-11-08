//
//  AdPageManager.h
//  CoolFrame
//
//  Created by shenjie on 2017/11/8.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdFinishBlock)();

@interface AdPageManager : UIView

/*
 * 倒计时按钮
 */
@property (strong, nonatomic) UIButton *countDownBtn;

/*
 * 广告地址
 */
@property (strong, nonatomic) NSString *adpageUrl;

/*
 * 背景
 */
@property (strong, nonatomic) UIImageView *adPageView;

/*
 * 倒计时计时器
 */
@property (nonatomic, strong) NSTimer *countTimer;

/*
 * 计数
 */
@property (nonatomic, assign) int count;

/*
 * block回调
 */
@property (strong, nonatomic) AdFinishBlock adBlock;

- (id)initWithFrame:(CGRect)frame withAdUrl:(NSString *)url withBlock:(AdFinishBlock)block;


@end
