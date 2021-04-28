//
//  WMZPageController.h
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//


#import "WMZPageLoopView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZPageController : UIViewController<UIScrollViewDelegate,WMZPageLoopDelegate,UITableViewDelegate>
/*
*参数
*/
@property(nonatomic,strong)WMZPageParam *param;
/*
*头部标题滚动视图
*/
@property(nonatomic,strong)WMZPageLoopView *upSc;
/*
*底部全屏滚动视图
*/
@property(nonatomic,strong,nullable)WMZPageScroller *downSc;
/*
*缓存
*/
@property(nonatomic,strong)NSMutableDictionary *cache;
/*
*子控制器中可以滚动的视图
*/
@property(nonatomic,strong)NSMutableDictionary *sonChildScrollerViewDic;
/*
*子控制器中固定底部的视图
*/
@property(nonatomic,strong)NSMutableDictionary *sonChildFooterViewDic;
/*
*子控制器固定底部如果不是位于最左边  可设置此属性 默认为0
*/
@property(nonatomic,assign)CGFloat footViewOrginX;
/*
*子控制器固定底部y值 default 最底部-height
*/
@property(nonatomic,assign)CGFloat footViewOrginY;
/*
*透明视图
*/
@property (nonatomic, strong) UIView *naviBarBackGround;
/*!
*
* @brief 更新全部(会全部重新渲染)
*/
- (void)updatePageController;

/*!
* @brief 更新头部
*/
- (void)updateHeadView;

/*!
* @brief 更新菜单栏
*/
- (void)updateMenuData;

/*!
* @brief 标题数量内容不变情况下只更新内容
*/
- (void)updateTitle;

/*!
* @brief 底部手动滚动 传入CGPointZero则为吸顶临界点
* @param point 滚动的坐标
* @param animat 滚动动画
*/
- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;

/*!
* @brief 手动调用菜单到第index个
* @param index 对应下标
*/
- (void)selectMenuWithIndex:(NSInteger)index;

//⚠️使用动态的方法传入的控制器必须使用 wControllers

/*!
* @brief 动态插入菜单数据
* @param insertObject 插入对应model
*/
- (BOOL)addMenuTitleWithObject:(WMZPageTitleDataModel*)insertObject;

/*!
* @brief 动态删除菜单数据
* @param deleteObject 删除的对应下标 如@(1) 或者 传入的标题对象
*/
- (BOOL)deleteMenuTitleIndex:(id)deleteObject;


/*!
* @brief 动态插入菜单数组
* @param insertArr 插入对应model的数组
*/
- (BOOL)addMenuTitleWithObjectArr:(NSArray<WMZPageTitleDataModel*>*)insertArr;

/*!
* @brief 动态删除菜单数组
* @param deleteArr @[ 如@(1) 或者 传入的标题对象]
*/
- (BOOL)deleteMenuTitleIndexArr:(NSArray*)deleteArr;


/*!
* @brief 动态交换菜单标题位置
* @param index 需要交换的位置
* @param replaceIndex 交换完的位置
*/
- (BOOL)exchangeMenuDataAtIndex:(NSInteger)index withMenuDataAtIndex:(NSInteger)replaceIndex;

@end

NS_ASSUME_NONNULL_END
