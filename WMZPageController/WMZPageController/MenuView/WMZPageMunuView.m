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
    }
    //指示器
    [self setUpIndicator];
    //右边固定标题
    [self setUpFixRightBtn:temp];
    
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
                            self.param.wMenuAnimal == PageTitleMenuTouTiao
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
            CGFloat menuFixWidth = self.param.wMenuFixWidth;
            id fixWidth = [self getTitleData:info key:@"width"];
            id text = [self getTitleData:info key:@"name"];
            id selectText = [self getTitleData:info key:@"selectName"];
            id image = [self getTitleData:info key:@"image"];
            id selectImage = [self getTitleData:info key:@"selectImage"];
            if (fixWidth && [fixWidth floatValue]>=0) {
                menuFixWidth = [fixWidth floatValue];
            }
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
            [fixBtn setTitleColor:self.param.wMenuTitleColor forState:UIControlStateNormal];
            fixBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-allWidth, temp.frame.origin.y, menuFixWidth, temp.frame.size.height);
            fixBtn.tag = 10086+i;
            fixBtn.backgroundColor = temp.backgroundColor;
            [self addSubview:fixBtn];
            [self bringSubviewToFront:fixBtn];
            if (image) {
                [fixBtn TagSetImagePosition:self.param.wMenuImagePosition spacing:self.param.wMenuImageMargin];
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
- (void)setPropertiesWithBtn:(WMZPageNaviBtn*)btn withIndex:(int)i  withTemp:(WMZPageNaviBtn*)temp{
    CGFloat margin = self.param.wMenuCellMargin;
    btn.param = self.param;
    [btn  setAdjustsImageWhenHighlighted:NO];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    id name = [self getTitleData:self.param.wTitleArr[i] key:@"name"];
    if (name) {
        [btn setTitle:name forState:UIControlStateNormal];
        btn.normalText = name;
    }
    id selectName = [self getTitleData:self.param.wTitleArr[i] key:@"selectName"];
    if (selectName) {
        [btn setTitle:selectName forState:UIControlStateSelected];
        btn.selectText = selectName;
    }
    CGSize size =  btn.maxSize;
    //设置图片
    id image = [self getTitleData:self.param.wTitleArr[i] key:@"image"];
    id selectImage = [self getTitleData:self.param.wTitleArr[i] key:@"selectImage"];
    id onlyClick = [self getTitleData:self.param.wTitleArr[i] key:@"onlyClick"];
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
    btn.titleLabel.font = self.param.wMenuTitleUIFont;

    id selectColor = [self getTitleData:self.param.wTitleArr[i] key:@"titleSelectColor"];
    [btn setTitleColor:selectColor?:self.param.wMenuTitleSelectColor forState:UIControlStateSelected];
    [btn setTitleColor:self.param.wMenuTitleColor forState:UIControlStateNormal];
    btn.tag = i;
    btn.frame = CGRectMake(temp?(CGRectGetMaxX(temp.frame)+self.param.wMenuTitleOffset):0, 0, self.param.wMenuTitleWidth?:(size.width + margin), self.param.wMenuHeight);
    [self addSubview:btn];
    [self.btnArr addObject:btn];
    if (image) {
        [btn TagSetImagePosition:self.param.wMenuImagePosition spacing:self.param.wMenuImageMargin];
    }
    //设置右上角红点
    NSString *badge = [self getTitleData:self.param.wTitleArr[i] key:@"badge"];
    if (badge) {
       [btn showBadgeWithTopMagin:self.param.wTitleArr[i]];
    }
    if (self.param.wMenuPosition != PageMenuPositionNavi) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    //设置富文本
    id wrapColor = [self getTitleData:self.param.wTitleArr[i] key:@"wrapColor"];
    id firstColor = [self getTitleData:self.param.wTitleArr[i] key:@"firstColor"];
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
        btn.attributed = YES;
    }
    //重新设置布局
    if (i == (self.param.wTitleArr.count -1)) {
        if (CGRectGetMaxX(btn.frame) <= self.frame.size.width) {
           self.scrollEnabled = NO;
        }else{
           self.scrollEnabled = YES;
        }
        self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
    }
    if (self.param.wCustomMenuView) {
        self.param.wCustomMenuView(self);
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

//滚动到中间
- (void)scrollToIndex:(NSInteger)newIndex{
    WMZPageNaviBtn *btn = self.btnArr[newIndex] ;
    //隐藏右上角红点
    [btn hidenBadge];
    //改变背景色
    id backgroundColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"backgroundColor"];
    //改变指示器颜色
    id indicatorColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"indicatorColor"];
    //改变其他未选中标题的颜色
    id titleColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"titleColor"];
    
    //改变标题颜色
    
    [self.btnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull temp, NSUInteger idx, BOOL * _Nonnull stop) {
        temp.selected = (temp.tag == newIndex ?YES:NO);
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
        }else{
            [temp setTitleColor:titleColor?:self.param.wMenuTitleColor forState:UIControlStateNormal];
            temp.titleLabel.font = self.param.wMenuTitleUIFont;
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
        [self setContentOffset:point animated:self.first?NO:YES];
    }
    
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
    
    
    if (self.first) {
        self.lineView.frame = lineRect;
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = lineRect;
        } completion:^(BOOL finished) {
            
        }];
    }
        
    self.currentTitleIndex = newIndex;
    if (self.param.wInsertHeadAndMenuBg) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    if (self.param.wCustomMenuSelectTitle) {
        self.param.wCustomMenuSelectTitle(self.btnArr);
    }
}


- (CGFloat)getMainHeight{
    if ((pageIsIphoneX&&self.param.wMenuPosition == PageMenuPositionBottom)) {
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
