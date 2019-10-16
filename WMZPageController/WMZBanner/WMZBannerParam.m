//
//  WMZBannerParam.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerParam.h"

@implementation WMZBannerParam

WMZBannerPropSetFuncImplementation(WMZBannerParam, CGRect,                        wFrame)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSArray*,                      wData)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wScaleFactor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wEffect)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wActiveDistance)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGSize,                        wItemSize)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wLineSpacing)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wContentOffsetX)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerCellPosition,            wPosition)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wPlaceholderImage)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wImageFill)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wScale)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wRepeat)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSInteger,                     wSelectIndex)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wMyCellClassName)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerCellCallBlock,           wMyCell)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerClickBlock,              wEventClick)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIColor*,                      wBannerControlColor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIColor*,                      wBannerControlSelectColor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wBannerControlImage)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wBannerControlSelectImage)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGSize,                        wBannerControlImageSize)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGSize,                        wBannerControlSelectImageSize)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wAutoScroll)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wAutoScrollSecond)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wHideBannerControl)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wCanFingerSliding)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wBannerControlImageRadius)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIEdgeInsets,                  wSectionInset)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIScrollViewDecelerationRate,  wDecelerationRate)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerControlPosition,         wBannerControlPosition)
WMZBannerParam * BannerParam(void){
    return  [WMZBannerParam new];
}

- (instancetype)init{
    if (self = [super init]) {
        _wScaleFactor = 0.5f;
        _wLineSpacing = 0.0f;
        _wContentOffsetX = 0.5f;
        _wAutoScrollSecond = 3.0f;
        _wPosition = BannerCellPositionCenter;
        _wActiveDistance = 400.0f;
        _wScale = NO;
        _wRepeat = NO;
        _wSelectIndex = 0;
        _wImageFill = YES;
        _wBannerControlColor = [UIColor whiteColor];
        _wBannerControlSelectColor = [UIColor orangeColor];
        _wBannerControlImageSize = CGSizeMake(10, 10);
        _wBannerControlSelectImageSize = CGSizeMake(10, 10);
        _wAutoScrollSecond = 3;
        _wCanFingerSliding = YES;
        _wSectionInset = UIEdgeInsetsMake(0,0, 0, 0);
        _wDecelerationRate = 0.1;
    }
    return self;
}

@end
