//
//  CustomNaviBarView.m
//  CoolFrame
//
//  Created by silicon on 2017/8/3.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNaviBarView.h"
#import "GlobalDefine.h"

@implementation CustomNaviBarView

@synthesize btnBack = _btnBack;
@synthesize labelTitle = _labelTitle;
@synthesize imgViewBg = _imgViewBg;
@synthesize btnLeft = _btnLeft;
@synthesize btnRight = _btnRight;

+ (CGRect)leftBtnFrame{
    return Rect(10, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGRect)rightBtnFrame{
    return Rect(ScreenWidth - 60.0f, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGSize)barBtnSize{
    return Size(50.0f, 40.0f);
}

+ (CGSize)barSize{
    return Size(ScreenWidth, 64.0f);
}

+ (CGRect)titleViewFrame{
    return Rect(65.0f, 22.0F, ScreenWidth - 130, 40.0f);
}

+ (UIButton *)createNavBarImageBtn:(NSString *)imgStr
                       Highligthed:(NSString *)imgHighStr
                            Target:(id)target
                            Action:(SEL)action{
    
    UIImage *imgNormal = [UIImage imageNamed:imgStr];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:(imgHighStr ? imgHighStr : imgStr)] forState:UIControlStateHighlighted];

    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - imgNormal.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - imgNormal.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    self.btnBack = [[self class] createNavBarImageBtn:@"return_icon" Highligthed:@"return_icon" Target:self Action:@selector(btnBack:)];
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelTitle.backgroundColor = [UIColor clearColor];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    self.imgViewBg = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imgViewBg.image = [[UIImage imageNamed:@"nav_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

    self.labelTitle.frame = [[self class] titleViewFrame];
   
    [self addSubview:self.imgViewBg];
    [self addSubview:self.labelTitle];
    
    [self addSubview:self.btnBack];
}

- (UIImage *)m_background{
    return _imgViewBg.image;
}

- (void)setTitle:(NSString *)titleStr{
    [self.labelTitle setText:titleStr];
}

- (void)setLeftBtn:(UIButton *)btn{
    if(_btnLeft){
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
    }
    
    _btnLeft = btn;
    if(_btnLeft){
        [_btnLeft setFrame:[[self class] leftBtnFrame]];
        [self addSubview:_btnLeft];
    }
}

- (void)setRightBtn:(UIButton *)btn{
    if(_btnRight){
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }
    
    _btnRight = btn;
    if(_btnRight){
        [_btnRight setFrame:[[self class] rightBtnFrame]];
        [self addSubview:_btnRight];
    }
}

- (void)btnBack:(id)sender{
    if(self.m_viewCtrlParent){
        [self.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showCoverView:(UIView *)view
{
    [self showCoverView:view animation:NO];
}

- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation
{
    if (view)
    {
        [self hideOriginalBarItem:YES];
        
        [view removeFromSuperview];
        
        view.alpha = 0.4f;
        [self addSubview:view];
        if (bIsAnimation)
        {
            [UIView animateWithDuration:0.2f animations:^()
             {
                 view.alpha = 1.0f;
             }completion:^(BOOL f){}];
        }
        else
        {
            view.alpha = 1.0f;
        }
    }
}

- (void)showCoverViewOnTitleView:(UIView *)view
{
    if (view)
    {
        if (_labelTitle)
        {
            _labelTitle.hidden = YES;
        }else{}
        
        [view removeFromSuperview];
        view.frame = CGRectMake(_labelTitle.frame.origin.x + 10, _labelTitle.frame.origin.y +4, _labelTitle.frame.size.width - 20, _labelTitle.frame.size.height - 8);
        [self addSubview:view];
    }
}

- (void)hideCoverView:(UIView *)view
{
    [self hideOriginalBarItem:NO];
    if (view && (view.superview == self))
    {
        [view removeFromSuperview];
    }
}

- (void)hideOriginalBarItem:(BOOL)bIsHide
{
    if (_btnLeft)
    {
        _btnLeft.hidden = bIsHide;
    }
    
    if (_btnBack)
    {
        _btnBack.hidden = bIsHide;
    }
    
    if (_btnRight)
    {
        _btnRight.hidden = bIsHide;
    }
    
    if (_labelTitle)
    {
        _labelTitle.hidden = bIsHide;
    }
}


@end
