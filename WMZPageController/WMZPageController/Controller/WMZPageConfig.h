//
//  WMZPageConfig.h
//  WMZPageController
//
//  Created by wmz on 2019/9/17.
//  Copyright © 2019 wmz. All rights reserved.
//

#ifndef WMZPageConfig_h
#define WMZPageConfig_h

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "WMZPageProtocol.h"
#import "NSObject+SafeKVO.h"
#import "UIView+PageRect.h"
@class WMZPageNaviBtn;
#define   PageVCWidth   [UIScreen mainScreen].bounds.size.width
#define   PageVCHeight  [UIScreen mainScreen].bounds.size.height

#define myHeight 100

#define PageDarkColor(light,dark)    \
({\
    UIColor *wMenuIndicator = nil; \
    if (@available(iOS 13.0, *)) {  \
        wMenuIndicator = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) { \
        if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {  \
            return light;  \
        }else {   \
            return dark;  \
        }}];  \
    }else{  \
        wMenuIndicator = light;  \
    }   \
    (wMenuIndicator); \
})\

#define PageColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define PageK1px (1 / UIScreen.mainScreen.scale)

#define  PageVCIS_iPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size)  || CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size))
//状态栏高度
#define PageVCStatusBarHeight (PageVCIS_iPhoneX ? 44.f : 20.f)
//导航栏高度
#define PageVCNavBarHeight (44.f+PageVCStatusBarHeight)
//底部标签栏高度
#define PageVCTabBarHeight (PageVCIS_iPhoneX ? (49.f+34.f) : 49.f)

#define PageWindow   [UIApplication sharedApplication].keyWindow

#define pageIsIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})


#define WMZPagePropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define WMZPagePropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}

typedef enum :NSInteger{
    PageBtnPositionLeft     = 0,            //图片在左，文字在右，默认
    PageBtnPositionRight    = 1,            //图片在右，文字在左
    PageBtnPositionTop      = 2,            //图片在上，文字在下
    PageBtnPositionBottom   = 3,            //图片在下，文字在上
}PageBtnPosition;

typedef enum :NSInteger{
    PageSpecialTypeOne     = 1,          //菜单栏可见底部子视图
}PageSpecialType;


typedef enum :NSInteger{
    PageTitleMenuNone     = 0,            //无样式
    PageTitleMenuLine     = 1,            //带下划线
    PageTitleMenuCircle   = 2,            //背景圆角框
    PageTitleMenuAiQY     = 3,            //爱奇艺效果(指示器跟随移动)
    PageTitleMenuTouTiao  = 4,            //今日头条效果(变大加颜色渐变)
    PageTitleMenuYouKu    = 5,            //优酷效果(变大字体加粗 指示器圆点 指示器跟随移动)
    PageTitleMenuPDD      = 6,            //拼多多效果(底部线条)
}PageTitleMenu;


typedef enum :NSInteger{
    PageMenuPositionLeft          = 0,            //上左
    PageMenuPositionRight         = 1,            //上右
    PageMenuPositionCenter        = 2,            //居中
    PageMenuPositionNavi          = 3,            //导航栏
    PageMenuPositionBottom        = 4,            //底部
}PageMenuPosition;

//设置阴影
typedef enum :NSInteger{
    PageShadowPathTop,
    PageShadowPathBottom,
    PageShadowPathLeft,
    PageShadowPathRight,
    PageShadowPathCommon,
    PageShadowPathAround
}PageShadowPathType;

//渐变色
typedef enum :NSInteger{
    PageGradientChangeDirectionLevel,                    //水平方向渐变
    PageGradientChangeDirectionVertical,                 //垂直方向渐变
    PageGradientChangeDirectionUpwardDiagonalLine,       //主对角线方向渐变
    PageGradientChangeDirectionDownDiagonalLine,         //副对角线方向渐变
}PageGradientChangeDirection;


/*
 * 点击
 */
typedef void (^PageClickBlock)(id anyID,NSInteger index);

/*
 * 控制器切换
 */
typedef void (^PageVCChangeBlock)(UIViewController* oldVC,UIViewController *newVC,NSInteger oldIndex,NSInteger newIndex);


/*
 * 子控制器滚动
 */
typedef void (^PageChildVCScroll)(UIViewController* pageVC,CGPoint oldPoint,CGPoint newPonit,UIScrollView *currentScrollView);

/*
 * 头视图
 */
typedef UIView* (^PageHeadViewBlock)(void);

/*
 * 固定尾视图
 */
typedef UIView* (^PageFootViewBlock)(void);

/*
 * 头视图和菜单栏的背景层
 */
typedef void (^PageHeadAndMenuBgView)(UIView *bgView);

/*
 * 自定义红点
 */
typedef void (^PageCustomRedText)(UILabel *redLa,NSDictionary *info);

/*
 * 自定义菜单栏
 */
typedef void (^PageCustomMenuTitle)(NSArray *titleArr);


/*
 * 滚动 后改变标题
 */
typedef void (^PageCustomMenuSelectTitle)(NSArray *titleArr);


/*
 * 切换高度block
 */
typedef void (^PageMenuChangeHeight)(NSArray<WMZPageNaviBtn*>*titleArr,CGFloat offset);

/*
 * 恢复原来高度block
 */
typedef void (^PageMenuNormalHeight)(NSArray<WMZPageNaviBtn*>*titleArr);


/*
 * vc数组
 */
typedef UIViewController* (^PageViewControllerIndex)(NSInteger index);

#endif /* WMZPageConfig_h */
