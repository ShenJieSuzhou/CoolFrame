//
//  CustomTabBarItem.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomTabBarItem.h"
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
@implementation CustomTabBarItem

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitialization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitialization{
    [self setBackgroundColor:[UIColor clearColor]];
    
    _title = @"";
    _titlePositionAdjustment = UIOffsetZero;
    _unselectedTitleAttributes = @{
                                   NSFontAttributeName: [UIFont systemFontOfSize:10],
                                   NSForegroundColorAttributeName: RGB(0, 0, 0)
                                   };
    _selectedTitleAttributes = [_unselectedTitleAttributes copy];
    _badgeBackgroundColor = [UIColor redColor];
    _badgeTextColor = [UIColor whiteColor];
    _badgeTextFont = [UIFont systemFontOfSize:12];
    _badgePositionAdjustment = UIOffsetZero;
}

- (void)drawRect:(CGRect)rect{
    CGSize frameSize = self.frame.size;
    CGSize titleSize = CGSizeZero;
    CGSize imageSize = CGSizeZero;
    NSDictionary *titleAttribute = nil;
    UIImage *backgroundimage = nil;
    UIImage *image = nil;
    CGFloat imageStartingY = 0.0f;
    
    if([self isSelected]){
        image = [self selectedImage];
        backgroundimage = [self selectedBackgroundImage];
        titleAttribute = [self selectedTitleAttributes];
        
        if(!titleAttribute){
            titleAttribute = [self unselectedTitleAttributes];
        }
    }else{
        image = [self unselectedImage];
        backgroundimage = [self unselectedBackgroundImage];
        titleAttribute = [self unselectedTitleAttributes];
    }
    
    imageSize = [image size];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [backgroundimage drawInRect:self.bounds];
    
    if(!_title){
        [image drawInRect:CGRectMake(roundf(frameSize.width / 2 - imageSize.width / 2) +
                                     _imagePositionAdjustment.horizontal,
                                     roundf(frameSize.height / 2 - imageSize.height / 2) +
                                     _imagePositionAdjustment.vertical,
                                     imageSize.width, imageSize.height)];
    }else{
        titleSize = [_title boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName: titleAttribute[NSFontAttributeName]}
                                         context:nil].size;
        
        imageStartingY = roundf((frameSize.height - imageSize.height - titleSize.height) / 2);
        
        [image drawInRect:CGRectMake(roundf(frameSize.width / 2 - imageSize.width / 2) +
                                     _imagePositionAdjustment.horizontal,
                                     imageStartingY + _imagePositionAdjustment.vertical,
                                     imageSize.width, imageSize.height)];
        
        CGContextSetFillColorWithColor(context, [titleAttribute[NSForegroundColorAttributeName] CGColor]);
        
        [_title drawInRect:CGRectMake(roundf(frameSize.width / 2 - titleSize.width / 2) +
                                      _titlePositionAdjustment.horizontal,
                                      imageStartingY + imageSize.height + _titlePositionAdjustment.vertical,
                                      titleSize.width, titleSize.height)
            withAttributes:titleAttribute];
    }
    
    if([[self badgeValue] length]){
        CGSize badgeSize = CGSizeZero;
        badgeSize = [_badgeValue boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: [self badgeTextFont]}
                                              context:nil].size;
        
        CGFloat textOffset = 2.0f;
        
        if(badgeSize.width < badgeSize.height){
            badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
        }
        
        CGRect badgeBackgroundFrame = CGRectMake(roundf(frameSize.width / 2 + (image.size.width / 2) * 0.9) +
                                                 [self badgePositionAdjustment].horizontal,
                                                 textOffset + [self badgePositionAdjustment].vertical,
                                                 badgeSize.width + 2 * textOffset, badgeSize.height + 2 * textOffset);
        
        if ([self badgeBackgroundColor]) {
            CGContextSetFillColorWithColor(context, [[self badgeBackgroundColor] CGColor]);
            
            CGContextFillEllipseInRect(context, badgeBackgroundFrame);
        } else if ([self badgeBackgroundImage]) {
            [[self badgeBackgroundImage] drawInRect:badgeBackgroundFrame];
        }
        
        CGContextSetFillColorWithColor(context, [[self badgeTextColor] CGColor]);
        
        NSMutableParagraphStyle *badgeTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [badgeTextStyle setLineBreakMode:NSLineBreakByWordWrapping];
        [badgeTextStyle setAlignment:NSTextAlignmentCenter];
        
        NSDictionary *badgeTextAttributes = @{
                                              NSFontAttributeName: [self badgeTextFont],
                                              NSForegroundColorAttributeName: [self badgeTextColor],
                                              NSParagraphStyleAttributeName: badgeTextStyle,
                                              };
        
        [[self badgeValue] drawInRect:CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + textOffset,
                                                 CGRectGetMinY(badgeBackgroundFrame) + textOffset,
                                                 badgeSize.width, badgeSize.height)
                       withAttributes:badgeTextAttributes];
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Image configuration

- (UIImage *)finishedSelectedImage{
    return [self selectedImage];
}

- (UIImage *)finishedUnselectedImage{
    return [self unselectedImage];
}

- (void)setFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage{
    if(selectedImage && selectedImage != [self selectedImage]){
        [self setSelectedImage:selectedImage];
    }

    if(unselectedImage && unselectedImage != [self unselectedImage]){
        [self setUnselectedImage:unselectedImage];
    }
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

#pragma mark - Background configuration

- (UIImage *)backgroundSelectedImage{
    return [self backgroundSelectedImage];
}

- (UIImage *)backgroundUnselectedImage{
    return [self backgroundUnselectedImage];
}

- (void)setBackgroundSelectedImage:(UIImage *)selectedImage withUnselectedImage:(UIImage *)unselectedImage{
    if(selectedImage && selectedImage != [self selectedBackgroundImage]){
        [self setSelectedBackgroundImage:selectedImage];
    }
    
    if(unselectedImage && unselectedImage != [self unselectedBackgroundImage]){
        [self setUnselectedBackgroundImage:unselectedImage];
    }
}

@end
