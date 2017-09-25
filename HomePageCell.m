//
//  HomePageCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/11.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//
#define NQFONT(v) [UIFont fontWithName:@"HiraKakuProN-W3" size:v]

#import "HomePageCell.h"
#import "GlobalDefine.h"
@implementation HomePageCell
@synthesize textLabel = _textLabel;
@synthesize imgView = _imgView;
@synthesize sep = _sep;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        self.textLabel = [[UILabel alloc] init];
        [self.textLabel setTextColor:[UIColor blackColor]];
        [self.textLabel setFont:[UIFont systemFontOfSize:17]];
        [self.contentView addSubview:self.textLabel];
        
        self.imgView = [[UIImageView alloc] init];
        [self.imgView setBackgroundColor:[UIColor clearColor]];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        self.imgView.clipsToBounds = YES;
        [self.contentView addSubview:self.imgView];
        
        self.sep = [[UIImageView alloc] init];
        [self.sep setBackgroundColor:RGB(220, 220, 220)];
        [self.sep setContentMode:UIViewContentModeBottom];
        self.sep.clipsToBounds = YES;
        [self.contentView addSubview:self.sep];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //两边边距 20 个像素
    CGFloat margin = 20.0f;
    
    CGRect rcCell = [self bounds];
    [self.textLabel sizeToFit];
    self.textLabel.numberOfLines = 0;
    CGRect rcName = self.textLabel.frame;
    rcName.origin.x = margin;
    rcName.origin.y = 0;
    rcName.size.height = 80;
    rcName.size.width = (rcCell.size.width - 3*margin)/3*2;
    self.textLabel.frame = rcName;
    
    CGRect rcImg= CGRectMake(rcName.size.width + 2*margin, 15 , (rcCell.size.width - 3*margin)/3, 80);
    self.imgView.frame = rcImg;
    
    CGRect rcSep = CGRectMake(0, 1 , rcCell.size.width, 1);
    self.sep.frame = rcSep;
}

@end


@implementation HomePageProducts

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
       
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    
}

@end


@implementation HomePageCubeCell
@synthesize collectionView = _collectionView;
@synthesize flowLayout = _flowLayout;
@synthesize itemArray = _itemArray;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _itemArray = [[NSMutableArray alloc] init];
        
        //初始化布局
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_flowLayout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册cell 这一步必须要实现
        [_collectionView registerClass:[CustomMenuItem class] forCellWithReuseIdentifier:@"CustomMenuItem"];
        
        [self addSubview:_collectionView];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomMenuItem" forIndexPath:indexPath];
    
//    CustomMenuItem *item = (CustomMenuItem *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomMenuItem" forIndexPath:indexPath];
//
//    UIImage *finishedImage = [UIImage imageNamed:@"menu"];
//    UIImage *unfinishedImage = [UIImage imageNamed:@"menu"];
//
//    //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
//    [item setFinishedSelectedImage:finishedImage withFinishedUnselectedImage:unfinishedImage];
//
//    item.unselectedTitleAttributes= @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(0, 0, 0),};
//    item.selectedTitleAttributes = @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(0, 0, 0),};
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(0, 0);
}

/*
 * 上左下右间距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/*
 *  item space
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

/*
 * 行距 0
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

@end


@implementation HomePageMenuCell

@synthesize delegate = _delegate;
@synthesize items = _items;
@synthesize selectedItem = _selectedItem;
@synthesize miniContentHeight = _miniContentHeight;
@synthesize itemWidth = _itemWidth;
@synthesize backgroundView = _backgroundView;

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
    [self setBackgroundColor:[UIColor whiteColor]];
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
}

- (void)layoutSubviews{
    CGSize framesize = self.frame.size;
    CGFloat height = self.miniContentHeight;
    
    [self.backgroundView setFrame:CGRectMake(0, 0, framesize.width, framesize.height)];
    [self setItemWidth:roundf(framesize.width / self.items.count)];
    
    int index = 0;
    
    for (CustomMenuItem *item in [self items]) {
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
    for(CustomMenuItem *item in items){
        [item addTarget:self action:@selector(menuItemWasSelected:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *finishedImage = [UIImage imageNamed:@"menu"];
        UIImage *unfinishedImage = [UIImage imageNamed:@"menu"];
        
//        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        [item setFinishedSelectedImage:finishedImage withFinishedUnselectedImage:unfinishedImage];
        
        item.unselectedTitleAttributes= @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(0, 0, 0),};
        item.selectedTitleAttributes = @{NSFontAttributeName: NQFONT(10), NSForegroundColorAttributeName: RGB(0, 0, 0),};

        [self addSubview:item];
    }
}

- (CGFloat)miniContentHeight{
    CGFloat minimumConentHeight = CGRectGetHeight(self.frame);
    for (CustomMenuItem *item in [self items]) {
        CGFloat height = [item itemHeight];
        if(height && height < minimumConentHeight){
            minimumConentHeight = height;
        }
    }
    
    return minimumConentHeight;
}


#pragma mark -Item selection
- (void)menuItemWasSelected:(id)sender{
    if([[self delegate] respondsToSelector:@selector(Menu:shouldSelectItemAtIndex:)]){
        NSInteger index = [self.items indexOfObject:sender];
        if(![[self delegate] Menu:self shouldSelectItemAtIndex:index]){
            return;
        }
    }
    
    [self setSelectedItem:sender];
    
    if([[self delegate] respondsToSelector:@selector(Menu:didSelectItemAtIndex:)]){
        NSInteger index = [self.items indexOfObject:self.selectedItem];
        [[self delegate] Menu:self didSelectItemAtIndex:index];
    }
}

- (void)setSelectedItem:(CustomMenuItem *)selectedItem{
    if(selectedItem == _selectedItem){
        return;
    }
    
    [_selectedItem setSelected:NO];
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
}

@end


@implementation CustomMenuItem

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
                                   NSForegroundColorAttributeName: RGB(255, 255, 255)
                                   };
    _selectedTitleAttributes = [_unselectedTitleAttributes copy];
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
                                      imageStartingY + imageSize.height + _titlePositionAdjustment.vertical + 5,
                                      titleSize.width, titleSize.height)
            withAttributes:titleAttribute];
    }
    
//    if([[self badgeValue] length]){
//        CGSize badgeSize = CGSizeZero;
//        badgeSize = [_badgeValue boundingRectWithSize:CGSizeMake(frameSize.width, 20)
//                                              options:NSStringDrawingUsesLineFragmentOrigin
//                                           attributes:@{NSFontAttributeName: [self badgeTextFont]}
//                                              context:nil].size;
//
//        CGFloat textOffset = 2.0f;
//
//        if(badgeSize.width < badgeSize.height){
//            badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
//        }
//
//        CGRect badgeBackgroundFrame = CGRectMake(roundf(frameSize.width / 2 + (image.size.width / 2) * 0.9) +
//                                                 [self badgePositionAdjustment].horizontal,
//                                                 textOffset + [self badgePositionAdjustment].vertical,
//                                                 badgeSize.width + 2 * textOffset, badgeSize.height + 2 * textOffset);
//
//        if ([self badgeBackgroundColor]) {
//            CGContextSetFillColorWithColor(context, [[self badgeBackgroundColor] CGColor]);
//
//            CGContextFillEllipseInRect(context, badgeBackgroundFrame);
//        } else if ([self badgeBackgroundImage]) {
//            [[self badgeBackgroundImage] drawInRect:badgeBackgroundFrame];
//        }
//
//        CGContextSetFillColorWithColor(context, [[self badgeTextColor] CGColor]);
//
//        NSMutableParagraphStyle *badgeTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//        [badgeTextStyle setLineBreakMode:NSLineBreakByWordWrapping];
//        [badgeTextStyle setAlignment:NSTextAlignmentCenter];
//
//        NSDictionary *badgeTextAttributes = @{
//                                              NSFontAttributeName: [self badgeTextFont],
//                                              NSForegroundColorAttributeName: [self badgeTextColor],
//                                              NSParagraphStyleAttributeName: badgeTextStyle,
//                                              };
//
//        [[self badgeValue] drawInRect:CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + textOffset,
//                                                 CGRectGetMinY(badgeBackgroundFrame) + textOffset,
//                                                 badgeSize.width, badgeSize.height)
//                       withAttributes:badgeTextAttributes];
//    }
    
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

//- (void)setBadgeValue:(NSString *)badgeValue{
//    _badgeValue = badgeValue;
//    [self setNeedsDisplay];
//}

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

