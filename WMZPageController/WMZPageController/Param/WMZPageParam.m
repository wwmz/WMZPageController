//
//  WMZPageParam.m
//  WMZPageController
//
//  Created by wmz on 2019/9/24.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageParam.h"

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
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, PageMenuPosition,       wMenuPosition)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleOffset)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, NSInteger,              wMenuDefaultIndex)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuTitleColor)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuCellMargin)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuCellPadding)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuTitleSelectColor)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuIndicatorColor)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorWidth)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorRadio)
WMZPagePropSetFuncImplementation(WMZPageParam, PageCustomFrameY,       wCustomDataViewHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, NSString*,              wMenuIndicatorImage)
WMZPagePropSetFuncImplementation(WMZPageParam, PageBtnPosition,        wMenuImagePosition)
WMZPagePropSetFuncImplementation(WMZPageParam, PageSpecialType,        wMenuSpecifial)
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
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuIndicatorY)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuCircilRadio)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuHeight)
WMZPagePropSetFuncImplementation(WMZPageParam, UIFont*,                wMenuTitleUIFont)
WMZPagePropSetFuncImplementation(WMZPageParam, UIFont*,                wMenuTitleSelectUIFont)
WMZPagePropSetFuncImplementation(WMZPageParam, UIColor*,               wMenuSelectTitleBackground)
WMZPagePropSetFuncImplementation(WMZPageParam, CGFloat,                wMenuTitleRadios)
- (instancetype)init{
    if (self = [super init]) {
        _wMenuAnimal = PageTitleMenuNone;
        _wMenuTitleColor = PageColor(0x333333);
        _wMenuTitleSelectColor = PageColor(0xE5193E);
        _wMenuIndicatorColor = PageColor(0xE5193E);
        _wMenuBgColor = PageColor(0xffffff);
        _wMenuIndicatorHeight = 3.0f;
        _wMenuWidth = PageVCWidth;
        _wMenuAnimalTitleGradient = YES;
        _wMenuTitleUIFont = [UIFont systemFontOfSize:17.0f];
        _wMenuTitleSelectUIFont = [UIFont systemFontOfSize:18.5f];
        _wMenuImagePosition = PageBtnPositionTop;
        _wMenuImageMargin = 5.0f;
        _wMenuCellMargin = 30.0f;
        _wMenuCellPadding = 30.0f;
        _wMenuFixWidth = 45.0f;
        _wMenuFixShadow = YES;
        _wFromNavi = YES;
        _wScrollCanTransfer = YES;
        _wBgColor = PageColor(0xffffff);
        _wMenuHeight = 55.0f;
        _wLazyLoading = YES;
        _wMenuTitleBackground = [UIColor clearColor];
        _wMenuSelectTitleBackground = [UIColor clearColor];
    }
    return self;
}

@end
