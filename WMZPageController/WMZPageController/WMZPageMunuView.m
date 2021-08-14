//
//  WMZPageMunuView.m
//  WMZPageController
//
//  Created by wmz on 2020/10/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageMunuView.h"

@implementation WMZPageMunuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.bounces = NO;
        self.currentTitleIndex = NSNotFound;
        self.bouncesZoom = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)setParam:(WMZPageParam *)param{
    _param = param;
    [self UI];
}

/// UI
- (void)UI{
    self.btnArr = [NSMutableArray new];
    WMZPageNaviBtn *temp = nil;
    for (int i = 0; i<self.param.wTitleArr.count; i++) {
        WMZPageNaviBtn *btn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
        [self setPropertiesWithBtn:btn withIndex:i withTemp:temp];
        temp = btn;
        if (i == self.param.wTitleArr.count - 1) {
            [self resetMainViewContenSize:btn];
        }
    }
    if (self.param.wCustomMenuView) self.param.wCustomMenuView(self);
    /// 指示器
    [self setUpIndicator];
    /// 右边固定标题
    [self setUpFixRightBtn:temp];
    /// 最底部固定线
    if (self.param.wInsertMenuLine) {
        self.bottomView = [UIView new];
        self.bottomView.backgroundColor = PageColor(0x999999);
        self.bottomView.frame = CGRectMake(0, self.frame.size.height - PageK1px, self.frame.size.width, PageK1px);
    }
    if (self.bottomView) {
        CGRect lineRect = self.bottomView.frame;
        lineRect.origin.y = self.frame.size.height- lineRect.size.height;
        if (!lineRect.size.width) lineRect.size.width = self.frame.size.width;
        self.bottomView.frame = lineRect;
        [self addSubview:self.bottomView];
        self.param.wInsertMenuLine(self.bottomView);
    }
}

- (void)setDefaultSelect:(NSInteger)index{
    if (self.btnArr.count <= index) return;
    [self.btnArr[index] sendActionsForControlEvents:UIControlEventTouchUpInside];
}

/// 重置contensize
- (void)resetMainViewContenSize:(WMZPageNaviBtn*)btn{
    self.scrollEnabled = (CGRectGetMaxX(btn.frame) > self.frame.size.width);
    self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
    if (self.contentSize.width < self.frame.size.width &&
        self.param.wMenuPosition == PageMenuPositionCenter &&
        self.param.wMenuWidth == PageVCWidth) {
        CGRect rect = self.frame;
        rect.size.width = self.contentSize.width + self.param.wMenuInsets.left + self.param.wMenuInsets.right;
        rect.origin.x = (PageVCWidth - rect.size.width)/2;
        self.frame = rect;
    }
}

//初始化指示器
- (void)setUpIndicator{
    self.lineView = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.param.wMenuIndicatorImage) {
        [self.lineView setImage:[UIImage imageNamed:self.param.wMenuIndicatorImage] forState:UIControlStateNormal];
    }else{
        self.lineView.backgroundColor = self.param.wMenuIndicatorColor;
    }
    [self addSubview:self.lineView];
    if (self.param.wMenuAnimal == PageTitleMenuCircle) {
        self.lineView.userInteractionEnabled = NO;
        [self sendSubviewToBack:self.lineView];
    }
    self.lineView.hidden = (self.param.wMenuAnimal == PageTitleMenuNone||
                            self.param.wMenuAnimal == PageTitleMenuTouTiao||
                            self.param.wMenuAnimal == PageTitleMenuCircleBg
                            );
    if (self.param.wMenuIndicatorRadio) {
        self.lineView.layer.cornerRadius = self.param.wMenuIndicatorRadio;
        self.lineView.layer.masksToBounds = YES;
    }
}

/// 设置右边固定标题
- (void)setUpFixRightBtn:(WMZPageNaviBtn*)temp{
    if (self.param.wMenuFixRightData) {
        self.fixBtnArr = [NSMutableArray new];
        NSMutableArray *fixData = [NSMutableArray new];
        if ([self.param.wMenuFixRightData isKindOfClass:[NSArray class]]) {
            fixData = [NSMutableArray arrayWithArray:self.param.wMenuFixRightData];
        }else{
            [fixData addObject:self.param.wMenuFixRightData];
        }
        CGFloat allWidth = 0;
        for (int i = ((int)fixData.count - 1); i >= 0 ; i--) {
            id info = fixData[i];
            WMZPageNaviBtn *fixBtn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
            fixBtn.config = info;
            CGFloat menuFixWidth = [self getTitleData:info key:WMZPageKeyTitleWidth]?[[self getTitleData:info key:WMZPageKeyTitleWidth] floatValue]:self.param.wMenuFixWidth;
            CGFloat originY = [self getTitleData:info key:WMZPageKeyTitleMarginY]?[[self getTitleData:info key:WMZPageKeyTitleMarginY] floatValue]:(temp.frame.origin.y + self.param.wMenuInsets.top);
            CGFloat menuFixHeight = [self getTitleData:info key:WMZPageKeyTitleHeight]?[[self getTitleData:info key:WMZPageKeyTitleHeight] floatValue]:temp.frame.size.height;
            id text = [self getTitleData:info key:WMZPageKeyName];
            id selectText = [self getTitleData:info key:WMZPageKeySelectName];
            id image = [self getTitleData:info key:WMZPageKeyImage];
            id selectImage = [self getTitleData:info key:WMZPageKeySelectImage];
            id titleColor = [self getTitleData:info key:WMZPageKeyTitleColor]?:self.param.wMenuTitleColor;
            id titleSelectColor = [self getTitleData:info key:WMZPageKeyTitleSelectColor]?:self.param.wMenuTitleSelectColor;
            if (text) {
                if ([text isKindOfClass:NSString.class]) [fixBtn setTitle:text forState:UIControlStateNormal];
                else if ([text isKindOfClass:NSAttributedString.class]) [fixBtn setAttributedTitle:text forState:UIControlStateNormal];
                fixBtn.normalText = text;
            }
            if (selectText) {
                if ([selectText isKindOfClass:NSString.class]) [fixBtn setTitle:selectText forState:UIControlStateSelected];
                else if ([selectText isKindOfClass:NSAttributedString.class]) [fixBtn setAttributedTitle:selectText forState:UIControlStateSelected];
                fixBtn.selectText = selectText;
            }
            if (image){
                if ([image isKindOfClass:NSString.class]) {
                    [fixBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
                }else if ([image isKindOfClass:UIImage.class]) {
                    [fixBtn setImage:image forState:UIControlStateNormal];
                }
            }
            if (selectImage && image){
                if ([selectImage isKindOfClass:NSString.class]) {
                    [fixBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
                }else if ([selectImage isKindOfClass:UIImage.class]) {
                    [fixBtn setImage:selectImage forState:UIControlStateSelected];
                }
            }
            if (text && image) menuFixWidth += 30;
            allWidth += menuFixWidth;
            fixBtn.titleLabel.font = self.param.wMenuTitleUIFont;
            [fixBtn setTitleColor:titleColor forState:UIControlStateNormal];
            [fixBtn setTitleColor:titleSelectColor forState:UIControlStateSelected];
            fixBtn.frame = CGRectMake(CGRectGetMaxX(self.frame)-allWidth, originY, menuFixWidth, menuFixHeight);
            fixBtn.tag = 10086+i;
            fixBtn.backgroundColor = temp.backgroundColor;
            [self addSubview:fixBtn];
            [self bringSubviewToFront:fixBtn];
            CGFloat margin = [self getTitleData:info key:WMZPageKeyImageOffset]?[[self getTitleData:info key:WMZPageKeyImageOffset] floatValue]:self.param.wMenuImageMargin;
            if (image) [fixBtn tagSetImagePosition:self.param.wMenuImagePosition spacing:margin];
            if (self.param.wMenuFixShadow) {
               [fixBtn viewShadowPathWithColor:PageColor(0x333333) shadowOpacity:0.8 shadowRadius:3 shadowPathType:PageShadowPathLeft shadowPathWidth:2];
                fixBtn.alpha = 0.9;
            }
            [fixBtn setAdjustsImageWhenHighlighted:NO];
            [fixBtn addTarget:self action:@selector(fixTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.fixBtnArr addObject:fixBtn];
        }
        if (self.param.wCustomMenufixTitle) self.param.wCustomMenufixTitle(self.fixBtnArr);
        self.contentSize = CGSizeMake(self.contentSize.width + allWidth, 0);
        self.scrollEnabled = !(CGRectGetMaxX(temp.frame) <= (self.frame.size.width - allWidth));
    }
}

/// 设置按钮样式
- (void)setPropertiesWithBtn:(WMZPageNaviBtn*)btn withIndex:(NSInteger)i  withTemp:(WMZPageNaviBtn*)temp{
    CGFloat margin = self.param.wMenuCellMargin;
    btn.param = self.param;
    btn.titleLabel.font = self.param.wMenuTitleUIFont;
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    id titleInfo = self.param.wTitleArr[i];
    btn.config = titleInfo;
    id selectColor = [self getTitleData:titleInfo key:WMZPageKeyTitleSelectColor]?:self.param.wMenuTitleSelectColor;
    id color = [self getTitleData:titleInfo key:WMZPageKeyTitleColor]?:self.param.wMenuTitleColor;
    [btn setTitleColor:selectColor?:self.param.wMenuTitleSelectColor forState:UIControlStateSelected];
    [btn setTitleColor:color forState:UIControlStateNormal];
    id name = [self getTitleData:titleInfo key:WMZPageKeyName];
    if (name) {
        if ([name isKindOfClass:NSString.class]) [btn setTitle:name forState:UIControlStateNormal];
        else if ([name isKindOfClass:NSAttributedString.class]) [btn setAttributedTitle:name forState:UIControlStateNormal];
        btn.normalText = name;
    }
    id selectText = [self getTitleData:titleInfo key:WMZPageKeySelectName];
    if (selectText) {
        if ([selectText isKindOfClass:NSString.class]) [btn setTitle:selectText forState:UIControlStateSelected];
        else if ([selectText isKindOfClass:NSAttributedString.class]) [btn setAttributedTitle:selectText forState:UIControlStateSelected];
        btn.selectText = selectText;
    }
    CGSize size =  btn.maxSize;
    /// 设置图片
    id image = [self getTitleData:titleInfo key:WMZPageKeyImage];
    id selectImage = [self getTitleData:titleInfo key:WMZPageKeySelectImage];
    id onlyClick = [self getTitleData:titleInfo key:WMZPageKeyOnlyClick];
    id titleBackground = [self getTitleData:titleInfo key:WMZPageKeyTitleBackground];
    if (!titleBackground) titleBackground = self.param.wMenuTitleBackground ?: UIColor.clearColor;
    if (titleBackground) btn.backgroundColor = titleBackground;
    if (image) {
        if ([image isKindOfClass:NSString.class]) {
            [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }else if ([image isKindOfClass:UIImage.class]) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    if (onlyClick) btn.onlyClick = [onlyClick boolValue];
    if (image && selectImage){
        if ([selectImage isKindOfClass:NSString.class]) {
            [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        }else if ([selectImage isKindOfClass:UIImage.class]) {
            [btn setImage:selectImage forState:UIControlStateSelected];
        }
    }
    if (size.width == 0 && image) size.width = 20.0f;
    if (size.height == 0 && image) size.height = 20.0f;
    btn.maxSize = size;
    if (image) {
        if (self.param.wMenuImagePosition == PageBtnPositionLeft || self.param.wMenuImagePosition == PageBtnPositionRight ) {
            margin += 20;
            margin += self.param.wMenuImageMargin;
        }
        if (self.param.wMenuImagePosition == PageBtnPositionTop || self.param.wMenuImagePosition == PageBtnPositionBottom ) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
    }
    if (self.param.wMenuPosition != PageMenuPositionNavi) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    CGFloat btnWidth = [self getTitleData:titleInfo key:WMZPageKeyTitleWidth]?[[self getTitleData:titleInfo key:WMZPageKeyTitleWidth] floatValue]:(self.param.wMenuTitleWidth?:(size.width + margin));
    CGFloat marginX = 0;
    CGFloat originY = [self getTitleData:titleInfo key:WMZPageKeyTitleMarginY]?[[self getTitleData:titleInfo key:WMZPageKeyTitleMarginY] floatValue]:0;
    CGFloat btnHeight = [self getTitleData:titleInfo key:WMZPageKeyTitleHeight]?[[self getTitleData:titleInfo key:WMZPageKeyTitleHeight] floatValue]:self.param.wMenuHeight;
    btn.tag = i;
    if (temp) {
        marginX = [self getTitleData:titleInfo key:WMZPageKeyTitleMarginX]?[[self getTitleData:titleInfo key:WMZPageKeyTitleMarginX] floatValue]:self.param.wMenuTitleOffset;
        btn.frame = CGRectMake((CGRectGetMaxX(temp.frame)+marginX), originY, btnWidth, btnHeight);
    }else{
        marginX = [self getTitleData:titleInfo key:WMZPageKeyTitleMarginX]?[[self getTitleData:titleInfo key:WMZPageKeyTitleMarginX] floatValue]:0;
        btn.frame = CGRectMake(marginX, originY, btnWidth, btnHeight);
    }
    /// 设置右上角红点
    NSString *badge = [self getTitleData:titleInfo key:WMZPageKeyBadge];
    if (badge) [btn showBadgeWithTopMagin:self.param.wTitleArr[i]];
    if (self.param.wMenuAnimal == PageTitleMenuCircleBg &&
        self.param.wMenuTitleRadios == 0) self.param.wMenuTitleRadios = btnHeight/2;
    if (self.param.wMenuTitleRadios) btn.layer.cornerRadius = self.param.wMenuTitleRadios;
    CGFloat imageMargin = [self getTitleData:titleInfo key:WMZPageKeyImageOffset]?[[self getTitleData:titleInfo key:WMZPageKeyImageOffset] floatValue]:self.param.wMenuImageMargin;
    if (image) [btn tagSetImagePosition:self.param.wMenuImagePosition spacing:imageMargin];
    if (self.btnArr.count>i) {
        [self.btnArr insertObject:btn atIndex:i];
        [self insertSubview:btn atIndex:i];
    }else{
        [self.btnArr addObject:btn];
        [self addSubview:btn];
    }
    
}

/// 解析字典
- (NSString*)getTitleData:(id)model key:(NSString*)key{
    if ([model isKindOfClass:[NSString class]] || [model isKindOfClass:[NSAttributedString class]])  return [key isEqualToString:WMZPageKeyName] ? model : nil;
    else if ([model isKindOfClass:[NSDictionary class]]) return [model objectForKey:key] ? : nil;
    return nil;
}

/// 点击
- (void)tap:(WMZPageNaviBtn*)btn{
    NSInteger index = [self.btnArr indexOfObject:btn];
    if (index == NSNotFound || index > self.btnArr.count) return;
    [self scrollToIndex:index animal:YES];
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)])[self.menuDelegate titleClick:btn fix:NO];
    
}

/// 固定标题点击
- (void)fixTap:(WMZPageNaviBtn*)btn{
    if (self.fixLastBtn)  self.fixLastBtn.selected = NO;
    btn.selected = YES;
    if (self.param.wEventFixedClick) self.param.wEventFixedClick(btn, btn.tag);
    self.fixLastBtn = btn;
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)]) [self.menuDelegate titleClick:btn fix:YES];
}

- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal{
    if (self.btnArr.count <= newIndex) return;
    if (animal && !self.lastBTN) animal = NO;
    WMZPageNaviBtn *btn = self.btnArr[newIndex];
    if (self.lastBTN) {
        self.lastBTN.selected = NO;
        self.lastBTN.titleLabel.font = self.param.wMenuTitleUIFont;
        if (self.param.wMenuTitleBackground) self.lastBTN.layer.backgroundColor = self.param.wMenuTitleBackground.CGColor;
        if (self.lastBTN.layer.backgroundColor && !self.param.wMenuTitleBackground) self.lastBTN.layer.backgroundColor = UIColor.clearColor.CGColor;
        if ([self getTitleData:self.lastBTN.config key:WMZPageKeyImage]) {
            [self.lastBTN tagSetImagePosition:self.param.wMenuImagePosition spacing:[self getTitleData:self.lastBTN.config key:WMZPageKeyImageOffset]?[[self getTitleData:self.lastBTN.config key:WMZPageKeyImageOffset] floatValue]:self.param.wMenuImageMargin];
        }
    }
    btn.selected = YES;
    /// 隐藏右上角红点
    [btn hidenBadge];
    /// 改变背景色
    NSArray* backgroundColor = (NSArray*)[self getTitleData:self.param.wTitleArr[newIndex] key:WMZPageKeyBackgroundColor];
    /// 改变指示器颜色
    id indicatorColor = [self getTitleData:self.param.wTitleArr[newIndex] key:WMZPageKeyIndicatorColor];
    UIColor *tempBackgroundColor = self.param.wMenuBgColor;
    UIColor *fixBackgroundColor = self.param.wMenuBgColor;
    if (backgroundColor) {
        /// 渐变色
        if ([backgroundColor isKindOfClass:[NSArray class]]) {
            if ([backgroundColor count] > 1) {
                tempBackgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(self.contentSize.width, self.frame.size.height) direction:PageGradientChangeDirectionLevel startColor:backgroundColor[0] endColor:backgroundColor[1]];
                fixBackgroundColor = backgroundColor[1];
            }else{
                tempBackgroundColor = backgroundColor[0];
                fixBackgroundColor = tempBackgroundColor;
            }
        }else if ([backgroundColor isKindOfClass:[UIColor class]]){
                 tempBackgroundColor = (UIColor*)backgroundColor;
                 fixBackgroundColor = tempBackgroundColor;
        }
    }
    if (!self.param.wInsertHeadAndMenuBg) self.backgroundColor = tempBackgroundColor;
    if (!self.param.wMenuIndicatorImage) self.lineView.backgroundColor = indicatorColor?:self.param.wMenuIndicatorColor;
    [self.fixBtnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = fixBackgroundColor;
        if (!CGColorEqualToColor(self.param.wMenuBgColor.CGColor, fixBackgroundColor.CGColor)) {
            [obj setTitleColor:[btn titleColorForState:UIControlStateSelected] forState:UIControlStateNormal];
        }
    }];
    btn.titleLabel.font = self.param.wMenuTitleSelectUIFont;
    if (self.param.wMenuSelectTitleBackground) btn.layer.backgroundColor = self.param.wMenuSelectTitleBackground.CGColor;
    if ([self getTitleData:btn.config key:WMZPageKeyImage]) {
        [btn tagSetImagePosition:self.param.wMenuImagePosition spacing:[self getTitleData:btn.config key:WMZPageKeyImageOffset]?[[self getTitleData:btn.config key:WMZPageKeyImageOffset] floatValue]:self.param.wMenuImageMargin];
    }
    
    /// 滚动到中间
    CGFloat centerX = self.frame.size.width / 2 ;
    CGRect indexFrame = btn.frame;
    CGFloat contenSizeWidth = self.contentSize.width  + self.param.wMenuInsets.right;
    CGPoint point = CGPointZero;
    if ((ceil(indexFrame.origin.x) + self.param.wMenuInsets.left) < centerX) {
        point = CGPointMake(-self.param.wMenuInsets.left, 0);
    }else if (ceil(CGRectGetMaxX(indexFrame)) > (contenSizeWidth - centerX)) {
        point = CGPointMake(contenSizeWidth - self.frame.size.width , 0);
    }else{
        point = CGPointMake(CGRectGetMaxX(indexFrame) -  centerX - indexFrame.size.width/2, 0);
    }
    if ([self isScrollEnabled]) [self setContentOffset:point animated:animal];
    if (![self.lineView isHidden]) {
        CGFloat dataWidth = btn.titleLabel.frame.size.width?:btn.maxSize.width;
        /// 改变指示器frame
        CGRect lineRect = indexFrame;
        if (self.param.wMenuAnimal == PageTitleMenuCircle) {
            lineRect = indexFrame;
            lineRect.origin.x =  indexFrame.origin.x ;
            lineRect.size.width =  indexFrame.size.width ;
            lineRect.size.height =  self.param.wMenuIndicatorHeight?:(btn.maxSize.height + 8);
            lineRect.origin.y =  (indexFrame.size.height -  lineRect.size.height)/2;
            self.lineView.layer.masksToBounds = YES;
            self.lineView.layer.cornerRadius =  self.param.wMenuCircilRadio?:(lineRect.size.height/2);
        }else{
            lineRect.size.height = self.param.wMenuIndicatorHeight?:PageK1px;
            lineRect.origin.y = [self getMainHeight] - lineRect.size.height/2 - self.param.wMenuIndicatorY;
            lineRect.size.width =  self.param.wMenuIndicatorWidth?:(dataWidth+6);
            lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
        }
        if (!animal) {
            self.lineView.frame = lineRect;
        }else{
            [UIView animateWithDuration:0.2f animations:^{
                self.lineView.frame = lineRect;
            }];
        }
    }
    self.currentTitleIndex = newIndex;
    if (self.param.wInsertHeadAndMenuBg) self.backgroundColor = [UIColor clearColor];
    if (self.param.wCustomMenuSelectTitle) self.param.wCustomMenuSelectTitle(self.btnArr);
    self.lastBTN = btn;
}

- (CGFloat)getMainHeight{
    if ((PageIsIphoneX && self.param.wMenuPosition == PageMenuPositionBottom)) return (self.frame.size.height - 15);
    else if (self.param.wMenuPosition == PageMenuPositionNavi) return 44;
    return self.frame.size.height;
}

- (NSMutableArray<WMZPageNaviBtn *> *)btnArr{
    return _btnArr ?: ({ _btnArr = NSMutableArray.new;});
}

- (NSMutableArray<WMZPageNaviBtn *> *)fixBtnArr{
    return _fixBtnArr ?: ({ _fixBtnArr = NSMutableArray.new;});
}

@end
