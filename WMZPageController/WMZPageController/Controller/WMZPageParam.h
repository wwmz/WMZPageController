//
//  WMZPageParam.h
//  WMZPageController
//
//  Created by wmz on 2019/9/24.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageParam : NSObject

/* =========================================required==============================================*/
//标题数组 必传
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, NSArray*,              wTitleArr)
//VC数组 必传
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, NSArray*,              wControllers)
/* =========================================required==============================================*/

/* =========================================special==============================================*/
//特殊属性 菜单滑动到顶部悬浮 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wTopSuspension)
//导航栏透明度变化 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wNaviAlpha)
//头部视图frame从导航栏下方开始 default YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wFromNavi)
//菜单最右边固定内容是否开启左边阴影 defaulf YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuFixShadow)
//选中变大 default yes
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuAnimalTitleBig)
//开启渐变色 default yes
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuAnimalTitleGradient)
/* =========================================special==============================================*/

/* =========================================Menu==================================================*/
//默认选中 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, NSInteger,             wMenuDefaultIndex)
//菜单最右边固定内容 default nil
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, id,                    wMenuFixRightData)
//菜单最右边固定内容宽度 defaulf 45
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuFixWidth)
//菜单标题动画效果 default  PageTitleMenuMove
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageTitleMenu,         wMenuAnimal)
//头部视图 default nil
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadViewBlock,     wMenuHeadView)
//菜单宽度 default 屏幕宽度
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuWidth)
//菜单背景颜色 default ffffff
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuBgColor)
//菜单按钮的左右间距 default 20
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCellMargin)
//菜单按钮的上下间距 default 20 (可根据此属性改变导航栏的高度)
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCellPadding)
//菜单的位置 default PageMenuPositionLeft
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageMenuPosition,      wMenuPosition)
//菜单标题左右间距 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleOffset)
//菜单标题字体 default 15.0f
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleFont)
//菜单标题固定宽度 default 文本内容宽度+wMenuCellMargin
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleWidth)
//菜单标题字体粗体 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleWeight)
//菜单字体颜色 default 333333
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuTitleColor)
//菜单字体选中颜色 default E5193E
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuTitleSelectColor)
//菜单图文位置 default PageBtnPositionTop
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageBtnPosition,       wMenuImagePosition)
//菜单图文位置间距 default 5
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuImageMargin)
//指示器颜色 default E5193E
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuIndicatorColor)
//指示器宽度 default 标题宽度+10
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorWidth)
//指示器图片 default nil
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, NSString*,             wMenuIndicatorImage)
//指示器高度 default k1px
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorHeight)
//指示器圆角 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorRadio)
/* =========================================Menu===============================================*/

/* =========================================Events==================================================*/
WMZPageParam * PageParam(void);
//右边固定标题点击
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageClickBlock,        wEventFixedClick)
//标题点击
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageClickBlock,        wEventClick)
//控制器开始切换
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageVCChangeBlock,     wEventBeganTransferController)
//控制器结束切换
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageVCChangeBlock,     wEventEndTransferController)
//子控制器滚动(做滚动时候自己的操作)  =>开启悬浮有效
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageChildVCScroll,     wEventChildVCDidSroll)
/* =========================================Events==================================================*/



@end

NS_ASSUME_NONNULL_END
