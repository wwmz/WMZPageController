//
//  WMZPageView.h
//  WMZPageController
//
//  Created by wmz on 2021/10/20.
//  Copyright © 2021 wmz. All rights reserved.
//
#import "WMZPageScrollProcotol.h"

@protocol WMZPageViewProtocol <NSObject>
- (UIResponder*_Nonnull)parentResponderType;
@end

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageView : UIView<WMZPageScrollProcotol>
/// 响应父类
@property (nonatomic, weak, readonly) UIResponder *parentResponder;
/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                        param:(WMZPageParam*)param
               parentReponder:(UIResponder*)parentReponder;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                        param:(WMZPageParam*)param
               parentReponder:(UIResponder*)parentReponder;
@end

NS_ASSUME_NONNULL_END
