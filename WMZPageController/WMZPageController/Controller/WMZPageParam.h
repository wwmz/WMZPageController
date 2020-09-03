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
//VC数组 (已废弃)
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, NSArray*,              wControllers)
//VC数据 必传 1.1.6新增
WMZPagePropStatementAndPropSetFuncStatement(copy,  WMZPageParam,  PageViewControllerIndex,              wViewController)

/* =========================================required==============================================*/

/* =========================================special==============================================*/
//特殊属性 菜单滑动到顶部悬浮 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wTopSuspension)
//导航栏透明度变化 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wNaviAlpha)
//滑动切换 default YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wScrollCanTransfer)
//头部视图frame从导航栏下方开始 default YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wFromNavi)
//菜单最右边固定内容是否开启左边阴影 defaulf YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuFixShadow)
//选中变大 default yes
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuAnimalTitleBig)
//开启渐变色 default yes
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuAnimalTitleGradient)
//顶部可下拉 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wBounces)
//导航栏整个透明 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wNaviAlphaAll)
//特殊属性 固定在所有子控制器的底部 需要在第一个子控制器实现固定底部协议
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wFixFirst)

/* =========================================special==============================================*/

/* =========================================other==================================================*/
//如果滚动的时候偏移量无法吸顶到想要的位置 可以修改此属性(传入正数或者负数) 具体为当前的topOffset + 此wTopOffset 比如传入wTopOffsetSet(-NaviBarHeight) 则偏移量减少了一个导航栏的高度
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wTopOffset)
/* =========================================Menu==================================================*/

/* =========================================Menu==================================================*/
//导航栏颜色 default 默认颜色 如果出现导航栏颜色不准确可以调用此属性设置
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wNaviColor)
//给菜单栏和headView加个背景层 default -
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadAndMenuBgView,                  wInsertHeadAndMenuBg)
//给菜单栏加个下划线 default -
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadAndMenuBgView,                  wInsertMenuLine)
//自定义菜单栏 default -
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadAndMenuBgView,                  wCustomMenuView)
//自定义菜单右上角红点
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomRedText,                  wCustomRedView)
//自定义菜单栏上的标题
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomMenuTitle,                  wCustomMenuTitle)
//自定义选中后菜单栏上的标题
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomMenuSelectTitle,wCustomMenuSelectTitle)
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
//菜单按钮的上下间距 default 20 (可根据此属性改变菜单栏的高度)
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCellPadding)
//菜单按钮距离顶部的y值 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCellMarginY)
//菜单的位置 default PageMenuPositionLeft
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageMenuPosition,      wMenuPosition)
//菜单标题左右间距 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleOffset)
//菜单标题字体 default 17.0f (已废弃)
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleFont)
//菜单选中标题字体大小 default wMenuTitleFont+1.5  (已废弃)
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleSelectFont)
//菜单标题字体 default [UIFont 15]
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIFont*,               wMenuTitleUIFont)
//菜单标题字体 default [UIFont wMenuTitleFont+1.5]
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIFont*,               wMenuTitleSelectUIFont)
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
//指示器距离按钮的y值(AQY) default 菜单视图的高度-指示器高度-4/wMenuCellPadding
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorY)
//背景圆圈的圆角 默认高度的一半
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCircilRadio)

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


/* =========================================special==================================================*/
//特殊样式实际demo 实际效果看demo
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageSpecialType,       wMenuSpecifial)
/* =========================================special==================================================*/


/* =========================================changeMenu===============================================*/

//滑动到顶部改变菜单栏的高度 可传入正负值 改变的高度为当前的titleHeight+传入wTopChangeHeight default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wTopChangeHeight)

//改变高度的block 可在此做标题的操作
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageMenuChangeHeight,  wEventMenuChangeHeight)

//恢复原来高度的block 可在此做标题的操作
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageMenuNormalHeight,  wEventMenuNormalHeight)


/* =========================================changeMenu===============================================*/


/* =========================================开放的属性==================================================*/
//标题高度
@property(nonatomic,assign)CGFloat titleHeight;


@end

NS_ASSUME_NONNULL_END
