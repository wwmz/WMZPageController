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
//参数
@property(nonatomic,strong)WMZPageParam *param;
//头部标题滚动视图
@property(nonatomic,strong)WMZPageLoopView *upSc;
//底部全屏滚动视图
@property(nonatomic,strong)WMZPageScroller *downSc;
//缓存
@property(nonatomic,strong)NSCache *cache;
//子控制器中可以滚动的视图
@property(nonatomic,strong)NSMutableDictionary *sonChildScrollerViewDic;
//子控制器中固定底部的视图
@property(nonatomic,strong)NSMutableDictionary *sonChildFooterViewDic;

//子控制器固定底部如果不是位于最左边  可设置此属性 默认为0
@property(nonatomic,assign)CGFloat footViewOrginX;
//子控制器固定底部宽度如果不是整个屏幕  可设置此属性 默认为底部滚动视图的宽度
@property(nonatomic,assign)CGFloat footViewSizeWidth;
//子控制器固定底部y值 default 最底部-height
@property(nonatomic,assign)CGFloat footViewOrginY;

/*
 *更新
 */
- (void)updatePageController;

/*
*更新头部
*/
- (void)updateHeadView;

/*
*底部手动滚动  传入CGPointZero则为吸顶临界点
*/
- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;

/*
*手动调用菜单到第index个
*/
- (void)selectMenuWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
