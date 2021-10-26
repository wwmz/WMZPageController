//
//  WMZPageScroller.h
//  WMZPageController
//
//  Created by wmz on 2019/9/20.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageScroller : UITableView <UIGestureRecognizerDelegate>
/// 能否滚动
@property (nonatomic, assign) BOOL canScroll;
/// 当前滚动子视图
@property (nonatomic, strong) UIScrollView* currentScroll;
/// 子视图能否滚动
@property (nonatomic, assign) BOOL sonCanScroll;
/// 自定义手势
@property (nonatomic,   copy) PageFailureGestureRecognizer wCustomFailGesture;
/// 自定义手势
@property (nonatomic,   copy) PageSimultaneouslyGestureRecognizer wCustomSimultaneouslyGesture;
/// wTopSuspension
@property (nonatomic, assign) BOOL wTopSuspension;
@end

NS_ASSUME_NONNULL_END
