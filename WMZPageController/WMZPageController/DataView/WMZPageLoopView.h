//
//  WMZPageLoopView.h
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageConfig.h"
#import "WMZPageScroller.h"
#import "WMZPageDataView.h"
#import "WMZPageMunuView.h"
#import "WMZPageTitleDataModel.h"
@class WMZPageController;
NS_ASSUME_NONNULL_BEGIN

@protocol WMZPageLoopDelegate <NSObject>
@optional

//选中按钮
- (void)selectBtnWithIndex:(NSInteger)index;

//底部左滑的代理
- (void)pageWithScrollView:(UIScrollView*)scrollView left:(BOOL)left;

//底部左滑结束的代理
- (void)pageScrollEndWithScrollView:(UIScrollView*)scrollView;

//获取子tableview
- (void)setUpSuspension:(UIViewController*)newVC index:(NSInteger)index end:(BOOL)end;
@end

@interface WMZPageLoopView : UIView

//下划线 此列属性和pageMenuView中的是同个
@property(nonatomic,strong)UIButton *lineView;
//标题按钮
@property(nonatomic,strong)NSMutableArray <WMZPageNaviBtn*>*btnArr;
//固定按钮
@property(nonatomic,strong)NSMutableArray <WMZPageNaviBtn*>*fixBtnArr;


//菜单视图
@property(nonatomic,strong)WMZPageMunuView *mainView;
//底部视图
@property(nonatomic,strong)WMZPageDataView *dataView;
//当前index
@property(nonatomic,assign)NSInteger currentTitleIndex;
//可能的下一个视图
@property(nonatomic,assign)NSInteger nextPageIndex;
//上一个视图
@property(nonatomic,assign)NSInteger lastPageIndex;
//是否已经处理了生命周期
@property(nonatomic,assign)BOOL hasDealAppearance;
//是否已经运行了完整的生命周期
@property(nonatomic,assign)BOOL hasEndAppearance;
//是否往相反方向滑动
@property(nonatomic,assign)BOOL hasDifferenrDirection;
//当前显示VC
@property(nonatomic,strong,nullable)UIViewController *currentVC;
//代理
@property(nonatomic,weak)id <WMZPageLoopDelegate> loopDelegate;

//初始化
- (instancetype)initWithFrame:(CGRect)frame param:(WMZPageParam*)param;

//标题动画和scrollview联动
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset;

//结束动画处理
- (void)endAninamal;

//找寻view的父控制器
- (nullable WMZPageController *)findBelongViewControllerForView:(UIView *)view;

//添加
- (void)addChildVC:(NSInteger)index VC:(UIViewController*)newVC;
@end

NS_ASSUME_NONNULL_END
