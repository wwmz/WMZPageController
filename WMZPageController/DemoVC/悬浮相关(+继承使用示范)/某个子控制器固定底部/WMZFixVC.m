//
//  WMZFixVC.m
//  WMZPageController
//
//  Created by wmz on 2020/1/6.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFixVC.h"
#import "CollectionViewPopDemo.h"
#import "FixSonVC.h"
#import "UIImageView+WebCache.h"
@interface WMZFixVC ()

@end

@implementation WMZFixVC

- (void)viewDidLoad {
    [super viewDidLoad];
      WMZPageParam *param = PageParam()
      .wTitleArrSet(@[@"热门",@"分类",@"推荐"])
      .wControllersSet(@[[CollectionViewPopDemo new],[FixSonVC new],[CollectionViewPopDemo new]])
      //固定在所有子控制器底部  需要放在第一个控制器里 例如此例子
//     .wControllersSet(@[[FixSonVC new],[CollectionViewPopDemo new],[CollectionViewPopDemo new]])
//     .wFixFirstSet(YES)
      //悬浮开启
      .wTopSuspensionSet(YES)
      //等分
      .wMenuTitleWidthSet(PageVCWidth/3)
      //头视图y坐标从0开始
      .wFromNaviSet(NO)
      //导航栏透明度变化
      .wNaviAlphaSet(YES)
      //头部
      .wMenuHeadViewSet(^UIView *{
          UIView *back = [UIView new];
          back.frame = CGRectMake(0, 0, PageVCWidth, 370+PageVCStatusBarHeight);
          UIImageView *image = [UIImageView new];
          [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579082&di=f6ae983436a2512d41ed5b25789cf212&imgtype=0&src=http%3A%2F%2Fbig5.ocn.com.cn%2FUpload%2Fuserfiles%2F18%252858%2529.png"]];
          image.frame =back.bounds;
          [back addSubview:image];
          return back;
      });
      self.param = param;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:PageColor(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"第二个控制器滚动到最底部" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)onBtnAction:(id)sender{
//    [self downScrollViewSetOffset:CGPointZero animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setDowmScContenOffset" object:nil];
}
@end
