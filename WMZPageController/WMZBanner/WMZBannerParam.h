//
//  WMZBannerParam.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerParam : NSObject
/* =========================================Attributes==========================================*/

//布局方式 frame  必传
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGRect,               wFrame)
//数据源 必传
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, NSArray*,             wData)
//开启缩放 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wScale)
//背景毛玻璃效果 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wEffect)
//整体间距 默认UIEdgeInsetsMake(0,0, 0, 0)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, UIEdgeInsets,         wSectionInset)
//缩放系数 数值越大缩放越大 default 0.5
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wScaleFactor)
//垂直缩放 数值越大缩放越小 default 400
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wActiveDistance)
//item的size default 视图的宽高 item的width最小为父视图的一半 (为了保证同屏最多显示3个 减少不必要的bug)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGSize,               wItemSize)
//item的之间的间距 default 0
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wLineSpacing)
//滑动的时候偏移的距离 以倍数计算 default 0.5 正中间
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wContentOffsetX)
//左右相邻item的中心点 default BannerCellPositionCenter
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BannerCellPosition,   wPosition)
//图片不变形铺满 默认 YES
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wImageFill)
//占位图片 默认 -
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wPlaceholderImage)
//开启无线滚动 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wRepeat)
//开启自动滚动 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wAutoScroll)
//滚动减速时间 default UIScrollViewDecelerationRateFast
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, UIScrollViewDecelerationRate,wDecelerationRate)
//自动滚动间隔时间 default 3.0f
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wAutoScrollSecond)
//默认移动到第几个 default 0
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, NSInteger,            wSelectIndex)
//自定义cell内容 默认是Collectioncell类
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerCellCallBlock,  wMyCell)
//自定义cell的类名 自定义视图必传 不然会crash
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wMyCellClassName)
//隐藏pageControl default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wHideBannerControl)
//是否允许手势滑动 default YES
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wCanFingerSliding)
//系统的圆点颜色  default  ffffff
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, UIColor*,             wBannerControlColor)
//系统的圆点选中颜色  default  orange
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, UIColor*,             wBannerControlSelectColor)
//自定义安全的圆点图标  default -
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wBannerControlImage)
//自定义安全的选中圆点图标  default -
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wBannerControlSelectImage)
//自定义安全的圆点图片圆角 default ImageSize/2
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wBannerControlImageRadius)
//自定义安全的圆点图标的size  default (5,5)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGSize,               wBannerControlImageSize)
//自定义安全的选中圆点图标的size (10,5)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGSize,               wBannerControlSelectImageSize)
//pageControl的位置 default BannerControlCenter
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BannerControlPosition,wBannerControlPosition)
/* =========================================Attributes==========================================*/

/* =========================================Events==============================================*/
WMZBannerParam * BannerParam(void);
//点击方法
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerClickBlock,     wEventClick)
/* =========================================Events==============================================*/

/* =========================================custom==============================================*/
@property(nonatomic,assign)NSInteger myCurrentPath;
/* =========================================custom==============================================*/

@end

NS_ASSUME_NONNULL_END
