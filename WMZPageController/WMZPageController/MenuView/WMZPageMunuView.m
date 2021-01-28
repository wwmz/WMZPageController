//
//  WMZPageMunuView.m
//  WMZPageController
//
//  Created by wmz on 2020/10/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageMunuView.h"
@interface WMZPageMunuView(){
    WMZPageParam *_param;
}
@end
@implementation WMZPageMunuView

- (instancetype)init{
    if (self = [super init]) {
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

//ui
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
    if (self.param.wCustomMenuView) {
        self.param.wCustomMenuView(self);
    }
    //指示器
    [self setUpIndicator];
    //右边固定标题
    [self setUpFixRightBtn:temp];
    
}

//重置contensize
- (void)resetMainViewContenSize:(WMZPageNaviBtn*)btn{
    if (CGRectGetMaxX(btn.frame) <= self.frame.size.width) {
        self.scrollEnabled = NO;
    }else{
        self.scrollEnabled = YES;
    }
    self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
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

//设置右边固定标题
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
        for (int i = ((int)fixData.count - 1); i>=0; i--) {
            id info = fixData[i];
            WMZPageNaviBtn *fixBtn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
            CGFloat menuFixWidth = [self getTitleData:info key:@"width"]?[[self getTitleData:info key:@"width"] floatValue]:self.param.wMenuFixWidth;
            CGFloat originY = [self getTitleData:info key:@"y"]?[[self getTitleData:info key:@"y"] floatValue]:temp.frame.origin.y;
            CGFloat menuFixHeight = [self getTitleData:info key:@"height"]?[[self getTitleData:info key:@"height"] floatValue]:temp.frame.size.height;
            id text = [self getTitleData:info key:@"name"];
            id selectText = [self getTitleData:info key:@"selectName"];
            id image = [self getTitleData:info key:@"image"];
            id selectImage = [self getTitleData:info key:@"selectImage"];
            id titleColor = [self getTitleData:info key:@"titleColor"]?:self.param.wMenuTitleColor;
            id titleSelectColor = [self getTitleData:info key:@"titleSelectColor"]?:self.param.wMenuTitleSelectColor;
            if (text) {
                [fixBtn setTitle:text forState:UIControlStateNormal];
            }
            if (selectText) {
                [fixBtn setTitle:selectText forState:UIControlStateSelected];
            }
            if (image) {
                [fixBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            }
            if (selectImage) {
                [fixBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
            }
            if (text && image) {
                menuFixWidth+=30;
            }
            allWidth += menuFixWidth;
            fixBtn.titleLabel.font = self.param.wMenuTitleUIFont;
            [fixBtn setTitleColor:titleColor forState:UIControlStateNormal];
            [fixBtn setTitleColor:titleSelectColor forState:UIControlStateSelected];
            fixBtn.frame = CGRectMake(CGRectGetMaxX(self.frame)-allWidth, originY, menuFixWidth, menuFixHeight);
            fixBtn.tag = 10086+i;
            fixBtn.backgroundColor = temp.backgroundColor;
            [self addSubview:fixBtn];
            [self bringSubviewToFront:fixBtn];
            CGFloat margin = [self getTitleData:info key:@"margin"]?[[self getTitleData:info key:@"margin"] floatValue]:self.param.wMenuImageMargin;
            if (image) {
                [fixBtn TagSetImagePosition:self.param.wMenuImagePosition spacing:margin];
            }
            if (self.param.wMenuFixShadow) {
               [fixBtn viewShadowPathWithColor:PageColor(0x333333) shadowOpacity:0.8 shadowRadius:3 shadowPathType:PageShadowPathLeft shadowPathWidth:2];
                fixBtn.alpha = 0.9;
            }
            [fixBtn  setAdjustsImageWhenHighlighted:NO];
            [fixBtn addTarget:self action:@selector(fixTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.fixBtnArr addObject:fixBtn];
        }
        if (self.param.wCustomMenufixTitle) {
            self.param.wCustomMenufixTitle(self.fixBtnArr);
        }
        
        self.contentSize = CGSizeMake(self.contentSize.width+allWidth, 0);
        self.scrollEnabled = !(CGRectGetMaxX(temp.frame) <= (self.frame.size.width-allWidth));
    }
}

//设置按钮样式
- (void)setPropertiesWithBtn:(WMZPageNaviBtn*)btn withIndex:(NSInteger)i  withTemp:(WMZPageNaviBtn*)temp{
    CGFloat margin = self.param.wMenuCellMargin;
    btn.param = self.param;
    btn.titleLabel.font = self.param.wMenuTitleUIFont;
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    id titleInfo = self.param.wTitleArr[i];
    id selectColor = [self getTitleData:titleInfo key:@"titleSelectColor"]?:self.param.wMenuTitleSelectColor;
    id color = [self getTitleData:titleInfo key:@"titleColor"]?:self.param.wMenuTitleColor;
    [btn setTitleColor:selectColor?:self.param.wMenuTitleSelectColor forState:UIControlStateSelected];
    [btn setTitleColor:color forState:UIControlStateNormal];
    id name = [self getTitleData:titleInfo key:@"name"];
    if (name) {
        [btn setTitle:name forState:UIControlStateNormal];
        btn.normalText = name;
    }
    id selectName = [self getTitleData:titleInfo key:@"selectName"];
    if (selectName) {
        [btn setTitle:selectName forState:UIControlStateSelected];
        btn.selectText = selectName;
    }
    CGSize size =  btn.maxSize;
    //设置图片
    id image = [self getTitleData:titleInfo key:@"image"];
    id selectImage = [self getTitleData:titleInfo key:@"selectImage"];
    id onlyClick = [self getTitleData:titleInfo key:@"onlyClick"];
    id titleBackground = [self getTitleData:titleInfo key:@"titleBackground"];
    btn.backgroundColor = titleBackground?:self.param.wMenuTitleBackground;
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    if (onlyClick) {
        btn.onlyClick = [onlyClick boolValue];
    }
    if (image&&selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }

    if (size.width == 0 && image) {
        size.width = 20.0f;
    }
    if (size.height == 0 && image) {
        size.height = 20.0f;
    }
    btn.maxSize = size;
    if (image) {
        if (self.param.wMenuImagePosition == PageBtnPositionLeft || self.param.wMenuImagePosition == PageBtnPositionRight ) {
            margin+=20;
            margin+=self.param.wMenuImageMargin;
        }
        if (self.param.wMenuImagePosition == PageBtnPositionTop || self.param.wMenuImagePosition == PageBtnPositionBottom ) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
    }
    //设置右上角红点
    NSString *badge = [self getTitleData:titleInfo key:@"badge"];
    if (badge) {
       [btn showBadgeWithTopMagin:self.param.wTitleArr[i]];
    }
    if (self.param.wMenuPosition != PageMenuPositionNavi) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    //设置富文本
    id wrapColor = [self getTitleData:titleInfo key:@"wrapColor"];
    id firstColor = [self getTitleData:titleInfo key:@"firstColor"];
    if ([btn.titleLabel.text containsString:@"\n"]&&(wrapColor||firstColor)) {
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
        NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
        [mSelectStr addAttribute:NSForegroundColorAttributeName value:self.param.wMenuTitleSelectColor range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
        NSArray *array = [btn.titleLabel.text componentsSeparatedByString:@"\n"];
        if (wrapColor) {
            [mStr addAttribute:NSForegroundColorAttributeName value:wrapColor range:[btn.titleLabel.text rangeOfString:array[1]]];
        }
        if (firstColor) {
            [mStr addAttribute:NSForegroundColorAttributeName value:firstColor range:[btn.titleLabel.text rangeOfString:array[0]]];
        }
        [btn setAttributedTitle:mStr forState:UIControlStateNormal];
        [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];

    }
    
    CGFloat btnWidth = [self getTitleData:titleInfo key:@"width"]?[[self getTitleData:titleInfo key:@"width"] floatValue]:(self.param.wMenuTitleWidth?:(size.width + margin));
    CGFloat marginX = 0;
    CGFloat originY = [self getTitleData:titleInfo key:@"y"]?[[self getTitleData:titleInfo key:@"y"] floatValue]:0;
    CGFloat btnHeight = [self getTitleData:titleInfo key:@"height"]?[[self getTitleData:titleInfo key:@"height"] floatValue]:self.param.wMenuHeight;
    btn.tag = i;
    if (temp) {
        marginX = [self getTitleData:titleInfo key:@"marginX"]?[[self getTitleData:titleInfo key:@"marginX"] floatValue]:self.param.wMenuTitleOffset;
        btn.frame = CGRectMake((CGRectGetMaxX(temp.frame)+marginX), originY, btnWidth, btnHeight);
    }else{
        marginX = [self getTitleData:titleInfo key:@"marginX"]?[[self getTitleData:titleInfo key:@"marginX"] floatValue]:0;
        btn.frame = CGRectMake(marginX, originY, btnWidth, btnHeight);
    }
    
    if (self.param.wMenuAnimal == PageTitleMenuCircleBg) {
        if (self.param.wMenuTitleRadios == 0) {
            self.param.wMenuTitleRadios = btnHeight/2;
        }
    }
    if (self.param.wMenuTitleRadios) {
        btn.layer.cornerRadius = self.param.wMenuTitleRadios;
    }
    CGFloat imageMargin = [self getTitleData:titleInfo key:@"margin"]?[[self getTitleData:titleInfo key:@"margin"] floatValue]:self.param.wMenuImageMargin;
    if (image) {
        [btn TagSetImagePosition:self.param.wMenuImagePosition spacing:imageMargin];
    }
    if (self.btnArr.count>i) {
        [self.btnArr insertObject:btn atIndex:i];
        [self insertSubview:btn atIndex:i];
    }else{
        [self.btnArr addObject:btn];
        [self addSubview:btn];
    }
    
}

//解析字典
- (NSString*)getTitleData:(id)model key:(NSString*)key{
    if ([model isKindOfClass:[NSString class]]) {
        return [key isEqualToString:@"name"]?model:nil;
    }else if ([model isKindOfClass:[NSDictionary class]]) {
         return [model objectForKey:key]?:nil;
    }
    return nil;
}

//点击
- (void)tap:(WMZPageNaviBtn*)btn{
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)]) {
        [self.menuDelegate titleClick:btn fix:NO];
    }
}

//固定标题点击
- (void)fixTap:(WMZPageNaviBtn*)btn{
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)]) {
        [self.menuDelegate titleClick:btn fix:YES];
    }
}


- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal{
    if (self.btnArr.count<=newIndex) return;
    WMZPageNaviBtn *btn = self.btnArr[newIndex] ;
    //隐藏右上角红点
    [btn hidenBadge];
    //改变背景色
    id backgroundColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"backgroundColor"];
    //改变指示器颜色
    id indicatorColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"indicatorColor"];
    //改变标题颜色
    [self.btnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull temp, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger btnIndex = [self.btnArr indexOfObject:temp];
        temp.selected = (btnIndex == newIndex ?YES:NO);
        if ([temp isSelected]) {
            UIColor *tempBackgroundColor = self.param.wMenuBgColor;
            UIColor *fixBackgroundColor = self.param.wMenuBgColor;
            if (backgroundColor) {
                //渐变色
                if ([backgroundColor isKindOfClass:[NSArray class]]) {
                    if ([backgroundColor count]==2) {
                        
                        tempBackgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(self.contentSize.width, self.frame.size.height) direction:PageGradientChangeDirectionLevel startColor:backgroundColor[0] endColor:backgroundColor[1]];
                        fixBackgroundColor = backgroundColor[1];
                    }else{
                        tempBackgroundColor = backgroundColor[0];
                        fixBackgroundColor = tempBackgroundColor;
                    }
                }else if ([backgroundColor isKindOfClass:[UIColor class]]){
                           tempBackgroundColor = backgroundColor;
                           fixBackgroundColor = tempBackgroundColor;
                }
            }
            if (!self.param.wInsertHeadAndMenuBg) {
                self.backgroundColor = tempBackgroundColor;
            }
            if (!self.param.wMenuIndicatorImage) {
                self.lineView.backgroundColor = indicatorColor?:self.param.wMenuIndicatorColor;
            }
            temp.titleLabel.font = self.param.wMenuTitleSelectUIFont;
            [self.fixBtnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.backgroundColor = fixBackgroundColor;
                if (!CGColorEqualToColor(self.param.wMenuBgColor.CGColor, fixBackgroundColor.CGColor)) {
                    [obj setTitleColor:[temp titleColorForState:UIControlStateSelected] forState:UIControlStateNormal];
                }
            }];
            temp.layer.backgroundColor = self.param.wMenuSelectTitleBackground.CGColor;
        }else{
            temp.titleLabel.font = self.param.wMenuTitleUIFont;
            temp.layer.backgroundColor = self.param.wMenuTitleBackground.CGColor;
        }
    }];
    
    //滚动到中间
    CGFloat centerX = self.frame.size.width/2 ;
    CGRect indexFrame = btn.frame;
    CGFloat contenSize = self.contentSize.width;
    CGPoint point = CGPointZero;
    if (indexFrame.origin.x<= centerX) {
        point = CGPointMake(0, 0);
    }else if (CGRectGetMaxX(indexFrame) > (contenSize-centerX)) {
        point = CGPointMake(self.contentSize.width-self.frame.size.width , 0);
    }else{
        point = CGPointMake(CGRectGetMaxX(indexFrame) -  centerX-  indexFrame.size.width/2, 0);
    }
    if ([self isScrollEnabled]) {
        [self setContentOffset:point animated:animal?YES:NO];
    }
    
    if (![self.lineView isHidden]) {
        CGFloat dataWidth = btn.titleLabel.frame.size.width?:btn.maxSize.width;
        //改变指示器frame
        CGRect lineRect = indexFrame;
        lineRect.size.height = self.param.wMenuIndicatorHeight?:PageK1px;
        lineRect.origin.y = [self getMainHeight] - lineRect.size.height/2 - self.param.wMenuIndicatorY;
        lineRect.size.width =  self.param.wMenuIndicatorWidth?:(dataWidth+6);
        lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
        
        if (self.param.wMenuAnimal == PageTitleMenuCircle) {
            lineRect = indexFrame;
            lineRect.origin.x =  indexFrame.origin.x ;
            lineRect.size.width =  indexFrame.size.width ;
            lineRect.size.height =  self.param.wMenuIndicatorHeight?:(btn.maxSize.height + 8);
            lineRect.origin.y =  (indexFrame.size.height -  lineRect.size.height)/2;
            self.lineView.layer.masksToBounds = YES;
            self.lineView.layer.cornerRadius =  self.param.wMenuCircilRadio?:(lineRect.size.height/2);
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
    if (self.param.wInsertHeadAndMenuBg) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    
    if (self.param.wCustomMenuSelectTitle) {
        self.param.wCustomMenuSelectTitle(self.btnArr);
    }
}

//滚动到中间
- (void)scrollToIndex:(NSInteger)newIndex{
    [self scrollToIndex:newIndex animal:YES];
}


- (CGFloat)getMainHeight{
    if ((PageIsIphoneX&&self.param.wMenuPosition == PageMenuPositionBottom)) {
        return (self.frame.size.height - 15);
    }else if (self.param.wMenuPosition == PageMenuPositionNavi) {
        return 44;
    }
    return self.frame.size.height;
}

- (NSMutableArray<WMZPageNaviBtn *> *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}
- (NSMutableArray<WMZPageNaviBtn *> *)fixBtnArr{
    if (!_fixBtnArr) {
        _fixBtnArr = [NSMutableArray new];
    }
    return _fixBtnArr;
}

@end
