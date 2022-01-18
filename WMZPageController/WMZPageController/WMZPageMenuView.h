//
//  WMZPageMenuView.h
//  WMZPageController
//
//  Created by wmz on 2020/10/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageNaviBtn.h"
NS_ASSUME_NONNULL_BEGIN

@protocol WMZPageMunuDelegate <NSObject>

@optional
/// 标题点击
- (void)titleClick:(WMZPageNaviBtn*)btn fix:(BOOL)fixBtn;

@end

@interface WMZPageMenuView : UIScrollView
/// 当前index
@property (nonatomic, assign) NSInteger currentTitleIndex;
/// 配置
@property (nonatomic, strong) WMZPageParam *param;
/// 下划线
@property (nonatomic, strong) WMZPageNaviBtn *lineView;
/// 下划线
@property (nonatomic, strong) UIView *containView;
/// 标题按钮
@property (nonatomic, strong) NSMutableArray <WMZPageNaviBtn*>*btnArr;
/// 固定按钮
@property (nonatomic, strong) NSMutableArray <WMZPageNaviBtn*>*fixBtnArr;
/// 代理
@property (nonatomic, weak) id <WMZPageMunuDelegate> menuDelegate;
/// 上次选中左侧标题
@property (nonatomic, strong, nullable) WMZPageNaviBtn *lastBTN;
////  上次选中右侧固定标题
@property (nonatomic, strong, nullable) WMZPageNaviBtn *fixLastBtn;
/// 最底部下划线
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) CGFloat pageWidth;
/// 滚动到index
/// @param animal 带动画
- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal;
/// 设置默认选中
- (void)setDefaultSelect:(NSInteger)index;
/// 获取菜单高度
- (CGFloat)getMainHeight;
/// 设置标题
- (void)setPropertiesWithBtn:(WMZPageNaviBtn*)btn withIndex:(NSInteger)i  withTemp:(WMZPageNaviBtn*)temp;
/// 重置contensize
- (void)resetMainViewContenSize:(WMZPageNaviBtn*)btn;
/// updateUI
- (void)updateUI;
/// 动画管理
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset;
/// 设置右边固定标题
- (void)setUpFixRightBtn:(WMZPageNaviBtn*)temp;
@end

NS_ASSUME_NONNULL_END
