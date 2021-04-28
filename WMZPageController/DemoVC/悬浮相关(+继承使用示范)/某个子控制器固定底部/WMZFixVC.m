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
       //控制器数组
       .wViewControllerSet(^UIViewController *(NSInteger index) {
           if (index == 1) return [FixSonVC new] ;
           return [CollectionViewPopDemo new];
       })

      //固定在所有子控制器底部  需要放在第一个控制器里 例如此例子
//       .wViewControllerSet(^UIViewController *(NSInteger index) {
//          if (index == 0) return [FixSonVC new] ;
//          return [CollectionViewPopDemo new];
//        })
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
          [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
          image.frame =back.bounds;
          [back addSubview:image];
          return back;
      });
      self.param = param;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:PageColor(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"滚动到顶部" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)onBtnAction:(id)sender{
    [self downScrollViewSetOffset:CGPointZero animated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setDowmScContenOffset" object:nil];
}
@end
