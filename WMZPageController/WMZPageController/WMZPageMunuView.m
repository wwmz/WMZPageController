//
//  WMZPageMunuView.m
//  WMZPageController
//
//  Created by wmz on 2020/10/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageMunuView.h"

@interface WMZPageMunuView(){
    WMZPageNaviBtn *_btnLeft;
    WMZPageNaviBtn *_btnRight;
    CGFloat fixAllWidth;
}
@end

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
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.btnArr = [NSMutableArray new];
    [self addSubview:self.containView];
    WMZPageNaviBtn *temp = nil;
    for (int i = 0; i<self.param.wTitleArr.count; i++) {
        WMZPageNaviBtn *btn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
        [self setPropertiesWithBtn:btn withIndex:i withTemp:temp];
        temp = btn;
    }
    if (self.param.wCustomMenuView) self.param.wCustomMenuView(self);
    /// 指示器
    [self setUpIndicator];
    /// 右边固定标题
    [self setUpFixRightBtn:temp];
    if (temp) [self resetMainViewContenSize:temp];
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

- (void)updateUI{
    [self.btnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnArr removeAllObjects];
    WMZPageNaviBtn *temp = nil;
    for (int i = 0; i< self.param.wTitleArr.count; i++) {
        WMZPageNaviBtn *btn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
        [self setPropertiesWithBtn:btn withIndex:i withTemp:temp];
        temp = btn;
        if (i == self.param.wTitleArr.count - 1) {
            [self resetMainViewContenSize:btn];
        }
        if (self.lastBTN) {
            if (i == self.lastBTN.tag) {
                self.lastBTN = btn;
            }
        }else{
            if (i == self.currentTitleIndex) {
                self.lastBTN = btn;
            }
        }
    }
    [self scrollToIndex:self.lastBTN.tag animal:NO];
}

- (void)setDefaultSelect:(NSInteger)index{
    if (self.btnArr.count <= index) return;
    [self.btnArr[index] sendActionsForControlEvents:UIControlEventTouchUpInside];
}

/// 重置contensize
- (void)resetMainViewContenSize:(WMZPageNaviBtn*)btn{
    self.scrollEnabled = (CGRectGetMaxX(btn.frame) > self.frame.size.width);
    self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
    CGRect rect = self.frame;
    if (self.contentSize.width < self.frame.size.width &&
        self.param.wMenuPosition == PageMenuPositionCenter &&
        self.param.wMenuWidth == PageVCWidth) {
        rect.size.width = self.contentSize.width + self.param.wMenuInsets.left + self.param.wMenuInsets.right;
        rect.origin.x = (PageVCWidth - rect.size.width)/2;
        self.frame = rect;
    }
    if (self.btnArr.count) {
        [self sendSubviewToBack:self.containView];
        self.containView.frame = CGRectMake(self.btnArr.firstObject.frame.origin.x, btn.frame.origin.y, CGRectGetMaxX(btn.frame), btn.frame.size.height);
    }
    if (self.fixBtnArr) {
        self.contentSize = CGSizeMake(self.contentSize.width + fixAllWidth, 0);
        self.scrollEnabled = (CGRectGetMaxX(btn.frame) > (self.frame.size.width - fixAllWidth));
    }
}

/// 初始化指示器
- (void)setUpIndicator{
    self.lineView = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
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
                            self.param.wMenuAnimal == PageTitleMenuCircleBg||
                            self.param.wMenuAnimal == PageTitleMenuJD);
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
        fixAllWidth = allWidth;
        if (self.param.wCustomMenufixTitle) self.param.wCustomMenufixTitle(self.fixBtnArr);
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
    if (self.lastBTN == btn) return;
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
        if (self.param.wMenuAnimal == PageTitleMenuJD && self.lastBTN != btn){
            [self.lastBTN jdRemoveLayer];
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
        lineRect.size.width =  self.param.wMenuIndicatorWidth?: (dataWidth + 6);
        lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
    }
    if (!animal) {
        self.lineView.frame = lineRect;
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            self.lineView.frame = lineRect;
        }];
    }
    
    self.currentTitleIndex = newIndex;
    if (self.param.wInsertHeadAndMenuBg) self.backgroundColor = [UIColor clearColor];
    if (self.param.wCustomMenuSelectTitle) self.param.wCustomMenuSelectTitle(self.btnArr);
    if (self.param.wMenuAnimal == PageTitleMenuJD){
        if (self.lastBTN != btn) {
            btn.jdLayer.backgroundColor = self.param.wMenuIndicatorColor;
            if (self.param.wEventCustomJDAnimal) self.param.wEventCustomJDAnimal(btn, btn.jdLayer);
            [btn jdAddLayer];
        }
    }
    self.lastBTN = btn;
}

/// 动画管理
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat sWidth =  PageVCWidth;
    CGFloat content_X = (contentOffsetX / sWidth);
    NSArray *arr = [[NSString stringWithFormat:@"%f",content_X] componentsSeparatedByString:@"."];
    int num = [arr[0] intValue];
    CGFloat scale = content_X - num;
    int selectIndex = contentOffsetX/sWidth;
    BOOL left = false;
    /// 拖拽
    if (contentOffsetX <= lastContentOffset){
        left = YES;
        selectIndex = selectIndex+1;
        _btnRight = [self safeObjectAtIndex:selectIndex data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex-1 data:self.btnArr];
    } else if (contentOffsetX > lastContentOffset ){
        _btnRight = [self safeObjectAtIndex:selectIndex+1 data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex data:self.btnArr];
    }
    /// 跟随滑动
    if (self.param.wMenuAnimal == PageTitleMenuAiQY) {
        CGRect rect = self.lineView.frame;
        if (scale < 0.5 ) {
            rect.origin.x = _btnLeft.center.x -self.param.wMenuIndicatorWidth/2;
            rect.size.width = self.param.wMenuIndicatorWidth + (_btnRight.center.x-_btnLeft.center.x) * scale*2;
        }else if(scale >= 0.5 ){
            rect.origin.x = _btnLeft.center.x +  2 * (scale - 0.5) * (_btnRight.center.x - _btnLeft.center.x) - self.param.wMenuIndicatorWidth / 2;
            rect.size.width =  self.param.wMenuIndicatorWidth + (_btnRight.center.x-_btnLeft.center.x) * (1-scale)*2;
        }
        if (rect.size.height!= (self.param.wMenuIndicatorHeight?:PageK1px))
            rect.size.height = self.param.wMenuIndicatorHeight?:PageK1px;
        if (rect.origin.y != ([self getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2))
            rect.origin.y = [self getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2;
        self.lineView.frame = rect;
    }else if (self.param.wMenuAnimal == PageTitleMenuPDD) {
        CGRect rect = self.lineView.frame;
        rect.size.width = self.param.wMenuIndicatorWidth?:rect.size.width;
        self.lineView.frame = rect;
        CGPoint center = self.lineView.center;
        center.x = _btnLeft.center.x +  (scale)*(_btnRight.center.x - _btnLeft.center.x);
        self.lineView.center = center;
    }else if (self.param.wMenuAnimal == PageTitleMenuNewAiQY) {
        CGPoint center = self.lineView.center;
        CGRect rect = self.lineView.frame;
        if (scale < 0.5) {
            rect.size.width = (1 - scale * 2) * self.param.wMenuIndicatorWidth;
            self.lineView.frame = rect;
            self.lineView.alpha = (1 - scale * 2);
            center.x = _btnLeft.center.x;
        }else{
            rect.size.width =  (scale - 0.5) * 2 * self.param.wMenuIndicatorWidth;
            self.lineView.alpha = scale;
            self.lineView.frame = rect;
            center.x = _btnRight.center.x;
        }
        self.lineView.center = center;
    }
    /// 渐变
    if (self.param.wMenuAnimalTitleGradient) {
        WMZPageNaviBtn *tempBtn = _btnLeft?:_btnRight;
        CGFloat difR = tempBtn.selectedColorR - tempBtn.unSelectedColorR;
        CGFloat difG = tempBtn.selectedColorG - tempBtn.unSelectedColorG;
        CGFloat difB = tempBtn.selectedColorB - tempBtn.unSelectedColorB;
        UIColor *leftItemColor  = [UIColor colorWithRed:tempBtn.unSelectedColorR+scale*difR green:tempBtn.unSelectedColorG+scale*difG blue:tempBtn.unSelectedColorB+scale*difB alpha:1];
        UIColor *rightItemColor = [UIColor colorWithRed:tempBtn.unSelectedColorR+(1-scale)*difR green:tempBtn.unSelectedColorG+(1-scale)*difG blue:tempBtn.unSelectedColorB+(1-scale)*difB alpha:1];
        _btnLeft.titleLabel.textColor = rightItemColor;
        _btnRight.titleLabel.textColor = leftItemColor;
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index data:(NSArray*)data{
    return  index < data.count && index >= 0 ? [data objectAtIndex:index] : nil;
}

- (CGFloat)getMainHeight{
    if ((PageIsIphoneX && self.param.wMenuPosition == PageMenuPositionBottom)) return (self.frame.size.height - 15);
    else if (self.param.wMenuPosition == PageMenuPositionNavi) return 44;
    else if (self.param.wMenuAddSubView){
        return self.frame.size.height - self.param.wMenuInsets.bottom;
    }
    return self.frame.size.height;
}

- (NSMutableArray<WMZPageNaviBtn *> *)btnArr{
    return _btnArr ?: ({ _btnArr = NSMutableArray.new;});
}

- (NSMutableArray<WMZPageNaviBtn *> *)fixBtnArr{
    return _fixBtnArr ?: ({ _fixBtnArr = NSMutableArray.new;});
}

- (UIView *)containView{
    return _containView ?: ({ _containView = UIView.new;});
}

@end
