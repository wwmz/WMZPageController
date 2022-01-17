//
//  WMZPageDataView.h
//  WMZPageController
//
//  Created by wmz on 2020/9/27.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageDataView : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) BOOL left;

@property (nonatomic, assign) CGFloat pageWidth;
/// 触发侧滑手势
@property (nonatomic, assign) CGFloat popGuestureOffset;
/// respondGuestureType为All时候的响应位置
@property (nonatomic, assign) int globalTriggerOffset;
///响应侧滑/全屏手势
@property (nonatomic, assign) PagePopType respondGuestureType;

@end

NS_ASSUME_NONNULL_END
