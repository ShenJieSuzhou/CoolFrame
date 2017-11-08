//
//  AdPageManager.m
//  CoolFrame
//
//  Created by shenjie on 2017/11/8.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "AdPageManager.h"
#import "GlobalDefine.h"
#import <SDWebImage/UIImageView+WebCache.h>

/*
 * 广告显示时间
 */
static int const adShowtime = 5;

@implementation AdPageManager

@synthesize countDownBtn = _countDownBtn;
@synthesize adpageUrl = _adpageUrl;
@synthesize adPageView = _adPageView;
@synthesize countTimer = _countTimer;
@synthesize count = _count;
@synthesize adBlock = _adBlock;

- (id)initWithFrame:(CGRect)frame withAdUrl:(NSString *)url withBlock:(AdFinishBlock)block;{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.广告图片
        _adpageUrl = url;
        _adPageView = [[UIImageView alloc] initWithFrame:frame];
        _adPageView.userInteractionEnabled = YES;
        _adPageView.contentMode = UIViewContentModeScaleAspectFill;
        _adPageView.clipsToBounds = YES;
        [_adPageView setImage:[UIImage imageNamed:url]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_adPageView addGestureRecognizer:tap];
        
        // 2.跳过按钮
        _countDownBtn = [[UIButton alloc] init];
        [_countDownBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countDownBtn setTitle:[NSString stringWithFormat:@"跳过%d", adShowtime] forState:UIControlStateNormal];
        _countDownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countDownBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countDownBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adPageView];
        [self addSubview:_countDownBtn];
        
        self.adBlock = block;
        [self show];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat btnW = 60;
    CGFloat btnH = 30;
    [_countDownBtn setFrame:CGRectMake(ScreenWidth - btnW - 40, 60, btnW, btnH)];
    
}

- (NSTimer *)countTimer{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (void)countDown{
    _count--;
    [_countDownBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count <= 0) {
        [self dismiss];
    }
}

- (void)show{
    if (adShowtime <= 0) {
        return;
    }
    
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)startTimer{
    _count = adShowtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)pushToAd{
    [self dismiss];
    if(self.adBlock){
        self.adBlock();
    }
}

- (void)dismiss{
    [_countTimer invalidate];
    _countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
