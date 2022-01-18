//
//  WMZPageParam.m
//  WMZPageController
//
//  Created by wmz on 2019/9/24.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageParam.h"

WMZPageBTNKey const WMZPageKeyBadge = @"badge";
WMZPageBTNKey const WMZPageKeyName = @"name";
WMZPageBTNKey const WMZPageKeySelectName = @"selectName";
WMZPageBTNKey const WMZPageKeyIndicatorColor = @"indicatorColor";
WMZPageBTNKey const WMZPageKeyTitleColor = @"titleColor";
WMZPageBTNKey const WMZPageKeyTitleSelectColor = @"titleSelectColor";
WMZPageBTNKey const WMZPageKeyBackgroundColor = @"backgroundColor";
WMZPageBTNKey const WMZPageKeyOnlyClick = @"onlyClick";
WMZPageBTNKey const WMZPageKeyOnlyClickWithAnimal = @"onlyAnClick";
WMZPageBTNKey const WMZPageKeyImage = @"image";
WMZPageBTNKey const WMZPageKeySelectImage = @"selectImage";
WMZPageBTNKey const WMZPageKeyTitleWidth = @"width";
WMZPageBTNKey const WMZPageKeyTitleHeight = @"height";
WMZPageBTNKey const WMZPageKeyTitleMarginX = @"marginX" ;
WMZPageBTNKey const WMZPageKeyTitleMarginY = @"y";
WMZPageBTNKey const WMZPageKeyCanTopSuspension = @"canTopSuspension";
WMZPageBTNKey const WMZPageKeyTitleBackground = @"titleBackground";      
WMZPageBTNKey const WMZPageKeyImageOffset = @"margin";

@implementation WMZPageParam
WMZPageParam * PageParam(void){
    return  [WMZPageParam new];
}
WMZPagePropSetFuncImplementation(WMZPageParam, NSArray*,               wTitleArr)
WMZPagePropSetFuncImplementation(WMZPageParam, NSArray*,               wControllers)
WMZPagePropSetFuncImplementation(WMZPageParam, PageTitleMenu,          wMenuAnimal)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wMenuAnimalTitleGradient)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wTapScrollAnimal)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wMenuFixShadow)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wTopSuspension)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wFromNavi)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wNaviAlpha)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wScrollCanTransfer)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wBounces)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wNaviAlphaAll)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wFixFirst)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wLazyLoading)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wHeadScaling)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wHideRedCircle)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wAvoidQuickScroll)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wHeaderScrollHide)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wDeviceChange)
WMZPagePropSetFuncImplementation(WMZPageParam, PagePopType,            wRespondGuestureType)
WMZPagePropSetFuncImplementation(WMZPageParam, BOOL,                   wMenuFollowSliding)
WMZPagePropSetFuncImplementation(WMZPageParam, int,                    wGlobalTriggerOffset)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, PageMenuPosition,       wMenuPosition)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleOffset)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, NSInteger,              wMenuDefaultIndex)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuTitleColor)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuCellMargin)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuTitleSelectColor)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuIndicatorColor)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorRadio)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomFrameY,       wCustomDataViewHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, NSString*,              wMenuIndicatorImage)
WMZPagePropSetFuncImplementation(WMZPageParam, PageBtnPosition,        wMenuImagePosition)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuImageMargin)
WMZPagePropSetFuncImplementation(WMZPageParam, id,                     wMenuFixRightData)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuTitleBackground)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuBgColor)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wBgColor)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuFixWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuCellMarginY)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wTopChangeHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuBottomMarginY)
WMZPagePropSetFuncImplementation(WMZPageParam, PageHeadViewBlock,      wMenuHeadView)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomMenuTitle,    wCustomMenufixTitle)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleWeight)
WMZPagePropSetFuncImplementation(WMZPageParam, PageHeadViewBlock,      wMenuAddSubView)
WMZPagePropSetFuncImplementation(WMZPageParam, PageHeadAndMenuBgView,  wCustomMenuView)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomRedText,      wCustomRedView)
WMZPagePropSetFuncImplementation(WMZPageParam, PageHeadAndMenuBgView,  wInsertHeadAndMenuBg)
WMZPagePropSetFuncImplementation(WMZPageParam, PageHeadAndMenuBgView,  wInsertMenuLine)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomMenuTitle,    wCustomMenuTitle)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomMenuSelectTitle,wCustomMenuSelectTitle)
WMZPagePropSetFuncImplementation(WMZPageParam, PageClickBlock,         wEventFixedClick)
WMZPagePropSetFuncImplementation(WMZPageParam, PageClickBlock,         wEventClick)
WMZPagePropSetFuncImplementation(WMZPageParam, PageVCChangeBlock,      wEventBeganTransferController)
WMZPagePropSetFuncImplementation(WMZPageParam, PageVCChangeBlock,      wEventEndTransferController)
WMZPagePropSetFuncImplementation(WMZPageParam, PageChildVCScroll,      wEventChildVCDidSroll)
WMZPagePropSetFuncImplementation(WMZPageParam, PageMenuChangeHeight,   wEventMenuChangeHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, PageMenuNormalHeight,   wEventMenuNormalHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, PageViewControllerIndex,wViewController)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomFrameY,       wCustomNaviBarY)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomFrameY,       wCustomTabbarY)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wCustomDataViewTopOffset)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorY)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuCircilRadio)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, UIFont*,                wMenuTitleUIFont)
WMZPagePropSetFuncImplementation(WMZPageParam, UIFont*,                wMenuTitleSelectUIFont)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuSelectTitleBackground)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleRadios)
WMZPagePropSetFuncImplementation(WMZPageParam, PageFailureGestureRecognizer,wCustomFailGesture)
WMZPagePropSetFuncImplementation(WMZPageParam, PageSimultaneouslyGestureRecognizer,wCustomSimultaneouslyGesture)
WMZPagePropSetFuncImplementation(WMZPageParam, PageJDAnimalBlock,      wEventCustomJDAnimal)
WMZPagePropSetFuncImplementation(WMZPageParam, UIEdgeInsets,           wMenuInsets)
- (instancetype)init{
    if (self = [super init]) {
        _wMenuAnimal = PageTitleMenuNone;
        _wMenuTitleColor = PageColor(0x333333);
        _wMenuTitleSelectColor = PageColor(0xE5193E);
        _wMenuIndicatorColor = PageColor(0xE5193E);
        _wMenuBgColor = PageColor(0xffffff);
        _wMenuIndicatorHeight = 3.1;
        _wMenuWidth = PageVCWidth;
        _wMenuAnimalTitleGradient = YES;
        _wMenuTitleUIFont = [UIFont systemFontOfSize:17.0f];
        _wMenuTitleSelectUIFont = [UIFont systemFontOfSize:18.5f];
        _wMenuImagePosition = PageBtnPositionTop;
        _wMenuImageMargin = 5.0f;
        _wMenuCellMargin = 30.0f;
        _wMenuFixWidth = 45.0f;
        _wMenuFixShadow = YES;
        _wFromNavi = YES;
        _wScrollCanTransfer = YES;
        _wBgColor = PageColor(0xffffff);
        _wMenuHeight = 55.0f;
        _wLazyLoading = YES;
        _wMenuInsets = UIEdgeInsetsZero;
        _wHideRedCircle = YES;
        _wMenuFollowSliding = YES;
        _wCustomDataViewTopOffset = PageVCStatusBarHeight;
        _wHeaderScrollHide = YES;
        _wRespondGuestureType = PagePopFirst;
        _wGlobalTriggerOffset = UIScreen.mainScreen.bounds.size.width * 0.15;
        _wDeviceChange = YES;
    }
    return self;
}

- (void)defaultProperties{
    if (self.wMenuAnimal == PageTitleMenuAiQY && !self.wMenuIndicatorWidth) self.wMenuIndicatorWidth = 20;
    if (self.wMenuAnimal == PageTitleMenuNone||
        self.wMenuAnimal == PageTitleMenuCircleBg||
        self.wMenuAnimal == PageTitleMenuCircle||
        self.wMenuAnimal == PageTitleMenuPDD) self.wMenuAnimalTitleGradient = NO;
    if (self.wMenuAnimal == PageTitleMenuPDD && !self.wMenuIndicatorWidth) self.wMenuIndicatorWidth = 25;
    if (self.wMenuAnimal == PageTitleMenuCircle) {
        if (CGColorEqualToColor(self.wMenuIndicatorColor.CGColor, PageColor(0xE5193E).CGColor))  self.wMenuIndicatorColor = PageColor(0xe1f9fe);
        if (CGColorEqualToColor(self.wMenuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor)) self.wMenuTitleSelectColor = PageColor(0x00baf9);
        if (self.wMenuIndicatorHeight <= 15.0f)  self.wMenuIndicatorHeight = 0;
    }else if (self.wMenuAnimal == PageTitleMenuCircleBg) {
        if (CGColorEqualToColor(self.wMenuSelectTitleBackground.CGColor, [UIColor clearColor].CGColor) || !self.wMenuSelectTitleBackground)
            self.wMenuSelectTitleBackground = [UIColor orangeColor];
        if (CGColorEqualToColor(self.wMenuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor))  self.wMenuTitleSelectColor = [UIColor whiteColor];
        if (!self.wMenuCellMarginY)  self.wMenuCellMarginY = 10.f;
        if (!self.wMenuBottomMarginY)  self.wMenuBottomMarginY = 10.f;
        if (UIEdgeInsetsEqualToEdgeInsets(self.wMenuInsets, UIEdgeInsetsZero)) {
            self.wMenuInsets = UIEdgeInsetsMake(self.wMenuCellMarginY, 0, self.wMenuBottomMarginY, 0);
        }
    }
    if (self.wMenuPosition == PageMenuPositionNavi) {
        if (CGColorEqualToColor(self.wMenuBgColor.CGColor, PageColor(0xffffff).CGColor)) self.wMenuBgColor = [UIColor clearColor];
        if (self.wMenuHeight >= 55.0f) self.wMenuHeight = 40.0f;
    }
}

@end
