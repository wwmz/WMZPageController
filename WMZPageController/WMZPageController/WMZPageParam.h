///
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
/// 标题数组 必传
/// 可传带字典的数组  key值为WMZPageBTNKey 
typedef NSString *WMZPageBTNKey NS_STRING_ENUM;
// 红点提示  @(YES) 或者 带数字 @(99) @"99+"  wCustomRedView使用这个属性可以调整角标的位置和样式
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyBadge;
/// 标题  NSString/NSAttributedString  支持传入富文本
/// 如果此处传入富文本则WMZPageKeySelectName 也需要传入 此时设置的选中标题title font uicolor会失效
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyName;
/// 选中后标题 NSString/NSAttributedString  支持传入富文本
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeySelectName;
/// 指示器颜色 UIColor
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyIndicatorColor;
/// 字体颜色 UIColor
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleColor;
/// 选中字体颜色 UIColor
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleSelectColor;
/// 图片 NSString/UIImage
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyImage;
/// 选中后图片 NSString/UIImage
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeySelectImage;
/// 选中背景颜色 [UIColor redColor] (如果是数组则是背景色渐变色) @[[UIColor redColor],[UIColor orangeColor]]
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyBackgroundColor;
/// 标题背景颜色 UIColor
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleBackground;
/// 图文距离 @(5)
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyImageOffset;
/// 仅点击页面不加载 @(YES)
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyOnlyClick;
/// 自定义标题宽度(优先级最高)   @(100)
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleWidth;
/// 自定义标题高度(优先级最高)   @(100)
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleHeight;
/// 自定义标题x间距(优先级最高)  @(100)
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleMarginX;
/// 自定义标题y坐标(优先级最高)  @(100)
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyTitleMarginY;
/// 当前子控制器不悬浮固定在顶部  @(NO)  NO表示不悬浮
FOUNDATION_EXPORT WMZPageBTNKey const WMZPageKeyCanTopSuspension;

WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam,NSArray*,              wTitleArr)
/// 1.4.0之后 新增支持UIView 一样用法都是用这个属性 直接传入UIView即可 有警告的话用强转UIViewController
/// VC数据 必传(二选一) 1.1.6新增
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, PageViewControllerIndex,  wViewController)
/// VC数组 必传(二选一) (如果要做标题内容动态增删操作的必须使用此属性 )
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, NSArray*,    wControllers)

/* =========================================required==============================================*/

/* =========================================customFrame===============================================*/

/// 自定义整体距离顶部的位置(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, PageCustomFrameY,        wCustomNaviBarY)
/// 自定义整体距离底部的位置(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, PageCustomFrameY,        wCustomTabbarY)
/// 自定义底部滚动视图的高度(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, PageCustomFrameY,        wCustomDataViewHeight)

/// 自定义Fail手势
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, PageFailureGestureRecognizer,wCustomFailGesture)
/// 自定义Simultaneously手势
WMZPagePropStatementAndPropSetFuncStatement(copy, WMZPageParam, PageSimultaneouslyGestureRecognizer,wCustomSimultaneouslyGesture)

/* =========================================customFrame===============================================*/

/* =========================================special==============================================*/
/// 特殊属性 菜单滑动到顶部悬浮 default NO 需要实现协议
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wTopSuspension)
/// 导航栏透明度变化 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wNaviAlpha)
/// 滑动切换 default YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wScrollCanTransfer)
/// 头部视图frame从导航栏下方开始 default YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wFromNavi)
/// 菜单最右边固定内容是否开启左边阴影 defaulf YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuFixShadow)
/// 开启渐变色 default yes
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuAnimalTitleGradient)
/// 顶部可下拉 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wBounces)
/// 导航栏整个透明 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wNaviAlphaAll)
/// 点击滑动带动画 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wTapScrollAnimal)
/// 特殊属性 固定在所有子控制器的底部 需要在第一个子控制器实现固定底部协议
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wFixFirst)
/// 延迟加载 default YES 延迟了0.1秒 所以在addsubview等操作的时候 需要延迟0.1秒去加载
/// 注意如果此属性为NO 则无法准确获取控制器的显示frame 需要自己调用wCustomNaviBarY/wCustomTabbarY/wCustomDataViewHeight 调试
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wLazyLoading)
/// 头部下拉缩放效果 default NO
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wHeadScaling)
/// 点击隐藏红点 default YES
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wHideRedCircle)
/// 菜单栏跟随滑动 default YES  为NO则视图手势滑动结束菜单栏再滑动  v1.4.1
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wMenuFollowSliding)

/// 悬浮状态下 防止快速滑动的时候直接从底部直接滚动到顶部 default NO v1.4.3
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, BOOL,                  wAvoidQuickScroll)


/// 响应侧滑或者全屏返回手势 default PagePopFirst 首个子视图/子控制器响应  v1.4.1
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PagePopType,           wRespondGuestureType)
/// 全部返回响应手势的位置 wRespondGuestureType为PagePopAll有效 default pageWidth * 0.15  v1.4.1
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, int,                   wGlobalTriggerOffset)

/* =========================================special==============================================*/


/* =========================================Menu==================================================*/
/// 菜单栏高度 default 60
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,                  wMenuHeight)
/// 给菜单栏和headView加个背景层 default -
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadAndMenuBgView,    wInsertHeadAndMenuBg)
/// 给菜单栏加个下划线 default -
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadAndMenuBgView,    wInsertMenuLine)
/// 自定义菜单栏 default -
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadAndMenuBgView,    wCustomMenuView)
/// 自定义菜单右上角红点
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomRedText,        wCustomRedView)
/// 自定义菜单栏上的标题
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomMenuTitle,      wCustomMenuTitle)
/// 自定义选中后菜单栏上的标题
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomMenuSelectTitle,wCustomMenuSelectTitle)
/// 自定义固定标题
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageCustomMenuTitle,      wCustomMenufixTitle)
/// 头部视图 default nil
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadViewBlock,     wMenuHeadView)
/// 菜单栏底部携带自定义视图 default nil  v1.4.3
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageHeadViewBlock,     wMenuAddSubView)
/// 默认选中 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, NSInteger,             wMenuDefaultIndex)
/// 菜单最右边固定内容 default nil (可传字符串/字典/数组)
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, id,                    wMenuFixRightData)
/// 菜单最右边固定内容宽度 defaulf 45
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuFixWidth)
/// 菜单标题动画效果 default  PageTitleMenuMove
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageTitleMenu,         wMenuAnimal)
/// 菜单宽度 default 屏幕宽度
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuWidth)
/// 菜单背景颜色 default ffffff
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuBgColor)
/// 整体视图背景颜色 default ffffff
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wBgColor)
/// 菜单标题左右内边距 default 20
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCellMargin)

/// 菜单按钮距离顶部的y值 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCellMarginY)
/// 菜单按钮距离底部部的y值 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuBottomMarginY)
/// 1.4.0新增 菜单外边距  default  zero top可替代 wMenuCellMarginY  bottom可替代 wMenuBottomMarginY 优先级最大
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, UIEdgeInsets,          wMenuInsets)

/// 菜单的位置 default PageMenuPositionLeft
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageMenuPosition,      wMenuPosition)
/// 菜单标题左右间距 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleOffset)
/// 菜单标题字体 default [UIFont 15]
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIFont*,               wMenuTitleUIFont)
/// 菜单标题字体 default [UIFont wMenuTitleFont+1.5]
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIFont*,               wMenuTitleSelectUIFont)
/// 菜单标题固定宽度 default 文本内容宽度+wMenuCellMargin
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleWidth)
/// 菜单标题字体粗体 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleWeight)
/// 菜单字体颜色 default 333333
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuTitleColor)
/// 菜单字体选中颜色 default E5193E
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuTitleSelectColor)
/// 菜单图文位置 default PageBtnPositionTop
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, PageBtnPosition,       wMenuImagePosition)
/// 菜单图文位置间距 default 5
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuImageMargin)
/// 背景圆圈的圆角 默认高度的一半
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuCircilRadio)
/// 菜单标题背景颜色 default nil
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuTitleBackground)
/// 菜单标题选中背颜色 default nil
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuSelectTitleBackground)
/// 菜单标题圆角 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuTitleRadios)

/// 指示器颜色 default E5193E
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, UIColor*,              wMenuIndicatorColor)
/// 指示器宽度 default 标题宽度+10
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorWidth)
/// 指示器图片 default nil
WMZPagePropStatementAndPropSetFuncStatement(strong, WMZPageParam, NSString*,             wMenuIndicatorImage)
/// 指示器高度 default k1px
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorHeight)
/// 指示器圆角 default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorRadio)
/// 指示器距离按钮的y值(AQY) default 5
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wMenuIndicatorY)


/* =========================================Menu===============================================*/

/* =========================================Events==================================================*/
WMZPageParam * PageParam(void);
/// 右边固定标题点击
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageClickBlock,        wEventFixedClick)

/// 标题点击
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageClickBlock,        wEventClick)
/// 控制器开始切换
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageVCChangeBlock,     wEventBeganTransferController)
/// 控制器结束切换
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageVCChangeBlock,     wEventEndTransferController)
/// 子控制器滚动(做滚动时候自己的操作)  =>开启悬浮有效
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageChildVCScroll,     wEventChildVCDidSroll)

/// 自定义京东动画frame
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageJDAnimalBlock,     wEventCustomJDAnimal)

/* =========================================Events==================================================*/

/* =========================================changeMenu===============================================*/

/// 滑动到顶部改变菜单栏的高度 可传入正负值 改变的高度为当前的titleHeight+传入wTopChangeHeight default 0
WMZPagePropStatementAndPropSetFuncStatement(assign, WMZPageParam, CGFloat,               wTopChangeHeight)
/// 改变高度的block 可在此做标题的操作
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageMenuChangeHeight,  wEventMenuChangeHeight)
/// 恢复原来高度的block 可在此做标题的操作
WMZPagePropStatementAndPropSetFuncStatement(copy,   WMZPageParam, PageMenuNormalHeight,  wEventMenuNormalHeight)

/* =========================================changeMenu===============================================*/



@end

NS_ASSUME_NONNULL_END
