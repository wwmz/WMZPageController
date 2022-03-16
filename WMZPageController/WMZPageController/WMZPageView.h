//
//  WMZPageView.h
//  WMZPageController
//
//  Created by wmz on 2021/10/20.
//  Copyright © 2021 wmz. All rights reserved.
//
#import "WMZPageScrollProcotol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageView : UIView<WMZPageScrollProcotol>
/// 响应父类
@property (nonatomic, weak, readonly) UIResponder *parentResponder;
/// 私有方法 不可调用
- (void)setUpUI:(BOOL)clear;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                        param:(WMZPageParam*)param
               parentReponder:(UIResponder*)parentReponder;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                        param:(WMZPageParam*)param
               parentReponder:(UIResponder*)parentReponder;

/// 初始化 仅供兼容WMZPageController类调用
- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                       source:(BOOL)pageController
                        param:(WMZPageParam*)param
               parentReponder:(UIResponder*)parentReponder;
@end

NS_ASSUME_NONNULL_END
