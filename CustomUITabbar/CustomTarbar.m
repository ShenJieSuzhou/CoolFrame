//
//  CustomTarbar.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomTarbar.h"

@implementation CustomTarbar
@synthesize delegate = _delegate;
@synthesize items = _items;
@synthesize selectedItem = _selectedItem;
@synthesize backgroundView = _backgroundView;
@synthesize miniContentHeight = _miniContentHeight;
@synthesize itemWidth = _itemWidth;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
}

- (void)layoutSubviews{
    CGSize framesize = self.frame.size;
    CGFloat height = self.miniContentHeight;
    
    [self.backgroundView setFrame:CGRectMake(0, framesize.height - height, framesize.width, framesize.height)];
    [self setItemWidth:roundf(framesize.width / self.items.count)];
    
    int index = 0;
    
    for (CustomTabBarItem *item in [self items]) {
        CGFloat itemHeight = item.itemHeight;
        if(!itemHeight){
            itemHeight = framesize.height;
        }
        
        [item setFrame:CGRectMake(self.itemWidth * index, framesize.height - height, self.itemWidth, itemHeight)];
        [item setNeedsDisplay];
        
        index++;
    }
}


#pragma mark - meathod
- (void)setItemWidth:(CGFloat)itemWidth{
    if(itemWidth > 0){
        _itemWidth = itemWidth;
    }
}

- (void)setItems:(NSArray *)items{
    _items = items;
    for(CustomTabBarItem *item in items){
        [item addTarget:self action:@selector(tabBarItemWasSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
}

- (CGFloat)miniContentHeight{
    CGFloat minimumConentHeight = CGRectGetHeight(self.frame);
    for (CustomTabBarItem *item in [self items]) {
        CGFloat height = [item itemHeight];
        if(height && height < minimumConentHeight){
            minimumConentHeight = height;
        }
    }

    return minimumConentHeight;
}


#pragma mark -Item selection
- (void)tabBarItemWasSelected:(id)sender{
    if([[self delegate] respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]){
        NSInteger index = [self.items indexOfObject:sender];
        if(![[self delegate] tabBar:self shouldSelectItemAtIndex:index]){
            return;
        }
    }
    
    [self setSelectedItem:sender];
    
    if([[self delegate] respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        NSInteger index = [self.items indexOfObject:self.selectedItem];
        [[self delegate] tabBar:self didSelectItemAtIndex:index];
    }
}

- (void)setSelectedItem:(CustomTabBarItem *)selectedItem{
    if(selectedItem == _selectedItem){
        return;
    }
    
    [_selectedItem setSelected:NO];
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
}

@end
