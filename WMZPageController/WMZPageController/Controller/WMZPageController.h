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

//导航栏背景色  //特殊情况自行处理
@property(nonatomic,strong)UIView *naviBarBackGround;
//参数
@property(nonatomic,strong)WMZPageParam *param;
//frame数组  如果出现frame不准确 可以手动调节一下这个数组的内容 [NSValue 存的rect]
@property(nonatomic,strong)NSMutableArray *rectArr;
//头部标题滚动视图
@property(nonatomic,strong)WMZPageLoopView *upSc;
//底部全屏滚动视图
@property(nonatomic,strong)WMZPageScroller *downSc;
//缓存
@property(nonatomic,strong)NSCache *cache;
//子控制器中可以滚动的视图
@property(nonatomic,strong)NSMutableDictionary *sonChildScrollerViewDic;
/*
 *更新
 */
- (void)updatePageController;

@end

NS_ASSUME_NONNULL_END
