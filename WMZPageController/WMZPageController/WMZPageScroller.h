//
//  WMZPageScroller.h
//  WMZPageController
//
//  Created by wmz on 2019/9/20.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZPageConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZPageScroller : UITableView <UIGestureRecognizerDelegate>
/// 菜单高度
@property (nonatomic, assign) CGFloat menuTitleHeight;
/// 能否滚动
@property (nonatomic, assign) BOOL canScroll;
/// 当前滚动子视图
@property (nonatomic, strong) UIScrollView* currentScroll;
/// 是否从导航栏开始
@property (nonatomic, assign) BOOL wFromNavi;
/// 自定义手势
@property (nonatomic,   copy) PageFailureGestureRecognizer wCustomFailGesture;
/// 自定义手势
@property (nonatomic,   copy) PageSimultaneouslyGestureRecognizer wCustomSimultaneouslyGesture;

@end

NS_ASSUME_NONNULL_END
